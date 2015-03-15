class MultiThread extends Thread {
  boolean running;           // Is the thread running?  Yes or no?
  int start;
  int end;
  int id;

  // Constructor, create the thread
  // It is not running by default
  MultiThread (int i, int s, int e) {
    running = false;
    start = s;
    end = e;
    id = i;
  }

  // Overriding "start()"
  void start () {
    // Set running equal to true
    running = true;
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }

  // We must implement run, this gets triggered by start()
  void run () {
    while (running) {

      int size = fireflies.size();
      for (int i = start; i <= end; i++) {
        fireflies.get(i).update();
       
          
          //fireflies.remove(i);
          //size = fireflies.size();
        
      }
      try {
       sleep(10);
      } 
      catch (Exception e) {
      }
    }
    System.out.println("Thread is done!");  // The thread is done when we get to the end of run()
  }

  // Our method that quits the thread
  void quit() {
    System.out.println("Quitting."); 
    running = false;  // Setting running to false ends the loop in run()
    // IUn case the thread is waiting. . .
    interrupt();
  }
}

