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
 * This code is partially based on a tutorial by Daniel Shiffman, available online at: http://vimeo.com/shiffman
 * Libraries: Toxiclibs
 */

/* 
 * DAY01_EXE06
 * creating an array of ball objects
 *
 */

/*
 * CONTROLS:
 * Move the mouse to attract the ball towards it
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


