///////////////////////////////////////////////////////////////////////////////////CLASS CELL
class Cell {

  /*
   * Cell class defining the CA grid
   * type 0 = dead cell
   * type 1 = alive cell 
   */

  ///////////////////////////////////////////////////////////////////////////////////VARIABLES  
  Vec3D loc;
  int x;
  int y;

  color col;

  int grains;

  ///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR  
  Cell(Vec3D _loc, int _x, int _y, int _grains) {
    loc = _loc;
    x = _x;
    y = _y;

    grains = _grains;
  }


  ///////////////////////////////////////////////////////////////////////////////////FUNCTIONS
  //main function
  void run() {
    display();
    if (addSandGrains) {
      addSand();
    }
    topple();
  }

  void addSand() {
    float rand = random(1);
    if (rand < 0.02) {
      grains += int(random(pouringAmount));
    }

    grains = constrain(grains, 0, 255);
  }

  void topple() {
    if (x != 0 && x != cols - 1 && y != 0 && y != rows - 1) {
      if (grid[x - 1][y].grains + topplingAngle < grains) {
        grains--;
        grid[x - 1][y].grains++;
      }

      if (grid[x + 1][y].grains + topplingAngle < grains) {
        grains--;
        grid[x + 1][y].grains++;
      }

      if (grid[x][y - 1].grains + topplingAngle < grains) {
        grains--;
        grid[x][y - 1].grains++;
      }

      if (grid[x][y + 1].grains + topplingAngle < grains) {
        grains--;
        grid[x][y + 1].grains++;
      }
    }
  }


  //cell display according to the type
  void display() {
    if (x != 0 && x != cols - 1 && y != 0 && y != rows - 1) {
      noStroke();
      fill(grains);
      rectMode(CENTER);

      if (show3D) {
        pushMatrix();
        translate(0, 0, grains);
        rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
        popMatrix();
      }
      else {
        rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
      }
    }
  }
}

