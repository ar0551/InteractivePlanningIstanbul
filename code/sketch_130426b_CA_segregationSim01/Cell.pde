///////////////////////////////////////////////////////////////////////////////////CLASS CELL
class Cell {
  
  /*
   * Cell class defining the CA grid
   * type 0 = empty cell
   * type 1 = room cell
   * type 2 = garden cell
   * type 3 = street cell
   */
   
///////////////////////////////////////////////////////////////////////////////////VARIABLES  
  Vec3D loc;
  int x;
  int y;

  color col;

  int type = 0;
  int futType = 0;

  boolean origin = false;

  float potentialRoad = 0;
  float potentialSunni=0;
  float potentialAlevi=0;
  float potentialKurd=0;
  

///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR  
  Cell(Vec3D _loc, int _x, int _y, int _type, float _potentialRoad) {

    loc = _loc;

    x = _x;
    y = _y;

    type = _type;
    futType = _type;

    potentialRoad = _potentialRoad;
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

    if (showBuilt) {
      // show houses
      if (type == 1) {        
        pushMatrix(); // all the translations operated within pushMatrix() and popMatrix() are valid just for the commands typed in between them
        if (explodedView) { //if wanted to explode the view in layers, the layer gets translated on the z axis
          translate(0, 0, explodedAmount);
        }
        noStroke();
        fill(col);
        rectMode(CENTER);
        rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
        popMatrix();
      }
      
      //show gardens
      if (type == 2) {
        pushMatrix();
        if (explodedView) {
          translate(0, 0, explodedAmount);
        }
        noStroke();
        fill(182, 211, 0);
        rectMode(CENTER);
        rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
        popMatrix();
      }
    }
    
    //show streets
    if (showInfrastructure) {
      if (type == 3) {      
        noStroke();
        fill(199, 199, 199);
        rectMode(CENTER);
        rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
      }
    }
    
    //show different potential maps
    if (showPotential) {
      pushMatrix();
      if (explodedView) {
        translate(0, 0, -explodedAmount);
      }

      if (showPotentialRoad) {
        noStroke();
        float c = map(potentialRoad, 0, 1, 0, 199);
        fill(c, c, c);
      }
      if (showPotentialSunni) {
        noStroke();
        float c = map(potentialSunni, 0, 1, 0, 245);
        if (c> 0) {
          fill(c, 46, 56);
        }
        else {
          fill(122, 120, 120);
        }
      }
      if (showPotentialAlevi) {
        noStroke();
        float c = map(potentialAlevi, 0, 1, 0, 165);
        if (c > 0) {
          fill(c, 0, 125);
        }
        else {
          fill(122, 120, 120);
        }
      }
      if (showPotentialKurd) {
        noStroke();
        float c = map(potentialKurd, 0, 1, 0, 190);        
        if (c > 0) {
          fill(0, 71, c);
        }
        else {
          fill(122, 120, 120);
        }
      }

      rectMode(CENTER);
      rect(loc.x + dim/2, loc.y + dim/2, dim, dim);
      popMatrix();
    }
  }
}
