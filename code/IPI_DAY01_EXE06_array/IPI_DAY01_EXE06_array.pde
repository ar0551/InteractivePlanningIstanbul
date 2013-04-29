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
 * Libraries: Toxiclibs
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
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
Ball[] balls; // array of instaces of the ball class


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(640, 360);
  balls = new Ball[100]; // initialize the array with the size of 100 elements (the size is fixed!)
  for (int i=0; i<balls.length; i ++) { // create a new ball for each of the 100 places in the array
    balls[i]= new Ball();
  }
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255);
  for (Ball b:balls) { // go throught the array and run each ball
    b.run();
  }
}


