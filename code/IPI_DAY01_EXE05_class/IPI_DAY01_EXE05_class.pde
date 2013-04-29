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
Ball b;

void setup() {
  size(640, 360);
  b = new Ball(); // create a new istance of the ball class
}

void draw() {
  background(255);
  
  b.run(); // call the main function of the ball class
}




