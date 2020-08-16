import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  3250; 
float nheight = 3250;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = true;

PShader noiseShader;


void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(2);
  pixelDensity(2);
}

void setup() {

  noiseShader = loadShader("noiseFrag.glsl");

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

  randomSeed(seed);
  noiseSeed(seed);
  
  scale(scale);

  background(240);
  rectMode(CENTER);
  noStroke();


  ArrayList<PVector> rects = new ArrayList<PVector>();
  for (int i = 0; i < 80; i++) {
    float x = random(-200, swidth+200);
    float y = random(-200, sheight+200);

    x -= x%20;
    y -= y%20;

    float s = 20+int(random(30)*random(0.4, 1))*10;
    rects.add(new PVector(x, y, s));
  }


  noStroke();
  noiseShader = loadShader("noiseFrag.glsl");
  ArrayList<Triangle> tris = Triangulate.triangulate(rects);
  beginShape(TRIANGLES);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    noiseShader.set("displace", random(100));
    shader(noiseShader);
    fill(rcol(), random(random(200, 220), 255));
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), random(random(200, 220), 255));
    vertex(t.p2.x, t.p2.y);
    fill(rcol(), random(random(200, 220), 255));
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);

  resetShader();



  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 140; i++) {
    float x = random(-200, swidth+200);
    float y = random(-200, sheight+200);
    float s = 10*int(random(1, random(1, 5)));//random(20);


    x -= x%20;
    y -= y%20;

    fill(rcol(), random(200, 255));
    rect(x, y, s, s);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) { 
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < 1) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y));
  }


  int sel = int(random(3));
  noFill();
  stroke(240, 70);
  ArrayList<Triangle> grid = Triangulate.triangulate(points);
  beginShape(TRIANGLES);
  for (int i = 0; i < grid.size(); i++) {
    Triangle t = grid.get(i);
    if (sel == 0) fill(255, random(120));
    else fill(255, 0);
    vertex(t.p1.x, t.p1.y);
    if (sel == 1) fill(255, random(120));
    else fill(255, 0);
    vertex(t.p2.x, t.p2.y);
    if (sel == 2) fill(255, random(120));
    else fill(255, 0);
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);


  noStroke();
  fill(240);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 4, 4);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    noStroke();
    noFill();

    float bs = r.z*0.03;

    beginShape();
    fill(rcol(), 250);
    vertex(r.x-r.z*0.5, r.y-r.z*0.5);
    vertex(r.x+r.z*0.5, r.y-r.z*0.5);
    fill(rcol(), 240);
    vertex(r.x+r.z*0.5, r.y+r.z*0.5-bs);
    vertex(r.x-r.z*0.5, r.y+r.z*0.5-bs);
    endShape();

    beginShape();
    fill(rcol(), 250);
    vertex(r.x-r.z*0.5, r.y+r.z*0.5);
    vertex(r.x-r.z*0.5, r.y+r.z*0.5-bs);
    fill(rcol(), 250);
    vertex(r.x+r.z*0.5, r.y+r.z*0.5-bs);
    vertex(r.x+r.z*0.5, r.y+r.z*0.5);
    endShape();

    noiseShader.set("displace", random(100));
    shader(noiseShader);
    beginShape();
    fill(0, 120);
    vertex(r.x-r.z*0.5, r.y+r.z*0.5);
    vertex(r.x+r.z*0.5, r.y+r.z*0.5);
    fill(0, 0); 
    vertex(r.x+r.z*0, r.y+r.z*1.0);
    vertex(r.x-r.z*1, r.y+r.z*1.0);
    
    beginShape();
    fill(rcol(), random(240));
    vertex(r.x-r.z*0.5, r.y-r.z*0.5);
    vertex(r.x-r.z*0.5, r.y+r.z*0.5);
    fill(rcol(), 0); 
    vertex(r.x-r.z*1, r.y+r.z*1.0);
    vertex(r.x-r.z*1, r.y-r.z*1.0);
    endShape();
    endShape();
    resetShader();


    if (random(1) < 0.5) {

      float cx = r.x;
      float cy = r.y-bs*0.5;

      float ss = r.z*random(0.1, 0.4);
      float rr = ss*0.5;

      float ang = random(TAU);
      float dd = random(4, 20);
      float dx = cos(ang+HALF_PI)*rr*dd;
      float dy = sin(ang+HALF_PI)*rr*dd;

      noiseShader.set("displace", random(100));
      shader(noiseShader);
      int col = rcol();
      beginShape();
      fill(col, 250);
      vertex(cx+cos(ang)*rr, cy+sin(ang)*rr);
      vertex(cx+cos(ang+PI)*rr, cy+sin(ang+PI)*rr);
      fill(col, 0);
      vertex(cx+cos(ang+PI)*rr+dx, cy+sin(ang+PI)*rr+dy);
      vertex(cx+cos(ang)*rr+dx, cy+sin(ang)*rr+dy);
      endShape();
      resetShader();

      fill(rcol());
      ellipse(cx, cy, ss, ss);
      fill(rcol());
      if (random(1) < 0.5) {
        float amp = random(0.4, 0.8);
        ellipse(cx, cy, ss*amp, ss*amp);
      }
    }

    //rect(r.x, r.y, r.z, r.z);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#320399, #E07AFF, #EA1026, #FFD70F, #E5E5E5};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
