import codeanticode.gsvideo.*;

GSCapture video;

void setup() { 
  size(640, 480);
  frameRate(15);
  //video
  video = new GSCapture(this, width, height);
  video.start();
}

void draw() {
  background(video);
}

void stop() {
  video.stop();
  super.stop();
}

