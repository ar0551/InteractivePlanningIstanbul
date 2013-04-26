///////////////////////////////////////////////////////////////////////////////////GRAPHIC USER INTERFACE

//drawing the gui on top of the 3D view
void gui3D() {
  currCameraMatrix = new PMatrix3D(g3.camera);
  camera();
  noStroke();
  fill(50, 100);
  rectMode(CORNER);
  rect(0, 0, 270, height);
  controlP5.draw();
  g3.camera = currCameraMatrix;
}

//gui setup
void gui() {  
  ///////////////////////////////////////////////////////chart
  controlP5 = new ControlP5(this); // initialize the gui
  controlP5.setAutoDraw(false); // deactivate the drawing of the gui (will be activated by the function gui3D)
  
  /////////////////////////sliders
  Controller mySlider1 = controlP5.addSlider("time", 0, 1000, time, 10, 10, 160, 10); // slider setup: controlP5.addSlider("name of the slider", minValue, maxValue, startValue, xLoc, yLoc, xSize, ySize)
  Controller mySlider2 = controlP5.addSlider("streetsInfluence", 0, 10, streetsInfluence, 10, 30, 160, 10);
  Controller mySlider3 = controlP5.addSlider("streetSearchRadius", 0, 500, streetSearchRadius, 10, 50, 160, 10);
  
  Controller mySlider4 = controlP5.addSlider("potentialTreshold", 0, 0.5, potentialTreshold, 10, 90, 160, 10).setDecimalPrecision(3); // changing the decimal precision of the slider
  
  Controller mySlider5 = controlP5.addSlider("roomPrice", 0, 500, roomPrice, 10, 130, 160, 10);
  Controller mySlider6 = controlP5.addSlider("minWage", 0, 50, minWage, 10, 150, 160, 10);
  Controller mySlider7 = controlP5.addSlider("maxWage", 0, 50, maxWage, 10, 170, 160, 10);
  
  Controller mySlider8 = controlP5.addSlider("clusterDistance", 0, 50, clusterDistance, 10, 210, 160, 10);
 
  Controller mySlider9 = controlP5.addSlider("roadFactor", 0, 1, roadFactor, 10, 250, 160, 10);
  Controller mySlider10 = controlP5.addSlider("clusteringFactor", 0, 1, clusteringFactor, 10, 270, 160, 10);
  Controller mySlider11 = controlP5.addSlider("segregationFactor", 0, 1, segregationFactor, 10, 290, 160, 10);
}

