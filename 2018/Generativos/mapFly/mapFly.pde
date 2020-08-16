int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(6500, 6500, P2D);
  smooth(2);
  strokeWeight(3);
  //pixelDensity(2);

  post = loadShader("post.glsl");

  generate();


  saveImage();
  exit();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  background(#EDBFB7);

  rectMode(CENTER);

  int cc = int(random(18, 60));
  float ss = width*1./cc;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  int c = int(random(8, 30));
  for (int i = 0; i < c; i++) {
    float xx = random(width);
    float yy = random(height);
    float ww = width*random(0.05, 0.3);
    float hh = height*random(0.05, 0.3);
    xx -= xx%ss;
    yy -= yy%ss;
    rects.add(new Rect(xx, yy, ww, hh));
  }

  color shw = lerpColor(color(#EDBFB7), color(0, 0, 20), 0.08);
  fill(shw);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    noStroke();
    rect(r.x+10, r.y+10, r.w, r.h);
    stroke(shw);
    lineRect(r.x+10, r.y+10, width*0.5+10, height*0.5+10);
  }



  float det = random(0.002, 0.01)*(960./width);
  float des = random(10000);
  int cccc = int(100*(width/960.));
  noiseDetail(4);
  for (int i = 0; i < cccc; i++) {
    float xx = random(width);
    float yy = random(height);
    stroke(rcol(), 120);
    for (int j = 0; j < 3000; j++) {
      float a = (noise(des+xx*det, des+yy*det)+random(-0.0005, 0.0005))*TAU*50;
      float nx = xx+cos(a);
      float ny = yy+sin(a);
      if (j%20 < 16) line(xx, yy, nx, ny);
      xx = nx;
      yy = ny;
    }
  }



  noStroke();
  float sss = max(1, int(ss*0.1));
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(rcol());
      rect(ss*(i+0.5), ss*(j+0.5), sss, sss);
    }
  }

  stroke(255, 40);
  for (int i = 1; i < cc; i++) {
    float dd = map(i, 0, cc, 0, width);
    line(dd, 0, dd, height);
    line(0, dd, width, dd);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 240);
    lineRect(r.x, r.y, width*0.5, height*0.5);
  }

  noStroke();
  for (int i = 0; i < cc; i++) {
    float xx = random(width+ss);
    float yy = random(height+ss);
    xx -= xx%ss;
    yy -= xx%ss;
    float s = ss*int(random(1, 3));
    fill(rcol());
    ellipse(xx, yy, s, s);
    stroke(0, 2);
    arc2(xx, yy, s, s*1.6, 0, TAU, color(0), 20, 0);

    int sub = 2+int(random(2))*2;
    float da = TAU/sub;
    float dd = int(random(2))*0.5;
    for (int j = 0; j < sub; j++) {
      fill(rcol());
      arc(xx, yy, s, s, da*(j+dd), da*(j+1+dd));
    }
  }

  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    int c1 = rcol();
    int c2 = rcol();
    while (c1 == c2) c2 = rcol();
    int c3 = rcol();
    while (c3 == c1 || c3 == c2) c3 = rcol();
    fill(c1);
    rect(r.x, r.y, r.w, r.h);
    fill(c2);
    float amp = 1;//random(0.8, 1);
    rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5*amp, r.h*0.5*amp);
    rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5*amp, r.h*0.5*amp);
    fill(c3);
    rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5*amp, r.h*0.5*amp);
    rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5*amp, r.h*0.5*amp);
  }

  noiseDetail(4);
  for (int i = 0; i < 10; i++) {
    float xx = random(width);
    float yy = random(height);
    det = random(0.001);
    des = random(10000);
    float da = random(TAU);
    float d = random(20);
    int ccc = int(random(80, 1000));
    float a = 0;
    for (int j = 0; j < ccc; j++) {
      a = (noise(des+xx*det, des+yy*det)+random(-0.0005, 0.0005))*TAU*d+da;
      float val = map(j, 0, ccc, 0, 1);
      float nx = xx+cos(a);
      float ny = yy+sin(a);
      if (j%20 < 16) {
        stroke(0, 30*val);
        float dd = 10*val;
        line(xx+dd, yy+dd, nx+dd, ny+dd);
        stroke(255, 255*val);
        line(xx, yy, nx, ny);
      }
      xx = nx;
      yy = ny;
    }
    noStroke();
    fill(0, 30);
    beginShape();
    vertex(xx+cos(a)*3+10, yy+sin(a)*3+10);
    a += PI;
    vertex(xx+cos(a-0.2)*20+10, yy+sin(a-0.2)*20+10);
    vertex(xx+cos(a)*16+10, yy+sin(a)*16+10);
    vertex(xx+cos(a+0.2)*20+10, yy+sin(a+0.2)*20+10);
    endShape();

    a -= PI;
    fill(rcol());
    beginShape();
    vertex(xx+cos(a)*3, yy+sin(a)*3);
    a += PI;
    vertex(xx+cos(a-0.2)*20, yy+sin(a-0.2)*20);
    vertex(xx+cos(a)*16, yy+sin(a)*16);
    vertex(xx+cos(a+0.2)*20, yy+sin(a+0.2)*20);
    endShape();
  }

  post = loadShader("post.glsl");
  filter(post);
}

void lineRect(float x1, float y1, float x2, float y2) {
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5;

  float dw = abs(x2-x1);
  float dh = abs(y2-y1);
  if (dw > dh) {
    line(x1, y1, cx, y1);
    line(x2, y2, cx, y2);
    line(cx, y1, cx, y2);
  } else {
    line(x1, y1, x1, cy);
    line(x2, cy, x2, y2);
    line(x1, cy, x2, cy);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}