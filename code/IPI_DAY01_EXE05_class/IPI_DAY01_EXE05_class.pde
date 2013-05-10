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
 * This code is based on a tutorial by Daniel Shiffman, available online at: http://vimeo.com/shiffman
 * Libraries: Toxiclibs
 */

/* 
 * DAY01_EXE05
 * creating a ball object seeking the mouse location
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
Ball b;

void setup() {
  size(640, 360);
  b = new Ball(); // create a new istance of the ball class
}

void draw() {
  background(255);
  
  b.run(); // call the main function of the ball class
}




