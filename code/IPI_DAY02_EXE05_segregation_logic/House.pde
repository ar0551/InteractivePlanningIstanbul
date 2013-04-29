///////////////////////////////////////////////////////////////////////////////////CLASS HOUSE
class House {

  ///////////////////////////////////////////////////////////////////////////////////VARIABLES
  ArrayList <Vec3D> rooms;
  ArrayList <Vec3D> gardens;
  float income;
  float totIncome;
  int maxNumRooms;
  float roomPrice = 250;
  Vec3D loc;
  
  String group;
  int prevConnectionsAmount = 0;
  ArrayList <Vec3D> connections;
  


  ///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR
  House(Vec3D _loc, float _income, int _maxNumRooms, String _group) {
    loc=_loc;
    income= _income;
    maxNumRooms = _maxNumRooms;
    grid[int(loc.x)][int(loc.y)].futType = 1; //initialize future type to 1 in order to turn the cell to type 1 (occupied) at the next loop
    
    group = _group;
    
    rooms = new ArrayList <Vec3D> ();
    rooms.add(loc); //add the start cell in the collection fo rooms

    gardens = new ArrayList <Vec3D> ();
    garden(loc); // create gardens
    
    connections = new ArrayList <Vec3D> ();
  }


  ///////////////////////////////////////////////////////////////////////////////////FUNCTIONS  
  //main function
  void run() {
    //check if expand the house
    if (rooms.size() < maxNumRooms) {
      income();
    }
    
    //functions computing the connectivity diagram and the potential maps for every group
    setConnection(clusterDistance);
    computePotential();
    
    display();
  }
  
  
  //calculate potential il the neighborhood based on the proximity graph size
  void computePotential() {
    if (prevConnectionsAmount != connections.size()) { // check if the number of connections is changed and so if the potential should be updated
      
      int x = int(loc.x);
      int y = int(loc.y);
      
      for (int i = 0; i < connections.size() - prevConnectionsAmount; i++) {
        for (int j = -connections.size() + i ; j <= connections.size() - i; j++) {
          for (int k = -connections.size() + i; k <= connections.size() - i; k++) {
            if (x + j > 0 && x + j < cols && y + k > 0 && y + k < rows) {
              if (j == connections.size() - i || j == -connections.size() + i || k == connections.size() - i || k == -connections.size() + i) {
                
                if (group == "sunni") {
                  grid[x + j][y + k].potentialSunni += 1/float(connections.size() - i);
                }
                else if (group == "alevi") {
                  grid[x + j][y + k].potentialAlevi += 1/float(connections.size() - i);
                }
                else if (group == "kurd") {
                  grid[x + j][y + k].potentialKurd += 1/float(connections.size() - i);
                }

                grid[x + j][y + k].potentialSunni = constrain(grid[x + j][y + k].potentialSunni, 0, 1);
                grid[x + j][y + k].potentialAlevi = constrain(grid[x + j][y + k].potentialAlevi, 0, 1);
                grid[x + j][y + k].potentialKurd = constrain(grid[x + j][y + k].potentialKurd, 0, 1);
              }
            }
          }
        }
      }
    }
    prevConnectionsAmount = connections.size();
  }

  //generate proximity graph according to clustering distance and social group
  void setConnection(float maxdist) {
    connections= new ArrayList(); // reset the connections list
    
    // check all the other houses for connection
    for ( int i=0; i < houses.size(); i++) {
      House h = (House) houses.get(i);
      
      if (h.group==group && h.loc != loc) { //checking if the two house are from the same group and if they are not the same house
        float distance = h.loc.distanceTo(loc); // check the distance between the houses
        if (distance <maxdist) {
          Vec3D v = new Vec3D(i, 0, 0); // add the house to the connections list
          connections.add(v);
        }
      }
    }
  }
  
  // garden creation
  // the function gets called just once in the initialization of the class and creates the plot for the expansion of the house
  void garden(Vec3D r) {
    
    // receives the x and y indexes of the center cell of the house
    int x = int(r.x);
    int y = int(r.y);
    
    // for loop exploring the 9-cells neighbourhood of the central cell
    for (int i = x - 1; i <= x + 1; i++) {
      for (int j = y - 1; j <= y + 1; j++) {
        if (i != x || j != y) { // check if the cell is not the center one
          if (grid[(i + cols) % cols][(j + rows) % rows].type == 0) { //check if the cell is empty and keep it within the boundaries of the world
            grid[(i + cols) % cols][(j + rows) % rows].futType = 2; //chakge cell type to garden
            Vec3D newLoc = new Vec3D(grid[(i + cols) % cols][(j + rows) % rows].x, grid[(i + cols) % cols][(j + rows) % rows].y, 0); //create a vector with stored the x and y indexes of the cell
            gardens.add(newLoc); // add cell indexes to the arraylist of gardens of the house
          }
        }
      }
    }
  }


