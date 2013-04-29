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

  int type = 0;
  int futType = 0;

  ///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR  
  Cell(Vec3D _loc, int _x, int _y) {
    loc = _loc;
    x = _x;
    y = _y;

    float rand = random(1);
    if (rand < 0.5) {
      type = 1;
    }
  }


  ///////////////////////////////////////////////////////////////////////////////////FUNCTIONS
  //main function
  void run() {
    display();
    evalN();
  }



  //function to update the type of the cell at the end of the loop
  void updateType() {
    type = futType;
  }
  
  //function to evaluate the state of the neighbour cells
  void evalN() {
    
    int count = 0; //counter for the number of active cells
    
    // checking the status of each of the neightbouring cells
    if (grid[(x + cols - 1)%cols][(y + rows - 1)%rows].type == 1) count++;
    if (grid[(x + cols - 1)%cols][(y + rows)%rows].type == 1) count++;
    if (grid[(x + cols - 1)%cols][(y + rows  + 1)%rows].type == 1) count++;
    if (grid[(x + cols)%cols][(y + rows - 1)%rows].type == 1) count++;
    if (grid[(x + cols)%cols][(y + rows + 1)%rows].type == 1) count++;
    if (grid[(x + cols + 1)%cols][(y + rows - 1)%rows].type == 1) count++;
    if (grid[(x + cols + 1)%cols][(y + rows)%rows].type == 1) count++;
    if (grid[(x + cols + 1)%cols][(y + rows + 1)%rows].type == 1) count++;
    
    // rule 1: if the cells is alive and there are less than two alive cells in the nightbourood, the cell dies
    if (type == 1 && count < 2) {
      futType = 0;
    }
    
    // rule 2: if the cell is alive and there are two or three active cells in the neighbourhood, the cell stays alive
    if (type == 1 && count <= 3 && count >= 2) {
      futType = 1;
    }
    
    // rule 3: if the cell is alive and there are more than three alive cells in the neighbourhood, the cell dies
    if (type == 1 && count > 3) {
      futType = 0;
    }
    
    // if the cell is deat and there are exactrly three cells alive in the neighbourhood, the cell becomes alive
    if (type == 0 && count == 3) {
      futType = 1;
    }
  }

  //cell display according to the type
  void display() {
    if (type == 1) {
      noStroke();
      fill(0);
      rectMode(CENTER);
      rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
    }
  }
}

