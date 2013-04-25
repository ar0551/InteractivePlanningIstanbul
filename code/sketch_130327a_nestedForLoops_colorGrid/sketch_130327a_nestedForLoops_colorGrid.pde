import toxi.geom.*;

int cols = 50;
int rows = 50;

float xSize;
float ySize;

int colorCount = 0;
float colorFreq = 50;


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

void draw() {
  background(0);


  //nested for loops
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      stroke(255, 100);
      strokeWeight(1);


      fill(random(0,255), random(0,255), random(0,255));
      
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
      rect(i*xSize, j*ySize, xSize, ySize);
    }
  }
  colorCount++;
}