  //income calculation and room addition function
  void income() {

    //increase the surplus income of the house
    totIncome = totIncome + income;

    //expand the house when the surplus income reaches a certain treshold
    if (totIncome > roomPrice) {
      //loop counters
      int count = 0;
      int breakCount = 0;

      //loop to randomize the position where to create the new room
      while (count == 0) {
        Vec3D r = (Vec3D) rooms.get(floor(random(rooms.size()))); //pick a random cell
        int x = int(r.x);
        int y = int(r.y);

        float rand = random(1); //generate a random value between 0 and 1

          if (rand < 0.25 && grid[(x + cols - 1)%cols][(y + rows)%rows].type == 2 && grid[(x + cols - 2)%cols][(y + rows)%rows].type != 1 ) { //check if the random value is within 0.25 and if the selected cell is empty and part of the garden of the house
          grid[(x + cols - 1)%cols][(y + rows)%rows].futType = 1; //switch the cell type from emty to occupied
          Vec3D newLoc = new Vec3D(grid[(x + cols - 1)%cols][(y + rows)%rows].x, grid[(x + cols - 1)%cols][(y + rows)%rows].y, 0); //create a vector with stored the x and y indexes of the cell
          rooms.add(newLoc); //add the cell to the rooms arraylist of the house
          count++; //increase the count to break out of the while loop
        }
        else if (rand < 0.5 && grid[(x + cols + 1)%cols][(y + rows)%rows].type == 2 && grid[(x + cols + 2)%cols][(y + rows)%rows].type != 1) {
          grid[(x + cols + 1)%cols][(y + rows)%rows].futType = 1;
          Vec3D newLoc = new Vec3D(grid[(x + cols + 1)%cols][(y + rows)%rows].x, grid[(x + cols + 1)%cols][(y + rows)%rows].y, 0);
          rooms.add(newLoc);
          count++;
        }
        else if (rand < 0.75 && grid[(x + cols)%cols][(y + rows - 1)%rows].type == 2 && grid[(x + cols)%cols][(y + rows - 2)%rows].type != 1) {
          grid[(x + cols)%cols][(y + rows - 1)%rows].futType = 1;
          Vec3D newLoc = new Vec3D(grid[(x + cols)%cols][(y + rows - 1)%rows].x, grid[(x + cols)%cols][(y + rows - 1)%rows].y, 0);
          rooms.add(newLoc);
          count++;
        }
        else if (rand < 1 && grid[(x + cols)%cols][(y + rows + 1)%rows].type == 2 && grid[(x + cols)%cols][(y + rows + 2)%rows].type != 1) {
          grid[(x + cols)%cols][(y + rows + 1)%rows].futType = 1;
          Vec3D newLoc = new Vec3D(grid[(x + cols)%cols][(y + rows + 1)%rows].x, grid[(x + cols)%cols][(y + rows + 1)%rows].y, 0);
          rooms.add(newLoc);
          count++;
        }

        //break count used to avoid getting stuck in infinite loops
        breakCount++;
        if (breakCount > 100) { //check if the sketch made more than 100 loops without finding an emty cell
          break; //interrupt the loop
        }
      }
      totIncome = 0; //reset the house income after construction of new room
    }
  }


  //display function
  // nothing is actually displayed here, the function just sets the color of visualization of the related cells
  void display() {
    color c = color(0);
    if (group == "sunni") {
      if (rooms.size() < maxNumRooms) {
        c = color(255 - int(map(totIncome, 0, roomPrice, 245, 47)), 46, 56);
      }
      else {
        c = color(245, 46, 56);
      }
    }

    else if (group == "alevi") {
      if (rooms.size() < maxNumRooms) {
        c = color(255 - int(map(totIncome, 0, roomPrice, 165, 0)), 0, 125);
      }
      else {
        c = color(165, 0, 125);
      }
    }

    else if (group == "kurd") {
      if (rooms.size() < maxNumRooms) {
        c = color(0, 71, 255 - int(map(totIncome, 0, roomPrice, 190, 0)));
      }
      else {
        c = color(0, 71, 190);
      }
    }

    for (int i = 0; i < rooms.size(); i++) {
      Vec3D v = (Vec3D) rooms.get(i);
      grid[int(v.x)][int(v.y)].col = c;
    }
    
    // show the connectivity graph
    if (showNetwork) {
      for ( int i=0; i< connections.size(); i++) {
        Vec3D v = (Vec3D) connections.get(i); // check the index of the house to connect
        House h= (House) houses.get(int(v.x)); // get the house to connect from the houses list
        int x1 = int(h.loc.x);
        int y1 = int(h.loc.y);

        int x2 = int(loc.x);
        int y2 = int(loc.y);
        
        // define colot according to group
        if (group == "sunni") {
          stroke(245, 46, 56);
        }
        else if (group == "alevi") {
          stroke(165, 0, 125);
        }
        else if (group == "kurd") {
          stroke(0, 71, 190);
        }
        
        //draw line between the two houses
        strokeWeight(2);
        line(grid[x1][y1].loc.x + dim/2, grid[x1][y1].loc.y + dim/2, grid[x1][y1].loc.z, grid[x2][y2].loc.x + dim/2, grid[x2][y2].loc.y + dim/2, grid[x2][y2].loc.z);
      }
    }
  }
}
