///////////////////////////////////////////////////////////////////////////////////CLASS TIMER
class Timer {
  
///////////////////////////////////////////////////////////////////////////////////VARIABLES  
  int savedTime; // when Timer started
  int totalTime; // how long Timer should last

///////////////////////////////////////////////////////////////////////////////////CONSTRUCTOR
  Timer(int _totalTime) {
    totalTime = _totalTime;
  }
  
///////////////////////////////////////////////////////////////////////////////////FUNCTIONS
  // Starting the timer
  void start() {
    savedTime = millis();
  }
  
  //check function returing a true value when the time is finished
  boolean isFinished() {
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } 
    else {
      return false;
    }
  }
}
