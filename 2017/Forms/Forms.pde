int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
  generate();
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
  render();
}

void render() {

  noiseSeed(seed);
  randomSeed(seed);

  background(250);

  /*
  int sub = int(random(1, 17));
   float s = width*1.0/sub;
   
   float ss = s*random(0.9, 1);
   for (int j = 0; j < sub; j++) {
   for (int i = 0; i< sub; i++) {
   rect((i+0.5)*s, (j+0.5)*s, ss, ss, 5);
   }
   }
   */

  Rect rect = new Rect(width/2, height/2, 200, 200);
  rect.showSmooth(30);

  Poly poly = new Poly(width/2, height/2, 400, frameCount*0.02, 9);
  poly.show();
  poly.showSmooth(cos(frameCount*0.1)*20+24);

  Cross cross = new Cross(mouseX, mouseY, 200, 0.4, frameCount*0.1);
  cross.show();
  cross.showSmooth(cos(frameCount*0.1)*20+24);
} 

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}

class Form {
  ArrayList<PVector> vertex;
  Form() {
    vertex = new ArrayList<PVector>();
  }
  void update() {
  }
  void show() {
    beginShape(); 
    for (int i = 0; i < vertex.size(); i++) {
      PVector v = vertex.get(i);
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
  void showSmooth(float smo) {
    beginShape(); 
    PVector ant = vertex.get(vertex.size()-1);
    PVector act = vertex.get(0);
    PVector sig = vertex.get(1);
    float a1 = atan2(ant.y-act.y, ant.x-act.x); 
    float a2 = atan2(act.y-sig.y, act.x-sig.x); 
    for (int i = 0; i < vertex.size(); i++) {
      act = vertex.get(i);
      sig = vertex.get((i+1)%vertex.size());
      a1 = atan2(ant.y-act.y, ant.x-act.x); 
      a2 = atan2(act.y-sig.y, act.x-sig.x); 
      vertex(act.x+cos(a2)*smo, act.y+sin(a2)*smo);
      vertex(act.x-cos(a1)*smo, act.y-sin(a1)*smo);
      ant = act;
    }
    endShape(CLOSE);
  }
  /*
  void center() {
   PVector center = new PVector();
   for (int i = 0; i < vertex.size(); i++) {
   center.add(vertex.get(i));
   }
   center.div(vertex.size());
   for (int i = 0; i < vertex.size(); i++) {
   vertex.get(i).sub(center);
   }
   }
   */
}

class Rect extends Form {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    super();
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
    create();
  }

  void create() {
    vertex.add(new PVector(x, y));
    vertex.add(new PVector(x+w, y));
    vertex.add(new PVector(x+w, y+h));
    vertex.add(new PVector(x, y+h));
  }
}

class Poly extends Form {
  float x, y, s, a;
  int seg;
  Poly(float x, float y, float s, float a, int seg) {
    super();
    this.x = x; 
    this.y = y;
    this.s = s; 
    this.a = a;
    this.seg = seg;
    create();
  }

  void create() {
    float r = s*0.5;
    float da = TWO_PI/seg;
    for (int i = 0; i < seg; i++) {
      float xx = x+cos(a+da*i)*r;
      float yy = y+sin(a+da*i)*r;
      vertex.add(new PVector(xx, yy));
    }
  }
}

class Cross extends Form {
  float x, y, s, r, amp, ang;
  Cross(float x, float y, float s, float amp, float ang) {
    super();
    this.x = x; 
    this.y = y; 
    this.s = s; 
    this.amp = amp;
    this.ang = ang;
    create();
  }

  void create() {
    float r = s/2;
    float d = s*amp*0.5;
    float r2 = d*sqrt(2);

    for (int i = 0; i < 4; i++) {
      float a1 = ang+HALF_PI*i;
      float ax = x+cos(a1)*r; 
      float ay = y+sin(a1)*r;  
      float dx = cos(a1-HALF_PI)*d;
      float dy = sin(a1-HALF_PI)*d;
      vertex.add(new PVector(ax+dx, ay+dy));
      vertex.add(new PVector(ax-dx, ay-dy));
      vertex.add(new PVector(x+cos(a1+HALF_PI*0.5)*r2, y+sin(a1+HALF_PI*0.5)*r2));
    }
  }
}