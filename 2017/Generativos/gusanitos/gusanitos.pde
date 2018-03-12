int seed = int(random(9999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%120 == 0) seed = int(random(9999999));
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(20);
  //lights();
  for (int k = 0; k < 2; k++) {
    translate(width/2, height/2);
    rotate(HALF_PI);
    translate(-width/2, -height/2);
    int divs = int(random(1, random(2, 100)));
    int sub = int(random(40, random(40, 600)));
    float sd = height*1./divs;
    float amp = random(300)*random(1);
    float ampf = random(1);
    for (int j = 0; j < divs; j++) {
      float[] freq1 = createSine(int(random(sub*0.02)*ampf), random(1), sub+1);
      float[] freq2 = createSine(int(random(sub*0.2)*ampf), random(1), sub+1);
      float[] freq3 = createSine(int(random(sub*0.1)*ampf), random(1), sub+1);
      float[] values = operation(freq1, freq2, int(random(3)));
      values = operation(values, freq3, int(random(3)));
      float ss = width*1./sub;
      int inter = int(random(colors.length));
      float dc = random(0.05)*random(1);
      float ic = random(colors.length);
      noStroke();
      for (int i = 0; i < sub; i++) {
        float h1 = values[i]*amp;
        float h2 = values[i+1]*amp;
        fill(getColor(i*dc+(i%2)*inter+ic));
        beginShape();
        vertex((i+0)*ss, (j+0)*sd, h1);
        vertex((i+1)*ss, (j+0)*sd, h2);
        vertex((i+1)*ss, (j+1)*sd, h2);
        vertex((i+0)*ss, (j+1)*sd, h1);
        endShape();
        beginShape();
        fill(0, 0);
        vertex((i+0)*ss, (j+0)*sd, h1);
        vertex((i+1)*ss, (j+0)*sd, h2);
        fill(0, 80);
        vertex((i+1)*ss, (j+1)*sd, h2);
        fill(0, 30);
        vertex((i+0)*ss, (j+1)*sd, h1);
        endShape();
      }
      //drawFunction(r.x, r.y, r.w, r.h, values);
    }
  }
}

float[] createSine(float freq, float phase, int amount) {
  float[] aux = new float[amount]; 
  float df = (TWO_PI/amount)*freq;
  phase *= TWO_PI;
  for (int i = 0; i < amount; i++) {
    aux[i] = sin(phase+df*i);
  }
  return aux;
}

float[] operation(float[] v1, float[] v2, int op) {
  float[] aux =  new float[v1.length];
  for (int i = 0; i < v1.length; i++) {
    if (op == 0) {
      aux[i] = v1[i]*0.5+v2[i]*0.5;
    } else if (op == 1) {
      aux[i] = v1[i]*0.5-v2[i]*0.5;
    } else if (op == 2) {
      aux[i] = v1[i]*v2[i];
    } else if (op == 3) {
      aux[i] = v1[i]/v2[i];
    }
  }
  return aux;
}

void drawFunction(float x, float y, float w, float h, float[] values) {

  float dc = random(1)*random(1)*random(1);
  float dx = w*1./(values.length-1);
  beginShape();
  for (int i = 0; i < values.length; i++) {
    stroke(getColor(dc*i));
    vertex(x+dx*i, y+h*(values[i]+1)*0.5);
  }
  endShape();
}

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}