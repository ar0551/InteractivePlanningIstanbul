///////////////////////////////////////////////////////////////////////////////////CONTROL KEYS
void keyPressed() {
  if (key == 'f') {
    saveFrame("framesOut/frame" + frameCount + ".png"); // save a .png file of the current frame
  }  
  if (key == 'l') {
    cameraLock = !cameraLock; // lock the camera
  }
  if (key == 'g') { // show/hide the gui
    showGui = !showGui;
  }


  if (key == '1') {
    showBuilt = !showBuilt; //show houses
  }
  if (key == '2') {
    showInfrastructure = !showInfrastructure; // show roads
  }
  if (key == '3') {
    showPotential = !showPotential; // show potential map
  }

  if (key == 'e') {
    explodedView = !explodedView; //show exploded view
  }
}


