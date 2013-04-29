void keyPressed() {
  if (key == 'a') {
    addSandGrains = !addSandGrains;
  }

  if (key == '3') {
    show3D = !show3D;
  }

  if (key == 'r') {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].grains = int(random(sandStartingAmount));        
      }
    }
  }
}

