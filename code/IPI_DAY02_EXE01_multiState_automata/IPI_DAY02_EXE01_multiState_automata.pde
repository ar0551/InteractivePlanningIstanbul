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
 * Code based on a tutorial by Jose Sanchez, available online at: http://vimeo.com/21056846
 * Libraries: Toxiclibs, PeasyCam
 */

/* 
 * DAY02_EXE01
 * Multi-State Automata: Simple Sand piles formation
 *
 */

/* 
 * CONTROLS:  
 * LeftMouseButton: orbit
 * CenterMouseButton: pan
 * RightMouseButton: zoom
 * 
 * a_ add/stop sand grains
 * 3_ show dunes in 3D
 * r_ reset the simulation
 *
 */



///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import peasy.*;
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
PeasyCam cam; //camera

int cols = 100; //num of cells in x direction
int rows = 100; //num of cells in y direction
float dim = 10; //cell size

Cell[][] grid = new Cell[cols][rows]; //2D array containing all the cells of the grid

int sandStartingAmount = 100;
int topplingAngle = 8;
int pouringAmount = 50;

boolean addSandGrains = false;
boolean show3D = true;


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  //p5 size and rendering mode setup
  size(1280, 720, OPENGL);
  smooth(); //smooth visualization (works just with OPENGL renderer)
  frameRate(24); //frames per second

  cam = new PeasyCam(this, (cols*dim)/2, (rows*dim)/2, 0, 900); //camera setup: new PeasyCam(this, lookAtX, lookAtY, lookAtZ, distance)
  cam.rotateX(-PI/3);
  
  //grid 2d array setup
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      Vec3D ptLoc = new Vec3D(i*dim, j*dim, 0); //cell location
      grid[i][j] = new Cell(ptLoc, i, j, floor(random(sandStartingAmount))); //cell creation
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255); //background color
  
  //sketch boundary rectangle
  stroke(0);
  noFill();
  rectMode(CORNER);
  rect(0, 0, cols*dim, rows*dim);
  
  
  //run the cells main function
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].run();
    }
  }
}
