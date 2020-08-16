
// also shutdown the midi thread when the applet is stopped
public void stop() {
  if (midi!=null) midi.isActive=false;
  super.stop();
}

class MidiThread extends Thread {

  long previousTime;
  boolean isActive=true;
  double interval;

  MidiThread(double bpm) {
    // interval currently hard coded to quarter beats
    interval = 1000.0 / (bpm / 60.0); 
    previousTime=System.nanoTime();
  }

  void run() {
    try {
      while (isActive) {
        // calculate time difference since last beat & wait if necessary
        double timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        while (timePassed<interval) {
          timePassed=(System.nanoTime()-previousTime)*1.0e-6;
        }
        // insert your midi event sending code here
        println("midi out: "+timePassed+"ms");
        // calculate real time until next beat
        step++;
        step %= cc;
        long delay=(long)(interval-(System.nanoTime()-previousTime)*1.0e-6);
        previousTime=System.nanoTime();
        Thread.sleep(delay);
      }
    } 
    catch(InterruptedException e) {
      println("force quit...");
    }
  }
} 
