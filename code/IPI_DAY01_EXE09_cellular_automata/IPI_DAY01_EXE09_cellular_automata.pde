/* 
 * 
 * INTERACTIVE_PLANNING_ISTANBUL WORKSHOP
 * MediaCities Conference 2013 - 3-5 May 2013
 * Buffalo State University of New York
 
 * Tutors: Lila PanahiKazemi, Andrea Rossi
 *
 * for more details: http://temporaryautonomousarchitecture.blogspot.de/
 * for questions regarding the script: a.rossi.andrea@gmail.com, lilapanahi@gmail.com
 *
 * All of the codes are licensed under a CreativeCommons Attribution-ShareAlike 3.0 license.
 * http://creativecommons.org/licenses/by-sa/3.0/
 *
 */

/*
 * Code based on a tutorial by Jose Sanchez, available online at: http://vimeo.com/21056846
 * Libraries: Toxiclibs, PeasyCam
 */

/* 
 * DAY01_EXE09
 * Cellular Automata: The Game of Life
 * For details: http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
 *
 */

/*
 * CONTROLS:
 * LeftMouseButton: orbit
 * CenterMouseButton: pan
 * RightMouseButton: zoom
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


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  //p5 size and rendering mode setup
  size(1280, 720, OPENGL);
  smooth(); //smooth visualization (works just with OPENGL renderer)
  frameRate(24); //frames per second

  cam = new PeasyCam(this, (cols*dim)/2, (rows*dim)/2, 0, 900); //camera setup: new PeasyCam(this, lookAtX, lookAtY, lookAtZ, distance)
  
  //grid 2d array setup
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      Vec3D ptLoc = new Vec3D(i*dim, j*dim, 0); //cell location
      grid[i][j] = new Cell(ptLoc, i, j); //cell creation
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
  
  //update the cells type
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      grid[i][j].updateType();
    }
  }
}
