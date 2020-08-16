import processing.video.*;

import gab.opencv.*;
import java.awt.Rectangle;

OpenCV opencv;
Rectangle[] faces;

Capture video;
PImage capture;

void setup() {
  size(640, 480);
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 100);

  video = new Capture(this, width, height);
  video.start();  

  background(0);
}


void draw() { 
  if (capture == null) {
    if (video.available()) {
      video.read();
      image(video, 0, 0);
    }
  } else {
    image(capture, 0, 0); 
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
}

void keyPressed() {
  if (capture == null) {
    capture = video.get();
    opencv = new OpenCV(this, capture);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
    faces = opencv.detect();
  } else {
    capture = null;
  }
}

