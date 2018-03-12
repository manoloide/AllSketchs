import java.awt.Robot;
import java.awt.AWTException;
import java.awt.Rectangle;
import peasy.*;

import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
FFT fftLin;

PeasyCam cam;
PImage screenshot; 

PShader shader;

void setup() {
  size(640, 480, P3D);
  cam = new PeasyCam(this, 100);
  
  
  minim = new Minim(this);
  in = minim.getLineIn();
  
  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
  fftLin.linAverages( 10 );
  
  shader = loadShader("bloom.glsl");
  noStroke();
}
void draw() {
  //filter(BLUR, 1);
  //background(0);
  fftLin.forward( in.mix );
  screenshot();
  //image(screenshot,0,0);
  int sep = 5;
  for (int j = 0; j < height; j+=sep) {
    for (int i = 0; i < width-sep; i+=sep) {
      stroke(screenshot.get(i, j));
      float d1 = brightness(screenshot.get(i, j))*fftLin.getBand(5)*0.1;
      float d2 = brightness(screenshot.get(i+sep, j))*fftLin.getBand(5)*0.1;
      line(i-width/2, j-height/2, d1, i+sep-width/2, j-height/2, d2);
    }
  }
  //filter(shader);
} 

void screenshot() {
  try {
    Robot robot_Screenshot = new Robot();
    screenshot = new PImage(robot_Screenshot.createScreenCapture
      (new Rectangle(80, 160, width, height)));
  }
  catch (AWTException e) {
  }
}

