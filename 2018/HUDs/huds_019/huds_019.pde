int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  float time = millis()*0.001;
  randomSeed(seed);
  noiseSeed(seed);

  background(10);
  int cc = 40;
  float sep = width*1./cc;

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(40));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    if (ms < 10) continue;
    rects.add(new PVector(r.x, r.y, ms));
    rects.add(new PVector(r.x+ms, r.y, ms));
    rects.add(new PVector(r.x, r.y+ms, ms));
    rects.add(new PVector(r.x+ms, r.y+ms, ms));
    rects.remove(ind);
  }

  /*
  noStroke();
   fill(255);
   for (int j = 0; j <= cc; j++) {
   for (int i = 0; i <= cc; i++) {
   ellipse(i*sep, j*sep, 2, 2);
   }
   }
   */

  PGraphics gra;
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    int w = int(r.z-2);
    gra = createGraphics(w, w, P3D);

    gra.beginDraw();
    gra.background(0);
    gra.ortho(-w*0.5, w*0.5, -w*0.5, w*0.5, 1, w*10);
    gra.translate(w*0.5, w*0.5);
    float rotx = int(random(8))*HALF_PI*0.5;
    if (random(14) < 6) rotx = int(random(6))*TWO_PI/6.;
    gra.rotateX(rotx);//HALF_PI-atan(1/sqrt(2)));
    gra.rotateZ(-HALF_PI*0.5+time*random(-0.5, 0.5));
    //box(8);

    ArrayList<Cube> cubes = new ArrayList<Cube>();
    cubes.add(new Cube(0, 0, 0, w*random(random(0.5, 1.5), 2)));
    int div = int(random(12));
    for (int j = 0; j < div; j++) {
      int ind = int(random(cubes.size()));
      Cube c = cubes.get(ind);
      float ss = c.s*0.5;
      float ms = ss*0.5;
      cubes.add(new Cube(c.x-ms, c.y-ms, c.z-ms, ss));
      cubes.add(new Cube(c.x+ms, c.y-ms, c.z-ms, ss));
      cubes.add(new Cube(c.x-ms, c.y+ms, c.z-ms, ss));
      cubes.add(new Cube(c.x+ms, c.y+ms, c.z-ms, ss));
      cubes.add(new Cube(c.x-ms, c.y-ms, c.z+ms, ss));
      cubes.add(new Cube(c.x+ms, c.y-ms, c.z+ms, ss));
      cubes.add(new Cube(c.x-ms, c.y+ms, c.z+ms, ss));
      cubes.add(new Cube(c.x+ms, c.y+ms, c.z+ms, ss));
      cubes.remove(ind);
    }

    gra.rectMode(CENTER);
    for (int j = 0; j < cubes.size(); j++) {
      Cube c = cubes.get(j);
      gra.pushMatrix();
      gra.translate(c.x, c.y, c.z);  
      gra.noFill();
      gra.stroke(255, 120);
      gra.box(c.s);
      gra.noStroke(); 
      gra.fill(255);
      gra.box(c.s*0.05);
      gra.popMatrix();
      float ss = c.s*0.04;
      float ms = c.s*0.5-ss*0.5;

      gra.pushMatrix();
      gra.translate(c.x-ms, c.y-ms, c.z-ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x+ms, c.y-ms, c.z-ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x-ms, c.y+ms, c.z-ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x+ms, c.y+ms, c.z-ms);
      gra.box(ss);
      gra.popMatrix();

      gra.pushMatrix();
      gra.translate(c.x-ms, c.y-ms, c.z+ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x+ms, c.y-ms, c.z+ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x-ms, c.y+ms, c.z+ms);
      gra.box(ss);
      gra.popMatrix();
      gra.pushMatrix();
      gra.translate(c.x+ms, c.y+ms, c.z+ms);
      gra.box(ss);
      gra.popMatrix();

      gra.pushMatrix();
      gra.noFill();
      gra.stroke(255, 120);
      gra.translate(c.x, c.y, c.z);
      if (random(1) < 1./3) gra.rotateX(HALF_PI);
      else {
        if (random(1) < 0.5) gra.rotateY(HALF_PI);
      }
      gra.translate(0, 0, cos(time*random(1))*c.s*0.5);
      gra.rect(0, 0, c.s, c.s);
      gra.popMatrix();
    }

    gra.endDraw();
    image(gra, r.x+1, r.y+1);
  }
}

class Cube {
  float x, y, z, s;
  Cube(float x, float y, float z, float s) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.s = s;
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#A8B4CE, #5C6697, #352B4D, #ED5A67, #F389A0};
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