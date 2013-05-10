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
 * DAY01_EXE02
 * Drawing a rectangle in the mouse location
 *
 */

/*
 * CONTROLS:
 * move the mouse to draw different rectangles
 *
 */


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(640, 360); //define the size of the sketch window
  background(255); //color of the background. Putting it in the setup will not refresh the background at each frame
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  //background(255);


  //interaction
  fill(150, 150); // fill color for the rectangle
  stroke(0); // stroke color for the rectangle
  strokeWeight(0.5); // weight of the stroke line
  rect(mouseX, mouseY, 20, 20); // mouseX and mouseY store at everyframe the current mouse position
}


