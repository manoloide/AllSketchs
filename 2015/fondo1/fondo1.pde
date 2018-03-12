import ddf.minim.analysis.*;
import ddf.minim.*;

ArrayList<PVector> partis;

Minim minim;
AudioInput in;
FFT fftLin;

float amp = 0;

void setup() {
  size(displayWidth, displayHeight);
  colorMode(HSB, 256, 256, 256);

  partis = new ArrayList<PVector>();

  minim = new Minim(this);
  in = minim.getLineIn();
  fftLin = new FFT(in.bufferSize(), in.sampleRate());
  fftLin.linAverages(6);

  for (int i = 0; i < 3000; i++) {
    partis.add(new PVector(random(width), random(height), random(5)));
  }
}

void draw() {
  fftLin.forward( in.mix );


  float diag = dist(0, 0, width, height);
  float velCol = 3;
  noStroke();
  fill((frameCount*velCol)%256, 220, 250, 6);
  rect(0, 0, width, height);
  float a = frameCount*0.01;
  int cc = 11;
  float da = PI/cc;

  for (int i = 0; i < 5; i++) {
    partis.add(new PVector(random(width), random(height), random(5)));
  }

  noStroke();
  fill(255, 2);
  for (int i = 0; i < partis.size (); i++) {
    PVector p = partis.get(i);
    p.x += random(-0.2, 0.2);
    p.y += random(-0.4, 0.3);
    p.z *= random(0.998, 1);
    p.z -= random(0.01);
    if (p.z <= 0) partis.remove(i--);
    ellipse(p.x, p.y, p.z, p.z);
  }


  noStroke ();
  amp += (pow(fftLin.getBand(0), 0.8)*0.4-amp)*0.2;
  amp = 0.5;
  float x = mouseX+cos(frameCount*0.005)*180;
  float y = mouseY+sin(frameCount*0.005)*180;
  for (int i = 0; i < cc*2; i+=2) {
    fill((frameCount*velCol+128)%256, 80, 255, 12);
    beginShape();
    vertex(x, y);
    float a1 = da*(i-amp)+a;
    float a2 = da*(i+amp)+a;
    vertex(x+cos(a1)*diag, y+sin(a1)*diag);
    vertex(x+cos(a2)*diag, y+sin(a2)*diag);
    endShape(CLOSE);
  }
}

