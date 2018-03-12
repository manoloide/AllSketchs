import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int seed = int(random(99999999));
PShader post; 

float boxSize = 0;

void setup() {
  size(640, 640, P3D);
  background(240);
  frameRate(30);
  minim = new Minim(this);
  player = minim.loadFile("../idm1.mp3", 512);
  player.loop();
  fft = new FFT( player.bufferSize(), player.sampleRate());
  fft.linAverages(16);

  post = loadShader("post.glsl");
  post.set("iResolution", float(width), float(height));
}

void draw() {
  post.set("iGlobalTime", millis()/1000.);

  fft.forward( player.mix );
  fft.getBand(5);

  if (fft.getBand(0) > 36) seed++;

  randomSeed(seed);
  background(220);

  translate(width/2, height/2);
  rotateX(frameCount*0.0073);
  rotateY(frameCount*0.0013);
  rotateZ(frameCount*0.000731);
  boxSize += ((fft.getBand(8)+fft.getBand(2)*3)-boxSize)*0.9;

  int cc = 8; 
  float sep = 80; 
  noStroke();
  translate(-sep*cc/2., -sep*cc/2., -sep*cc/2.);
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        pushMatrix();
        translate(i*sep, j*sep, k*sep);
        box(boxSize);
        popMatrix();
      }
    }
  }
  filter(post);
}

void generar1() {
  /*
  random(5);
   background(random(256));
   strokeWeight(2);
   random(10);
   stroke(random(256));
   fill(random(256), 2+fft.getBand(4)*0.8);
   float t = (frameCount+fft.getBand(0))*0.0005;
   
   for (int i = 0; i < 80; i++) {
   float x = noise(t+i)*width*2-width/2;
   float y = noise(t+i+100)*height*2-height/2;
   float s = random(10, 200)*random(1);
   float a = random(TWO_PI);
   int c = int(random(3, 11));
   poly(x, y, s, c, a);
   }
   
   
   if (fft.getBand(1) > 1) {
   noStroke();
   for (int i = 0; i < 140; i++) {
   fill(random(256));
   cross(random(width)+noise(t/10+i+100)*60, random(height)+noise(t/10+i+600)*60, random(3, 40)*cos(frameCount*random(0.02)), random(TWO_PI)+frameCount*random(-0.05, 0.04), random(0.2, 0.6));
   }
   }
   */
}

void cross(float x, float y, float d, float a, float s) {
  float r = d*0.5;
  float sep = r*s;
  float r2 = dist(sep, 0, 0, sep);
  float da = TWO_PI/4;
  beginShape();
  for (int i = 0; i < 4; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang-PI/4)*r2, y+sin(ang-PI/4)*r2);
    float sx = cos(ang-PI/2)*sep; 
    float sy = sin(ang-PI/2)*sep;
    float xx = x+cos(ang)*r;
    float yy = y+sin(ang)*r;
    vertex(xx+sx, yy+sy);
    vertex(xx-sx, yy-sy);
  }
  endShape(CLOSE);
}

void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    float xx = x + cos(da*i+a) * r;
    float yy = y + sin(da*i+a) * r; 
    vertex(xx, yy);
  }
  endShape(CLOSE);
}

