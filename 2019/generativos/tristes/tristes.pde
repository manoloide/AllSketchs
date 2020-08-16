import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

PShader noiseShader;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
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

  background(255);

  translate(width*0.5, height*0.5);
  //scale(2);
  translate(-width*0.5, -height*0.5);

  float detSize = random(0.0003, 0.0006)*12;
  float desSize = random(1000);

  rectMode(CENTER);
  for (int j = 0; j < height; j+=10) {
    for (int i = 0; i < width; i+=10) {
      float noi = noise(desSize+i*detSize, desSize+j*detSize);
      float ss = 10*pow(2, int(random(4)*random(1)*random(1)));

      if (0.5 > noi) {
        noFill();
        if (random(1) < 0.012) fill(rcol(), 120);
        ss *= pow(constrain((0.5-noi)*10, 0, 1), 0.7);

        stroke(rcol(), random(120)*random(1));
        //fill(rcol(), random(180));
        rect(i, j, ss, ss);
        if (random(0.1) < 0.02) {
          noStroke(); 
          rect(i, j, ss*0.25, ss*0.25);
        }
      } else {
        if (random(1) < 0.02) {
          fill(rcol(), 250);
          float ms = random(1, 4);
          //pushMatrix();
          //translate(i, j);
          //rotate(random(TAU*2));
          //triangle(-ms, -ms*0.4, -ms, +ms*0.4, ms, 0);
          ellipse(i, j, ms, ms);
          if (random(1) < 0.2) {
            noFill();
            //stroke(rcol(), random(100));
            fill(rcol(), random(100));
            ellipse(i, j, ms*20, ms*20);
            ellipse(i, j, ms*12, ms*12);
          }
          //popMatrix();
        }

        noStroke();
        fill(rcol(), random(220)*random(1));
        float sss = random(2);
        rect(i, j, sss, sss);
      }
    }
  }

  beginShape();
  fill(rcol(), 30);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 30);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  randomSeed(seed);
  noiseSeed(seed);

  //background(250);

  float desCol = random(1000);
  float detCol = random(0.001, 0.002)*0.1;

  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> rects = new ArrayList<PVector>();
  for (int i = 0; i < 10; i++) {
    float x = pow(random(1), 3)*width*1.0*random(1)*random(1)*((random(1) < 0.5)? -1 : 1)*random(0.5, 1)+width*0.5;
    float y = pow(random(1), 3)*height*1.0*random(1)*random(1)*((random(1) < 0.5)? -1 : 1)*random(0.5, 1)+height*0.5;

    points.add(new PVector(x, y));
  }

  for (int i = 0; i < 16; i++) {
    float x = random(40, width-40);
    float y = random(40, height-40);
    float ss = 10*int(random(2, int(random(7))));

    if (random(1) < 0.2) {
      x -= x%ss;
      y -= y%ss;
    } else {
      x -= x%ss;
      y -= y%ss;
    }

    points.add(new PVector(x, y));
    points.add(new PVector(x+ss, y));
    points.add(new PVector(x+ss, y+ss));
    points.add(new PVector(x, y+ss));
    if (random(1) < 0.2) rects.add(new PVector(x+ss*0.5, y+ss*0.5, ss));
  }

  for (int j = 0; j < points.size(); j++) {
    PVector p1 = points.get(j);
    for (int i = j+1; i < points.size(); i++) {
      PVector p2 = points.get(i);
      if (p1.dist(p2) < 1) {
        points.remove(i--);
      }
    }
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(points);
  ArrayList<PVector> centers = new ArrayList<PVector>();

  float des = random(1000);
  float det = random(0.0006, 0.001);
  for (int k = 0; k < 5; k++) {
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      PVector pp = t.p1;
      if (random(1) < 0.333) {
      } else {
        if (random(1) < 0.5) pp = t.p2;
        else pp = t.p3;
      }
      float xx = pp.x;
      float yy = pp.y;
      noFill();
      noFill();
      float desAng = random(-0.2, 0.2);
      beginShape();
      float dd = random(40, 60)*10;
      float ic = 0;
      float vc = random(0.0009);
      for (int j = 0; j < dd; j++) {
        if (j == 0) ic = noise(desCol+xx*detCol*2, desCol+yy*detCol*2, 190);
        ic += vc;
        float ang = noise(des+xx*det, des+yy*det)*TAU*6;
        xx += cos(ang+desAng);
        yy += sin(ang+desAng);
        int col = getColor(ic*colors.length*2);
        float alp = map((j*1./dd), 0, 1, 80, 50); //60
        stroke(col, alp);
        vertex(xx, yy);
      }
      endShape();
    }
  }


  noFill();
  beginShape(TRIANGLE);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    stroke(rcol(), random(255));
    noiseShader.set("displace", random(100));
    shader(noiseShader);
    centers.add(t.p1.copy().add(t.p2).add(t.p3).div(3));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();


  tris = Triangulate.triangulate(centers);
  noStroke();
  beginShape(TRIANGLE);
  stroke(255, 190);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    noiseShader.set("displace", random(100));
    int col1 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 520)*colors.length*2);
    int col2 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 402)*colors.length*2);
    int col3 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 120)*colors.length*2);
    shader(noiseShader);
    fill(col1, random(random(120), 250));
    vertex(t.p1.x, t.p1.y);
    if (random(1) < 0.2) fill(col2, random(random(120), 250));
    vertex(t.p2.x, t.p2.y);
    if (random(1) < 0.2) fill(col3, random(random(120), 250));
    vertex(t.p3.x, t.p3.y);
  }
  noStroke();
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    noiseShader.set("displace", random(100));
    int col1 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 190)*colors.length*2);
    int col2 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 602)*colors.length*2);
    int col3 = getColor(noise(desCol+t.p1.x*detCol, desCol+t.p1.y*detCol, 820)*colors.length*2);
    shader(noiseShader);
    fill(col1, random(250));
    vertex(t.p1.x, t.p1.y);
    if (random(1) < 0.2) fill(col2, random(250));
    vertex(t.p2.x, t.p2.y);
    if (random(1) < 0.2) fill(col3, random(250));
    vertex(t.p3.x, t.p3.y);
  }

  int sel = int(random(3));
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    noiseShader.set("displace", random(100));
    shader(noiseShader);
    fill(0, 0);
    if (sel == 0) fill(0, random(40));
    vertex(t.p1.x, t.p1.y);
    fill(0, 0);
    if (sel == 0) fill(0, random(40));
    vertex(t.p2.x, t.p2.y);
    fill(0, 0);
    if (sel == 0) fill(0, random(40));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    noiseShader.set("displace", random(100));
    shader(noiseShader);

    float ms = r.z*0.5;
    shadow(r.x, r.y, ms);

    noiseShader.set("displace", random(100));
    shader(noiseShader);
    fill(rcol());
    rect(r.x, r.y, r.z, r.z);
    fill(rcol());
    rect(r.x, r.y, r.z*0.5, r.z*0.5);
    beginShape();
    vertex(r.x-ms, r.y-ms);
    vertex(r.x+ms, r.y-ms);
    vertex(r.x, r.y-ms*1.5);
    endShape();
    /*
    beginShape();
     fill(rcol(), 240);
     vertex(r.x-ms, r.y+ms);
     vertex(r.x+ms, r.y+ms);
     fill(rcol(), 0);
     vertex(r.x+ms, r.y+ms*12);
     vertex(r.x-ms, r.y+ms*12);
     endShape();
     */
  }


  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    noiseShader.set("displace", random(100));
    shader(noiseShader);
    float ss = random(3)*random(1);
    fill(rcol());
    ellipse(t.p1.x, t.p1.y, ss, ss);
    fill(rcol());
    //ellipse(t.p2.x, t.p2.y, 3, 3);
    fill(rcol());
    //ellipse(t.p3.x, t.p3.y, 3, 3);
  }
  
  for(int i = 0; i < 1000; i++){
     float x = random(width);
     float y = random(height);
     
     float s = 20;
     
     x -= x%20;
     y -= y%20;
     
     fill(255);
     ellipse(x, y, 2, 2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

void shadow(float x, float y, float s) {
  float dx = -1;
  float dy = -1;
  if (random(1) < 0.5) dx = 1; 

  float mirH = (random(1) < 0.5)? -1 : 1;
  float mirV = (random(1) < 0.5)? -1 : 1;

  int col = rcol();

  float ms = s*0.5;
  float amp = 20;

  noStroke();
  beginShape();
  fill(col, random(200, 250));
  vertex(x-ms*dx*mirH, y-ms*dy*mirV);
  vertex(x+ms*dx*mirH, y+ms*dy*mirV);
  fill(col, 0);
  vertex(x+ms*dx*mirH+ms*amp*mirH, y+ms*dy*mirV+ms*amp*mirV);
  vertex(x-ms*dx*mirH+ms*amp*mirH, y-ms*dy*mirV+ms*amp*mirV);
  endShape(CLOSE);
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#320399, #E07AFF, #EA1026, #FFD70F};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
