///////////////////////////////////////////////////////////////////////////////////CLASS BALL
class Ball {

  ///////////////////////////////////////////////////////////////////////////////////VARIABLES  
  Vec3D location;
  Vec3D velocity;
  Vec3D acceleration;
  Vec3D mouse;

  ///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR
  Ball() {
    location = new Vec3D(random(width), random(height), 0);
    velocity = new Vec3D(0, 0, 0);
    acceleration = new Vec3D(0, 0, 0);
  }

  ///////////////////////////////////////////////////////////////////////////////////FUNCTIONS  

  // main function
  void run() {
    update();
    edges();
    //bounce(); // choose wheter you want to work with a wrap space or with a bounce space. commet the other one
    display();
  }

  // function to calculate new location, speed and acceleration according to mouse position
  void update() {
    mouse= new Vec3D(mouseX, mouseY, 0);
    mouse.subSelf(location); // define the vector connecting the ball loc to the mouse loc
    mouse.normalizeTo(0.1); // scale the vector to the lenght of 0.1
    acceleration = mouse; // assign the created vector to the acceleration vector
    velocity.addSelf(acceleration); // add acceleration to velocity
    location.addSelf(velocity); // add velocity to location
    velocity.limit(5); // set a limit for velocity
  }


  // function to set a wrap space for the sketch
  void edges() {
    if (location.x > width) location.x = 0; 
    if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    if (location.y < 0) location.y = height;
  }
  
  // function to allow the ball to bounce on the sides
  void bounce() {
    if (location.x>width) {
      location.x=width;
      velocity.x*=-1;
    }
    if (location.x<0) {
      location.x=0;
      velocity.x*=-1;
    } 
    if (location.y>height) {
      location.y=height;
      velocity.y*=-1;
    }
    if (location.y<0) {
      location.y=0;
      velocity.y*=-1;
    }
  }
  
  // function to display the ball in the current location
  void display() {
    fill(255, 200, 150);
    ellipse(location.x, location.y, 10, 10);
  }
}
