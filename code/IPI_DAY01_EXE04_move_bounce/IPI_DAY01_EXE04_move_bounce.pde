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
 * The code is based on a tutorial by Daniel Shiffman, available online at: http://vimeo.com/shiffman
 * Libraries: Toxiclibs
 */

/* 
 * DAY01_EXE04
 * Bouncing ball 
 *
 */


///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
Vec3D location;
Vec3D acceleration;
Vec3D velocity;


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(640, 360);
  location = new Vec3D(width/2, height/2, 0);
  velocity = new Vec3D(0.1, 0.0, 0);
  acceleration = new Vec3D(0, 0.05, 0);
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255);

  // draw the particle
  fill(150, 150);
  stroke(0);
  strokeWeight(0.5);
  ellipse(location.x, location.y, 20, 20);
  
  //move
  location.addSelf(velocity); // add the velocity value to the location
  velocity.addSelf(acceleration); // add the acceleration value to the velocity
  
  //bounce
  if (location.x>width) { //check if the location x is bigger than the size of the sketch window
    location.x = width;
    velocity.x *= -1; //invert the velocity
  }
  
  if (location.x<0) {
    location.x=0;
    velocity.x*=-1;
  } 
  
  if (location.y>height) {
    location.y=height;
    velocity.y*=-1;
  }
  
  if (location.y<0) {
    location.y=0;
    velocity.y*=-1;
  }
}



