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
 * DAY01_EXE01
 * Basic script drawing a rectancgle in the middle of the screen
 *
 */


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(640, 360); //define the size of the sketch window
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255); //color of the background
  fill(150, 150); // fill color for the rectangle
  stroke(0); // stroke color for the rectangle
  strokeWeight(0.5); // weight of the stroke line
  rect(width/2, height/2, 20, 20); // draw a rectangle rect(upper-left corner x, upper-left corner y, size x, size y)
}

