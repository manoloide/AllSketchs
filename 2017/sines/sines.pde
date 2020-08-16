int seed = int(random(9999999));

void setup() {
  size(480, 480, P2D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}


void draw() {
  if (frameCount%112 == 0) seed = int(random(9999999));
  generate();
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

class Rect {
  float x, y, w, h;
  Rect(float xx, float yy, float ww, float hh) {
    this.x = xx;
    this.y = yy;
    this.w = ww;
    this.h = hh;
  }
}

void generate() {
  background(20);
  /*
  fill(0, 160); 
   noStroke();
   rect(0, 0, width*2, height*2);
   */

  randomSeed(seed);

  float time = frameCount/30.;//millis()*0.001;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int div = int(random(random(1, random(1, 100))));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (random(1) > 0.5) {
      if (r.w+random(-1, 1) > r.h) {
        rects.add(new Rect(r.x, r.y, r.w*0.5, r.h));
        rects.add(new Rect(r.x+r.w*0.5, r.y, r.w*0.5, r.h));
      } else {
        rects.add(new Rect(r.x, r.y, r.w, r.h*0.5));
        rects.add(new Rect(r.x, r.y+r.h*0.5, r.w, r.h*0.5));
      }
    } else {
      rects.add(new Rect(r.x, r.y, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x+r.w*0.5, r.y, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x+r.w*0.5, r.y+r.h*0.5, r.w*0.5, r.h*0.5));
      rects.add(new Rect(r.x, r.y+r.h*0.5, r.w*0.5, r.h*0.5));
    }
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(255, 40);
    noFill();
    float[] freq1 = createSine(int(random(r.w*0.02)), random(1)+time*random(-0.5, 0.5), int(r.w*8));
    float[] freq2 = createSine(int(random(r.w*0.2)), random(1)+time*random(-0.5, 0.5), int(r.w*8));
    float[] freq3 = createSine(int(random(r.w*0.1)), random(1)+time*random(-0.5, 0.5), int(r.w*8));
    float[] values = operation(freq1, freq2, int(random(3)));
    values = operation(values, freq3, int(random(3)));
    drawFunction(r.x, r.y, r.w, r.h, values);
  }
  /*
  if (frameCount <= 30*120) {
    saveFrame("render####.png");
  } else {
    exit();
  }
  */
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