import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
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

void generate() { 

  float grid = 60;

  randomSeed(seed);
  noiseSeed(seed);

  grid(grid);
  globos();

  //if(true) return;

  //scale(scale);


  boolean onlyCurves = true;
  if (onlyCurves) {
    for (int k = 0; k < 20; k++) {
      float x1 = random(width); 
      float y1 = random(grid*2, height); 
      float x2 = random(width); 
      float y2 = random(grid*2, height); 
      float cx = (x1+x2)*0.5;
      float cy = (y1+y2)*0.5;

      x1 = lerp(x1, cx, 0.6);
      x2 = lerp(x2, cx, 0.6);
      y1 = lerp(y1, cx, 0.6);
      y2 = lerp(y2, cx, 0.6);

      x1 -= x1%grid;
      y1 -= y1%grid;
      x2 -= x2%grid;
      y2 -= y2%grid;

      float ic1 = random(colors.length);
      float dc1 = random(0.01)*random(1);
      float ic2 = random(colors.length);
      float dc2 = random(0.01)*random(1);
      float des1 = random(1000);
      float det1 = random(0.1)*random(1);
      float des2 = random(1000);
      float det2 = random(0.1)*random(1);
      float lar = random(500)*random(0.2, 1);

      float laps = 4;//random(10)*random(1);
      beginShape(LINES);
      for (int i = 0; i < lar; i++) {
        float a1 = (float) SimplexNoise.noise(des1+x1*det1, des1+y1*det1)*TAU*laps;
        x1 += cos(a1);
        y1 += sin(a1);
        float a2 = (float) SimplexNoise.noise(des2+x2*det2, des2+y2*det2)*TAU*laps;
        x2 += cos(a2);
        y2 += sin(a2);
        stroke(getColor((ic1+i*dc1)*colors.length));
        vertex(x1, y1);
        //stroke(getColor((ic2+i*dc2)*colors.length));
        vertex(x2, y2);
        //line(x1, y1, x2, y2);
      }
      endShape();
    }

    //return;
  }


  //points(grid);

  int cc = 10;
  grid = 400;
  cc = int(90*random(0.8, 1)*0.9);
  float amp = random(8, 10)*0.4;

  forms(int(cc/1.8), grid/4, 3);
  //forms(cc/4, grid, amp*5, 4);
  //forms(cc*3, grid/2, amp*0.3, 4);
  forms(int(cc/2.2), grid/4, 3);

  grid = 50;
  float ss = grid*0.5;
  for (int i = 0; i < 80; i++) {
    float x = random(swidth+grid);
    float y = random(sheight+grid);
    float s = (grid/8)*pow(2, int(random(2)));
    x -= x%grid;   
    y -= y%grid;
    fill(rcol());
    rect(x, y, s, s);
    fill(rcol());
    float s1 = s*random(0.1, 1);
    rect(x, y, s1, s1);
  }
  for (int i = 0; i < 20; i++) {
    float x = random(swidth+grid);
    float y = random(sheight+grid);
    x -= x%grid;   
    y -= y%grid;
    fill(rcol(), 180);
    if (random(1) < 0.2) ellipse(x, y, grid*2, grid*2);
    fill(rcol());
    ellipse(x, y, grid*0.5, grid*0.5);
    fill(rcol());
    ellipse(x, y, grid*0.2, grid*0.2);
  }


  for (int i = 0; i < 8; i++) {
    float x = random(swidth+grid);
    float y = random(sheight+grid);
    //x -= x%grid;   
    y -= y%(grid*2);
    y += grid;

    noStroke();
    int builds = int(random(1, 12));
    for (int k = 0; k < builds; k++) {
      float hh = grid*random(2.08)*0.5;
      float ww = hh*random(0.1, 0.5);
      float dx = random(-ww, ww)*2;

      float aa = abs(dx)/(ww*2);
      aa = 1-aa;
      aa = 0.3+pow(aa, 1.2)*0.7;

      ww *= aa;
      hh *= aa;

      fill(rcol());
      rect(x+dx, y-hh*0.5, ww, hh);
    }

    fill(255, 20);
    stroke(255, 120);
    arc(x, y, grid*2, grid*2.4, PI, TAU);
  }
}

void forms(int cc, float grid, float dd) {

  for (int i = 0; i < cc; i++) {

    float x1 = swidth*random(random(0.5), random(0.5, 1));
    float y1 = sheight*random(random(0.5), random(0.5, 1));
    //float x2 = x1+random(-size, size)*random(0.5)*random(1);
    //float y2 = y1+random(-size, size)*random(0.5);

    x1 -= x1%grid;
    y1 -= y1%grid;
    //x2 -= x2%grid;
    //y2 -= y2%grid;

    if (random(1) < 0.5) {
      x1 -= x1%(grid*2);
      y1 -= y1%(grid*2);
      //x2 -= x2%(grid*2);
      //y2 -= y2%(grid*2);
    }

    x1 += grid*0.5;
    y1 += grid*0.5;
    //x2 += grid*0.5;
    //y2 += grid*0.5;

    float det = 0.001*random(random(10))*dd;
    noStroke();
    fill(rcol());
    beginShape();
    noiseCir2(x1, y1, grid*random(1), det*4);
    endShape();
  }
}

void noiseCir2(float x1, float y1, float s, float det) {
  ArrayList<PVector> points = new ArrayList<PVector>();

  float r = s*0.5;
  float lar = TAU*r;

  float ix = 0;
  float iy = 0;
  float des = random(1000);
  noiseDetail(int(random(1, 7)));
  points.add(new PVector(ix, iy));
  for (int k = 0; k < lar; k++) {
    float ang = (noise(des+ix*det, des+iy*det)*2-1)*PI*3.8;
    ix += cos(ang);
    iy += sin(ang);
    points.add(new PVector(ix, iy));
  }

  PVector p1 = points.get(0);
  PVector p2 = points.get(points.size()-1);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);
  float dis = p1.dist(p2);


  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    p.rotate(-ang);
    p.mult((lar*1./dis));
  }

  noStroke();
  fill(rcol());
  beginShape();
  for (int k = 0; k < points.size(); k++) {
    PVector p = points.get(k);
    vertex(x1+p.x, y1+p.y);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#180821, #0019BF, #F47AF0, #FFE049, #EADCD3};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
