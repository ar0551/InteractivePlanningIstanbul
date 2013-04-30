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
 * DAY01_EXE07
 * creating an arrayList of ball objects, adding and removing them with controls
 *
 */

/*
 * CONTROLS:
 * Move the mouse to attract the balls towards it
 * MouseLeftClick_ create new ball objects
 * AnyKey_ delete all the ball objects
 * 
 */


///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
ArrayList balls; // arraylist that will contain the instances of the ball class


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(640, 360);
  balls = new ArrayList(); // initialize the arraylist (the size is free and will adapt to each new element added)
  for (int i=0; i < 10; i++) { // create 10 instances of the ball class
    Ball b = new Ball(); // create an instance of the ball class
    balls.add(b); // add the ball b to the arraylist
  }
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(255);
  for (int i = 0; i < balls.size(); i++) { // go throught the array and run each ball
    Ball b = (Ball) balls.get(i); // extract a ball from the arraylist
    b.run(); // run the ball main function
  }
  
  // adding new balls if the mouse is pressed
  if(mousePressed){
    Ball b = new Ball(); // create an instance of the ball class
    balls.add(b); // add the ball b to the arraylist
  }
  
  // removing all the balls if a key is pressed
  if(keyPressed){
    balls.clear();
  }
}

