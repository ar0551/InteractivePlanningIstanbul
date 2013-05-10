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
 * Libraries: Toxiclibs 
 */

/* 
 * DAY01_EXE07
 * Using nester for loops to create a grid of changing color rectangles
 *
 */
 

///////////////////////////////////////////////////////////////////////////////////LIBRARIES
import toxi.geom.*;


///////////////////////////////////////////////////////////////////////////////////VARIABLES
int cols = 50;
int rows = 50;

float xSize;
float ySize;

int colorCount = 0;
float colorFreq = 50;


///////////////////////////////////////////////////////////////////////////////////SETUP
void setup() {
  size(800, 800);
  smooth();
  frameRate(24);

  //calculating the size of eache cell
  xSize = width/float(cols);     //it is necessary to add float() to avoid the rounding of the size to integer
  ySize = height/float(rows);

  //printing sizes vaules
  println("xSize: " + xSize + "; ySize: " + ySize);  //the text between "" will be printed as it is
}


///////////////////////////////////////////////////////////////////////////////////DRAW
void draw() {
  background(0);


  //nested for loops
  for (int i = 0; i < cols; i++) { // for loop going through the columns
    for (int j = 0; j < rows; j++) {  // for loop going through the rows
      stroke(255, 100);
      strokeWeight(1);


      fill(random(0, 255), random(0, 255), random(0, 255)); // chosing a random color

      //commenting the previous line and uncommenting all these lines makes the interpolation by colors based ona gradient

      //      float r = map(i, 0, cols, 0, 255);
      //      float g = map(j, 0, rows, 0, 255);
      //      float b = map(i+j, 0, cols + rows, 0, 255);
      //
      //      r *= sin(colorCount/colorFreq);
      //      g *= cos(colorCount/colorFreq);
      //      b *= cos(colorCount/colorFreq)*sin(colorCount/colorFreq);
      //      
      //      fill(r, g, b);

      rectMode(CORNER);
      rect(i*xSize, j*ySize, xSize, ySize); //drawing the rectangle at the location i, j in the grid
    }
  }
  colorCount++; // counter to interpolate color change
}

