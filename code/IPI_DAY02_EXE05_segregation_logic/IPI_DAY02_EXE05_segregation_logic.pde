/* 
 * Copyright (c) 2013-2014 Lila PanahiKazemi & Andrea Rossi
 * INTERACTIVE_PLANNING_ISTANBUL WORKSHOP
 * MediaCities Conference 2013 - 3-5 May 2013
 * Buffalo State University of New York
 *
 * for more details: http://temporaryautonomousarchitecture.blogspot.de/
 * for questions regarding the script: a.rossi.andrea@gmail.com, lilapanahi@gmail.com
 */

/*
 * Libraries: Toxiclibs, PeasyCam, ControlP5
 */
 
/* 
 * DAY02_EXE05
 * Informal Settlements Simulation #04: segregation logics
 * The last step of the simulation is to introduce different social groups and their segregation logics.
 * Each house is assigned to a specific group, and it connects in a network to the houses of the same group.
 * The resulting connectivity graphs determines a new potential fiels, that attracts houses of the same type in the location.
 * After a certain number of cycles, patterns of segregation between the different groups clearly emerge.
 *
 */

/* 
 * CONTROLS:  
 * LeftMouseButton: orbit
 * CenterMouseButton: pan
 * RightMouseButton: zoom
 *
 * 1_ display/hide houses
 * 2_ display/hide streets
 * 3_ display/hide the connectivity network
 * 4_ display/hide potential map
 * 6_ when displaying potential map, display the road potential map
 * 7_ when displaying potential map, display the Sunni potential map
 * 8_ when displaying potential map, display the Alevi potential map
 * 9_ when displaying potential map, display the Kurd potential map
 *
 * e_ activate/deactivate the exploded view mode
 * l_ lock/unlock the current camera state (useful when changing the sliders
 * g_ display/hide the graphic user interface
 * f_ save the current frame as .png file
 *
 */


///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import peasy.*;
import toxi.geom.*;
import controlP5.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
ControlP5 controlP5;
PMatrix3D currCameraMatrix;
PGraphics3D g3;

PeasyCam cam;
Timer timer;

int time = 50;

int cols = 100;
int rows = 100;
float dim = 10;

float roomPrice = 250;
float minWage = 5;
float maxWage = 25;

float streetsScaling = 25;
float streetsInfluence = 2;
float streetSearchRadius = 125;
float potentialTreshold = 0.001;

float clusterDistance = 10;

float roadFactor = 1; 
float clusteringFactor = 1;
float segregationFactor = 1;

ArrayList <Vec3D> streets;
Cell grid[][];
ArrayList <House> houses;

boolean showBuilt = true;
boolean showPotential = false;
boolean showInfrastructure = true;
boolean showNetwork = true;

boolean showPotentialRoad = true;
boolean showPotentialSunni = false;
boolean showPotentialAlevi = false;
boolean showPotentialKurd = false;

boolean cameraLock = false;
boolean showGui = true;
boolean explodedView = false;

float explodedAmount = 200;



///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  //p5 size and rendering mode setup
  size(1280, 720, OPENGL);
  smooth(); //smooth visualization (works just with OPENGL renderer)
  frameRate(24); //frames per second

  g3 = (PGraphics3D)g; // camera matrix to draw the gui on top of 3D

  cam = new PeasyCam(this, (cols*dim)/2, (rows*dim)/2, 0, 900); //camera setup: new PeasyCam(this, lookAtX, lookAtY, lookAtZ, distance)
  cam.setMinimumDistance(0.01);
  timer = new Timer(time); //timer that resets every "time" ms

  ///streets data import
  String[] streetsTemp;
  streetsTemp = loadStrings("dataIn/streets_test.txt"); // load the text file with the points coordinates
  streets = new ArrayList <Vec3D> ();
  for (int i = 0; i < streetsTemp.length; i++) { //go thorugh the lines on the text file
    String[] coord = split(streetsTemp[i], ","); // split each line in an array, dividing each of the coordinates of the point
    Vec3D p = new Vec3D(float(coord[0])*streetsScaling - 50, -float(coord[1])*streetsScaling + rows*dim, float(coord[2])*streetsScaling); // creating the point from the coordinates. Note that the y coorinate must be multiplied by -1
    streets.add(p); // add the new point to the streets arrayList
  }
  
  //grid 2d array setup
  grid = new Cell[cols][rows];

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      
      Vec3D ptLoc = new Vec3D(i*dim, j*dim, 0); // cell loc definition
      
      // check if the current cell is part of a street
      int t = 0;
      for (int k = 0; k < streets.size(); k++) {
        Vec3D v = (Vec3D) streets.get(k);
        if (v.x > i*dim - streetsInfluence && v.x < i*dim + dim + streetsInfluence && v.y > j*dim - streetsInfluence && v.y < j*dim + dim + streetsInfluence) { // check if the cell center is whitin distance of the size of the street
          t = 3; // define cell type as street type
          break; // interrupt the loop
        }
      }
      
      // calculation of the road distance potential for the cell      
      float pot = 0;
      Vec3D cp = null; // closest point
      float minDist = 1000; // minDistance
      
      for (int k = 0; k < streets.size(); k++) {
        Vec3D v = (Vec3D) streets.get(k);        
        float distance = v.distanceTo(ptLoc); // calculate distance of the cell from the current street point
        if (k == 0) {
          cp = new Vec3D(v.x, v.y, v.z); // initialize the closest point randomly
          minDist = distance; // initialize the min distance randomly
        }
        else {
          if (distance < minDist) { // check if the current distance is smaller than min Dist
            cp = new Vec3D(v.x, v.y, v.z); // define current point as closest point
            minDist = distance; // define current distance as min distance
          }
        }
      }
      
      // check if the min distance is within the road influence distance
      if (minDist < streetSearchRadius) {
        pot = map(minDist, 0, streetSearchRadius, 1, 0); // remap the value of min distance as potential between 0 and 1
      }
      else {
        pot = 0; // reset the potential if the min distance is bigger than the road influence distance
      }

      grid[i][j] = new Cell(ptLoc, i, j, t, pot); // create the cell with all the computed values
    }
  }

  //initialization of houses arraylist
  houses = new ArrayList <House>();
  
  // initalize the graphic user interface
  gui();

  // start the timer
  timer.start();
}

