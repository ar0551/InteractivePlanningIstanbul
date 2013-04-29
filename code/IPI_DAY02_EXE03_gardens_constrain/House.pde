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


  ///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR
  House(Vec3D _loc, float _income, int _maxNumRooms) {
    loc=_loc;
    income= _income;
    maxNumRooms = _maxNumRooms;
    grid[int(loc.x)][int(loc.y)].futType = 1; //initialize future type to 1 in order to turn the cell to type 1 (occupied) at the next loop

    rooms = new ArrayList <Vec3D> ();
    rooms.add(loc); //add the start cell in the collection fo rooms

    gardens = new ArrayList <Vec3D> ();
    garden(loc); // create gardens
  }


  ///////////////////////////////////////////////////////////////////////////////////FUNCTIONS  
  //main function
  void run() {
    //check if expand the house
    if (rooms.size() < maxNumRooms) {
      income();
    }
    display();
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

    // define the color based on the current income
    color c;
    if (rooms.size() < maxNumRooms) {
      c = color(int(map(totIncome, 0, roomPrice, 47, 245)), 46, 56); //map income from income domain to color channel domain
    }
    else {
      c = color(122, 120, 120);
    }

    //assign the color to the relate cells
    for (Vec3D v : rooms) {
      grid[int(v.x)][int(v.y)].col = c;
    }
  }
}

