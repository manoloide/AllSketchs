int seed = int(random(999999));
float det, des;
PShader post;

float SCALE = 1;
int swidth = 960;
int sheight = 960;

void settings() {
  size(int(swidth*SCALE), int(sheight*SCALE), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  post = loadShader("post.glsl");

  generate();

  /*
  saveImage();
   exit();
   */
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
  resetShader();
  background(0);
  
  int back = rcol();
  float uh = 1.1;
  float hh = height*uh;

  noStroke();
  for (int c = 0; c < 4; c++) {
    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(lerpColor(back, rcol(), 0.5));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
    for (int i = 0; i < 2000; i++) {
      float x = random(width);
      float y = random(hh);
      float s = random(2 )*random(1);
      fill(rcol(), random(200, 256));
      ellipse(x, y, s, s);
    }

    for (int i = 0; i < 5; i++) {
      float s = width*random(0.1, 0.8)*random(1);
      float x = random(width);
      float y = random(-s, hh  +s);
      noStroke();
      arc2(x, y, s, s*2.6, 0, TWO_PI, color(0), 14, 0);
      int col = getColor();
      fill(col);
      ellipse(x, y, s, s);
      arc2(x, y, s*0.4, s, 0, TWO_PI, color(0), 0, 20);
      arc2(x, y, s*0.0, s, 0, TWO_PI, color(0), 0, 30);
      arc2(x, y, s*0.8, s, 0, TWO_PI, color(col), 0, 80);
      arc2(x, y, s*1.1, s, 0, TWO_PI, color(col), 0, 40);
      //arc2(x, y, s*2, s, 0, TWO_PI, color(col), 0, 40);
    }

    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(back, random(40, 110));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
  }

  float det1 = random(0.002, 0.003);
  float des1 = random(1000);
  float det2 = random(0.002, 0.003);
  float des2 = random(1000);
  float ang = random(TAU);
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(0.04)*random(1)*noise(des1+x*det1, des1+y*det1);
    s -= 0.02;
    if (s < 0) continue;
    s *= width;
    float a = ang+TAU*noise(des2+x*det2, des2+y*det2)*0.1;
    float d = s*random(2, random(30));
    beginShape();
    fill(rcol());
    vertex(x-cos(a)*d+cos(a-HALF_PI)*s*0.1, y-sin(a)*d+sin(a-HALF_PI)*s*0.1);
    vertex(x-cos(a)*d+cos(a+HALF_PI)*s*0.1, y-sin(a)*d+sin(a+HALF_PI)*s*0.1);
    fill(rcol());
    vertex(x+cos(a)*d+cos(a+HALF_PI)*s*0.1, y+sin(a)*d+sin(a+HALF_PI)*s*0.1);
    vertex(x+cos(a)*d+cos(a-HALF_PI)*s*0.1, y+sin(a)*d+sin(a-HALF_PI)*s*0.1);
    endShape();

    endShape();
    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);
    arc2(x, y, s, s*2, 0, TAU, color(255), 20, 0);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.12);
    s -= s%20;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j); 
      float dis = dist(x, y, other.x, other.y);
      if (dis < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  ArrayList<PVector> radars = new ArrayList<PVector>();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, p.z, p.z);

    float dir = random(TAU);
    float des = p.z*random(1)*random(0.4, 4);
    noStroke();
    stroke(0, 12);
    arc3(p.x, p.y, p.z, p.x+cos(dir)*des, p.y+sin(dir)*des, p.z*random(2), rcol(), 0, 120); 
    float dx = cos(ang)*des;
    float dy = sin(ang)*des;
    PVector radar = new PVector(p.x+dx, p.y+dy, p.z*0.1);    
    int colRadar = rcol();
    stroke(colRadar);
    line(p.x, p.y, radar.x, radar.y);
    fill(colRadar);
    ellipse(radar.x, radar.y, radar.z, radar.z);
    radars.add(radar);
    //stroke(255, 4);
    noStroke();
    arc2(p.x, p.y, p.z, p.z*0., 0, TAU, rcol(), 0, 120);
  }

  for (int i = 0; i < radars.size(); i++) {
    PVector radar1 = radars.get(i);
    for (int j = i+1; j < radars.size(); j++) {
      PVector radar2 = radars.get(j);
      float dis = dist(radar1.x, radar1.y, radar2.x, radar2.y);
      if (dis > (radar1.z+radar2.z)*14) continue;
      stroke(255, 10);
      line(radar1.x, radar1.y, radar2.x, radar2.y);
      stroke(rcol(), random(80));
      lineDashed(radar1.x, radar1.y, radar2.x, radar2.y, 8, 0.5);
    }
  }


  post = loadShader("post.glsl");
  //filter(post);
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

void arc3(float x1, float y1, float s1, float x2, float y2, float s2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = max(2, int(max(r1, r2)*PI));
  float da = TAU/cc;
  for (int i = 0; i < cc; i++) {
    float ang = da*i;
    beginShape();
    fill(col, alp1);
    vertex(x1+cos(ang)*r1, y1+sin(ang)*r1);
    vertex(x1+cos(ang+da)*r1, y1+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x2+cos(ang+da)*r2, y2+sin(ang+da)*r2);
    vertex(x2+cos(ang)*r2, y2+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void lineDashed(float x1, float y1, float x2, float y2, float jump, float amp) {
  float dir = atan2(y2-y1, x2-x1);
  float dis = dist(x1, y1, x2, y2);
  float desx = cos(dir);
  float desy = sin(dir);
  int cc = int(dis/jump);
  for (int i = 0; i < cc; i++) { 
    float r1 = (jump*(i));
    float r2 = (jump*(i+amp));
    line(x1+desx*r1, y1+desy*r1, x1+desx*r2, y1+desy*r2);
  }
}

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