void draw() {
  background(255); //background color
  
  // lock the camera when requested
  if (cameraLock) {
    CameraState state = cam.getState(); // copy the camera state
    cam.setState(state); // set the camera state as the previous camera state
  }

  //sketch boundary rectangle
  stroke(0);
  noFill();
  rectMode(CORNER);
  rect(0, 0, cols*dim, rows*dim);
  
  //sketch buonday rectangles translated for exploded view
  if (explodedView) {
    pushMatrix();
    translate(0, 0, explodedAmount);
    rect(0, 0, cols*dim, rows*dim);
    popMatrix();

    pushMatrix();
    translate(0, 0, -explodedAmount);
    rect(0, 0, cols*dim, rows*dim);
    popMatrix();
  }
  
  
  // new house creation
  if (timer.isFinished()) { // check if timer is finished
    
    // define randomly the group of each of the new houses
    float rand1 = random(1);
    String group;
    if (rand1 < 0.33 ) {
      group = "sunni";
    }
    else if (rand1 < 0.66) {
      group = "alevi";
    }
    else {
      group = "kurd";
    }
    
    // search for the right location combining potentials
    int count = 0;
    int breakCount = 0;
    Vec3D loc = null;
    
    while (count == 0) { // loop to find an available cell
      int neighbourhoodSize = 1; // define the size of the neighbourhood
      int x = floor(random(neighbourhoodSize, cols - neighbourhoodSize)); // pick random column
      int y = floor(random(neighbourhoodSize, rows - neighbourhoodSize)); // pick random row
      
      // check if all the cells in the cell neighbourhood are empty
      boolean emptyBoundary = true;
      for(int i = x - neighbourhoodSize; i <= x + neighbourhoodSize; i++){
        for(int j = y - neighbourhoodSize; j <= y + neighbourhoodSize; j++){
          if(grid[i][j].type != 0){ // check if the current cell in the neighbourhood is empty
            emptyBoundary = false;
            break; // exit the for loops if a single cell is not empty
          }          
        }
        if(!emptyBoundary){
          break; // exit the for loops if a single cell is not empty
        }
      }
      
      // create a new house if the all neighbourhood is empty
      if (emptyBoundary) {
        float totalPotential = 0;
        float rand = random(1);
        
        // define the potential of the cell according to road distance and social group
        if (group == "sunni") { // potential sunni = road + sunni - alevi - kurd
          totalPotential = (grid[x][y].potentialRoad*roadFactor + grid[x][y].potentialSunni*clusteringFactor - grid[x][y].potentialAlevi*segregationFactor - grid[x][y].potentialKurd*segregationFactor)/4;
        }
        else if (group == "alevi") { // potential alevi = road - sunni + alevi + kurd
          totalPotential = (grid[x][y].potentialRoad*roadFactor - grid[x][y].potentialSunni*segregationFactor + grid[x][y].potentialAlevi*clusteringFactor + grid[x][y].potentialKurd*clusteringFactor)/4;
        }
        else if (group == "kurd") { // potential sunni = road - sunni + alevi + kurd
          totalPotential = (grid[x][y].potentialRoad*roadFactor - grid[x][y].potentialSunni*segregationFactor + grid[x][y].potentialAlevi*clusteringFactor + grid[x][y].potentialKurd*clusteringFactor)/4;
        }
        
        
        if (rand < (totalPotential + potentialTreshold)) { // check if a random value is included in the potential of the cell
          loc = new Vec3D(x, y, 0); // define the location of the house
          count++; //increase count to exit the while loop
        }
      }
      
      // using a counter to exit the while loop after 100 loops, in order to avoid infinite loops
      breakCount++;
      if (breakCount > 100) {
        break;
      }
    }
    
    // creating the house with the defined values
    if (loc != null) {
      House h = new House(loc, random(minWage, maxWage), floor(random(2, 7)), group);
      grid[int(loc.x)][int(loc.y)].origin = true; //set the current cell as origin of one of the houses
      houses.add(h);
    }
    
    timer.start(); //restart the timer
  }

  //run the houses main function
  for (House h : houses) {
    h.run();
  }

  //run the cells main function
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].run();
    }
  }

  //update the cells type
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].updateType();
    }
  }

  //display the streets points
  if (showInfrastructure) {
    stroke(75);
    strokeWeight(2);
    for (Vec3D v : streets) {      
      point(v.x, v.y);
    }
  }
  
  // draw the gui
  if (showGui) {
    pushStyle();
    noLights();
    gui3D();
    popStyle();
  }
}

