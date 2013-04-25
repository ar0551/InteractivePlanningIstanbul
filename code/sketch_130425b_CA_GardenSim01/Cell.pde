///////////////////////////////////////////////////////////////////////////////////CLASS CELL
class Cell {
  
  /*
   * Cell class defining the CA grid
   * type 0 = empty cell
   * type 1 = room cell
   * type 2 = garden cell
   */
   
///////////////////////////////////////////////////////////////////////////////////VARIABLES  
  Vec3D loc;
  int x;
  int y;

  color col;

  int type = 0;
  int futType = 0;
  
///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR  
  Cell(Vec3D _loc, int _x, int _y) {
    loc = _loc;
    x = _x;
    y = _y;
  }
  
  
///////////////////////////////////////////////////////////////////////////////////FUNCTIONS
  //main function
  void run() {
    display();
  }
  
  //function to update the type of the cell at the end of the loop
  void updateType() {
    type = futType;
  }
  
  //cell display according to the type
  void display() {
    if (type == 1) {
      noStroke();
      fill(col);
      rectMode(CENTER);
      rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
    }
    if (type == 2) {
      noStroke();
      fill(182, 211, 0);
      rectMode(CENTER);
      rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
    }
  }
}

