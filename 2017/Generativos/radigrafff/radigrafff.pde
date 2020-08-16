int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  background(#efcebf);

  blendMode(SUBTRACT);
  int sub = int(random(4, 14));
  int div = int(pow(2, int(random(5))));
  float ss = width*1./sub;
  float sss = ss/div;

  class Quad {
    int x, y, w, h;
    Quad(int x, int y, int w, int h) {
      this.x = x; 
      this.y = y; 
      this.w = w; 
      this.h = h;
    }
  }
  boolean spaces[][] = new boolean[sub][sub];
  ArrayList<Quad> quads = new ArrayList<Quad>();
  int fress = sub*sub;
  while (fress > 0) {
    int w = int(random(1, sub*random(0.5, 1)));
    int h = int(random(1, sub*random(0.5, 1)));
    w = h;
    int x = int(random(sub-w+1));
    int y = int(random(sub-h+1));

    boolean yes = true;
    for (int yy = 0; yy < h; yy++) {
      for (int xx = 0; xx < w; xx++) {
        if (spaces[x+xx][y+yy]) {
          yes = false;
          break;
        }
      }
      if (!yes) break;
    }
    if (yes) {
      fress -= w*h;
      for (int yy = 0; yy < h; yy++) {
        for (int xx = 0; xx < w; xx++) {
          spaces[x+xx][y+yy] = true;
        }
      }
      quads.add(new Quad(x, y, w, h));
    }
  }

  float bb = 2;
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i);
    fill(getColor(random(colors.length)), random(256));
    noStroke();
    rect(q.x*ss+bb, q.y*ss+bb, q.w*ss-bb*2, q.h*ss-bb*2, bb*2);

    stroke(colors[1], random(30, 60));//colors[1], 8);
    //stroke(0, random(10, 40));
    //if (random(1) < 0.8) {
    form(q.x*ss+q.w*ss*0.5, q.y*ss+q.h*ss*0.5, min(q.w, q.h)*0.8*ss);
    //}
  }

  stroke(colors[1], random(40, 50));
  for (int i = 0; i <= sub*div; i++) {
    float v = sss*i;
    strokeWeight(0.8);
    if (i%div == 0) strokeWeight(1.2);
    line(0, v, width, v);
    line(v, 0, v, height);
  }



  stroke(colors[1], 50);
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      noStroke();
      fill(colors[0], random(255));
      //rect(ss*i, ss*j, ss, ss);
      stroke(colors[1], 40);
      //form(ss*(i+0.5), ss*(j+0.5), ss*0.8);
    }
  }

  /*
  noStroke();
   for (int i = 0; i < 100; i++) {
   float x = random(width); 
   float y = random(height);
   //x -= x%sss;
   //y -= y%sss;
   float s = random(2, 12);
   //x -= s*0.5;
   //y -= s*0.5;
   fill(rcol());
   cross(x, y, s, 0.25, 0);
   }
   */

  noFill();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(12);
    float a1 = random(TWO_PI);
    float a2 = a1+random(PI*0.3);
    stroke(random(40), random(255)*random(1)*random(1));
    strokeWeight(random(1));
    arc(x, y, s, s, a1, a2);
  }
}

int colors[] = {#e94c20, #0057BB};
int rcol() { 
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}


void form(float x, float y, float s) {
  int seg = 1200; 

  float r1 = s*random(0.3, 0.5);
  float r2 = s*random(0.5);

  float d1 = s*random(0.1);
  float d2 = s*random(0.1);

  r1 -= d1;
  r2 -= d2;

  float mr1 = 1-random(0.4);
  float mr2 = 1-random(0.4);

  float osc1 = TWO_PI/seg*int(random(1, 14));
  float osc2 = TWO_PI/seg*int(random(1, 14));

  float da1 = TWO_PI/seg*int(random(6, random(40)));
  float da2 = TWO_PI/seg*int(random(6, random(40)));

  float a1 = random(TWO_PI);
  float a2 = random(TWO_PI);

  float dd1 = (TWO_PI/seg)*int(random(1, random(40)));
  float dd2 = (TWO_PI/seg)*int(random(1, random(40)));

  for (int i = 0; i < seg; i++) {
    float o1 = map(cos(osc1*i), -1, 1, mr1, 1);
    float o2 = map(cos(osc2*i), -1, 1, mr2, 1);
    float x1 = x+cos(a1+da1*i)*r1*o1+cos(dd1*i)*d1;
    float y1 = y+sin(a1+da1*i)*r1*o1+sin(dd1*i)*d1;
    float x2 = x+cos(a2+da2*i)*r2*o2+cos(dd2*i)*d2;
    float y2 = y+sin(a2+da2*i)*r2*o2+sin(dd2*i)*d2;

    line(x1, y1, x2, y2);
  }
}

void cross(float x, float y, float s, float amp, float a) {
  float r = s/2;
  float d = s*amp*0.5;
  float r2 = d*sqrt(2);

  beginShape();
  for (int i = 0; i < 4; i++) {
    float a1 = a+HALF_PI*i;
    float ax = x+cos(a1)*r; 
    float ay = y+sin(a1)*r;  
    float dx = cos(a1-HALF_PI)*d;
    float dy = sin(a1-HALF_PI)*d;
    vertex(ax+dx, ay+dy);
    //vertex(ax, ay);
    vertex(ax-dx, ay-dy);

    vertex(x+cos(a1+HALF_PI*0.5)*r2, y+sin(a1+HALF_PI*0.5)*r2);
  }
  endShape(CLOSE);
}