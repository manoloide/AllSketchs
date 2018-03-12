import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

void setup() {
  size(640, 640, P3D);
  frameRate(30);

  minim = new Minim(this);
  player = minim.loadFile("../idm1.mp3", 512);
  player.loop();
  fft = new FFT( player.bufferSize(), player.sampleRate());
  fft.linAverages(16);

  generar();
}

float lar, div, ang;

void draw() {
  background(20);
  translate(width/2, height/2, -200);
  rotateX(PI/4);
  rotateZ(frameCount*0.01);

  float ml = lar/2;
  beginShape(QUADS);
  float da = TWO_PI/div;
  for (int j = 0; j < 5; j++) {
    for (int i = 0; i < div; i++) {
      vertex(-ml+lar/5*j, cos(i*da+ang)*ml, sin(i*da+ang)*ml);
      vertex(ml+lar/5*j, cos(i*da+ang)*ml, sin(i*da+ang)*ml); 
      vertex(ml+lar/5*j, cos((i+1)*da+ang)*ml, sin((i+1)*da+ang)*ml);
      vertex(-ml+lar/5*j, cos((i+1)*da+ang)*ml, sin((i+1)*da+ang)*ml);
    }
  }
  endShape();
}

void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r);
  }
  endShape();
}

void generar() {
  lar = 100; 
  div = 10;
  ang = PI*1.5;
}

