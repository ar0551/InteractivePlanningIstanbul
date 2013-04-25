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
 * Libraries: Toxiclibs, PeasyCam
 */

/* 
 * CONTROLS: 
 *
 */

/*
 * INSTRUCTIONS
 * 
 */



///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import peasy.*;
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
PeasyCam cam; //camera
Timer timer; //timer to control the creation of new houses

int cols = 100; //num of cells in x direction
int rows = 100; //num of cells in y direction
float dim = 10; //cell size

Cell grid[][] = new Cell[cols][rows]; //2D array containing all the cells of the grid
ArrayList <House> houses; //Arraylist containing the instances of House class


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  //p5 size and rendering mode setup
  size(1280, 720, OPENGL);
  smooth(); //smooth visualization (works just with OPENGL renderer)
  frameRate(24); //frames per second

  cam = new PeasyCam(this, (cols*dim)/2, (rows*dim)/2, 0, 900); //camera setup: new PeasyCam(this, lookAtX, lookAtY, lookAtZ, distance)
  timer = new Timer(50); //timer that resets every 50ms

  //grid 2d array setup
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      Vec3D ptLoc = new Vec3D(i*dim, j*dim, 0); //cell location
      grid[i][j] = new Cell(ptLoc, i, j); //cell creation
    }
  }

  //initialization of houses arraylist
  houses = new ArrayList <House>();
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255); //background color

  //sketch boundary rectangle
  stroke(0);
  noFill();
  rectMode(CORNER);
  rect(0, 0, cols*dim, rows*dim);

  //houses creation at every timestep of the timer
  if (timer.isFinished()) { //check timer status
    int x = floor(random(cols)); //pick random column in the grid
    int y = floor(random(rows)); //pick random row in the grid
    if (grid[x][y].type == 0) { //check if the cell is not already occupied
      Vec3D loc = new Vec3D(x, y, 0); //pick the location of one random cell
      House h = new House(loc, random(5, 20), floor(random(2, 8))); //create a house on the cell(x,y)
      houses.add(h); //add the house to the arraylist
    }
    timer.start(); //restart the timer
  }

  //run the houses main main
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
}

