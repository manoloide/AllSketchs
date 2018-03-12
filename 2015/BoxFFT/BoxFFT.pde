import ddf.minim.analysis.*;
import ddf.minim.*;
import manoloide.ImageProcessor.*;

Minim minim;
AudioInput in;
FFT fftLin;

int seed = 0;
float fftVal[] = new float[10];

ImageProcessor ip;
PImage back;

int band = 10;

void setup() {
  size(640, 480, P3D);


  minim = new Minim(this);
  in = minim.getLineIn();
  fftLin = new FFT( in.bufferSize(), in.sampleRate() );
  fftLin.linAverages( band );

  ip = new ImageProcessor(this);
  PGraphics aux = createGraphics(width, height);
  aux.beginDraw();
  aux.background(200);
  aux.endDraw();
  back = ip.noise(aux.get(), 0.03);
  ip.vignette(back, 0.4);
}
void draw() {
  background(back);
  if (frameCount%5 == 0)
    fftLin.forward( in.mix );
  translate(width/2, height/2, -200);
  rotateX(frameCount*0.03);
  rotateY(frameCount*0.013);
  noStroke();
  lights();
  randomSeed(seed);
  for (int j = 0; j < band; j++) {
    pushMatrix();
    fftVal[j] = (fftLin.getBand(j)+fftVal[j])/2;
    float des = fftVal[j];

    fill(255);
    for (int i = 0; i < 10; i++) {
      pushMatrix();
      float dd = 20;
      float x = random(-dd,dd);
      float y = random(-dd,dd);
      float z = random(-dd,dd);
      translate(x*des, y*des, z*des);
      rotateX(random(TWO_PI));
      rotateY(random(TWO_PI));
      rotateZ(random(TWO_PI));
      box(18);
      popMatrix();
    }
    popMatrix();
  }
  /*
    int cc = 6;//int(random(3, 10));
   float da = TWO_PI/cc;
   float amp = 10;
   translate(0, (j-5)*30, 0);
   fill(12*j);
   for (int i = 0; i < cc; i++) {
   pushMatrix();
   float ang = da*i;
   translate(cos(ang)*(30+amp*des), 0, sin(ang)*(30+amp*des));
   rotateY(ang);
   box(24);
   popMatrix();
   }
   popMatrix();
   }
   */
} 

