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
    showBuilt = !showBuilt;
  }
  if (key == '2') {
    showInfrastructure = !showInfrastructure;
  }
  if (key == '3') {
    showNetwork = !showNetwork;
  }
  if (key == '4') {   
    showPotential = !showPotential;
  }

  if (key == '6') {
    showPotentialRoad = true;
    showPotentialSunni = false;
    showPotentialAlevi = false;
    showPotentialKurd = false;
  }

  if (key == '7') {
    showPotentialRoad = false;
    showPotentialSunni = true;
    showPotentialAlevi = false;
    showPotentialKurd = false;
  }

  if (key == '8') {
    showPotentialRoad = false;
    showPotentialSunni = false;
    showPotentialAlevi = true;
    showPotentialKurd = false;
  }

  if (key == '9') {
    showPotentialRoad = false;
    showPotentialSunni = false;
    showPotentialAlevi = false;
    showPotentialKurd = true;
  }

  if (key == 'e') {
    explodedView = !explodedView; //show exploded view
  }
}

