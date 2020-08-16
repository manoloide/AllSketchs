import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

void generate() {



  randomSeed(seed);
  noiseSeed(seed);
  desAng = random(1000);
  detAng = random(0.0035, 0.0055)*0.2;
  desDes = random(1000);
  detDes = random(0.0035, 0.0055)*0.2;

  background(0, 2, 4);

  blendMode(NORMAL);
  for (int i = 0; i < 50; i++) {
    fill(rcol()); 
    float det = random(0.01);
    float y = height*random(0.2, 1);
    beginShape();
    for (int j = 0; j < width; j++) {
      float noi = constrain(noise(j*det)*4-2, 0, 1);
      float h = width*(0.2-noi*0.05);
      vertex(j, h+y);
    }
    endShape();
  }


  int sub = 1000;

  for (int k = 0; k < 4; k++) {
    float ic1 = random(colors.length);
    float dc1 = random(0.1)*random(0.4, 1)*0.2;  
    float ic2 = random(colors.length);
    float dc2 = random(0.1)*random(0.4, 1)*0.2;

    float pwr = 4.2;//random(1, 3);

    noStroke();
    //stroke(#152425, 20);
    for (int i = 0; i < sub; i++) {
      float v1 = pow(map(i, 0, sub, 0, 1), pwr)*0.8+0.2;
      float v2 = pow(map(i+1, 0, sub, 0, 1), pwr)*0.8+0.2;
      float y1 = v1*height;
      float y2 = v2*height;

      beginShape();
      fill(getColor(ic1+dc1*(i+1)), 180);
      vertex(0, y2);
      fill(getColor(ic1+dc1*(i)), 180);
      vertex(0, y1);
      fill(getColor(ic2+dc2*(i)), 180);
      vertex(width, y1);
      fill(getColor(ic2+dc2*(i+1)), 180);
      vertex(width, y2);
      endShape(CLOSE);
    }
  }

  noStroke();
  beginShape(QUAD);
  fill(0, 150);
  vertex(0, 0);
  vertex(width, 0);
  fill(0, 0);
  vertex(width, height*0.8);
  vertex(0, height*0.8);


  fill(0, 130);
  vertex(0, 0);
  vertex(width, 0);
  fill(0, 0);
  vertex(width, height*0.3);
  vertex(0, height*0.3);

  endShape();



  for (int i = 0; i<  10; i++) {
    float x = random(width);
    float y = height*random(0.16, 0.2);
    float s = random(4)*random(1)*random(1);
    noStroke();
    fill(rcol(), 250);
    ellipse(x, y, s, s);

    beginShape(LINES);
    stroke(rcol(), 50);
    vertex(x, y);
    stroke(rcol(), 0);
    vertex(x, height*0.2);
    endShape();
  }

  noFill();
  float detCol = random(0.002);
  float det = random(0.005, 0.006)*0.1;
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = height*random(0.2, 1);
    int col = lerpColor(color(255, 40), getColor(noise(x*detCol, y*detCol)*colors.length*2), 0.5);
    stroke(col, 20);//getColor(noise(x*detCol, y*detCol)*colors.length*2), 200);
    beginShape();
    for (int j = 0; j < 20; j++) {
      float a = noise(x*det, y*det)*TAU*20;
      vertex(x, y);
      x += cos(a);
      y += sin(a);
    }
    endShape();
  }

  ArrayList<PVector> pts1 = new ArrayList<PVector>();
  ArrayList<PVector> pts2 = new ArrayList<PVector>();

  noStroke();
  stroke(255, 20);
  for (int i = 0; i < 100; i++) {
    float val = random(0.2, random(0.2, random(0.2, 1.2)));
    float x = width*random(random(0.2), random(0.8, 1));
    float y = height*val;
    float s = random(8, 10)*5;
    //fill(rcol());
    //ellipse(x, y, 2, 2);
    float y2 = y-s*(val-0.18);
    line(x, y, x, y2);
    ellipse(x, y2, 4*val, 4*val);
    pts1.add(new PVector(x, y2));
    pts2.add(new PVector(x, y));
  }

  blendMode(ADD);



  sub = int(random(6, 10));
  //float dd = height/(sub+1);
  stroke(255, 80);
  for (int j = 0; j < sub*10; j++) {
    for (int i = 0; i < sub*10; i++) {
      float xx = map(i+0.5, 0, sub*10, 0, width);
      float yy = map(j+0.5, 0, sub*10, 0, height);
      point(xx, yy);
    }
  }

  ArrayList<Triangle> tris1 = Triangulate.triangulate(pts1);
  ArrayList<Triangle> tris2 = Triangulate.triangulate(pts2);
  beginShape(TRIANGLES);
  noFill();
  stroke(rcol(), 20);
  for (int i = 0; i < tris1.size(); i++) {
    if (random(1) < 0.5) continue;
    fill(rcol(), 90);
    Triangle t1 = tris1.get(i);
    PVector cen = t1.p1.copy().add(t1.p2).add(t1.p3).div(3);

    vertex(t1.p1.x, t1.p1.y);
    vertex(t1.p2.x, t1.p2.y);
    vertex(t1.p3.x, t1.p3.y);


    vertex(t1.p1.x, t1.p1.y);
    vertex(t1.p2.x, t1.p2.y);
    vertex(t1.p3.x, t1.p3.y);


    fill(rcol(), 160);
    vertex(t1.p1.x, t1.p1.y);
    fill(rcol(), 0);
    vertex(t1.p2.x, t1.p2.y);
    vertex(t1.p3.x, t1.p3.y);


    fill(rcol(), 120);
    vertex(t1.p1.x, t1.p1.y);
    fill(rcol(), 0);
    vertex(t1.p2.x, t1.p2.y);
    vertex(t1.p3.x, t1.p3.y);
  }
  endShape();


  noStroke();
  for (int i = 0; i < 40; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.6)*random(random(1));
    fill(rcol(), 120);
    circle(x, y, s);//(x, y, s, s);
    fill(255);
    circle(x, y, s*0.1);
    ;//(x, y, s*0.1, s*0.1);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}


float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector desform(float x, float y) {
  float ang = noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = noise(desDes+x*detDes, desDes+y*detDes)*80; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  int cc = int(max(8, r*PI));
  float da = TAU/cc;
  int c1 = rcol();
  int c2 = rcol();

  //c2 = lerpColor(c1, c2, random(0.1));
  c1 = c2;
  float alp1 = 240;//random(120)*random(1);
  float alp2 = 240;//random(120)*random(1);
  PVector p1 = new PVector();
  PVector p2 = new PVector();
  PVector c = desform(x, y);
  beginShape(TRIANGLE);
  for (int i = 0; i <= cc; i++) {
    p1 = desform(x+cos(da*i)*r, y+sin(da*i)*r);
    if (i > 0) {
      fill(c1, alp1);
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      fill(c2, alp2);
      vertex(c.x, c.y);
    }
    p2.set(p1);
  }
  endShape(CLOSE);
}

void aro(float x, float y, float s1, float s2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = int(max(8, max(r1, r2)*PI));
  float da = TAU/cc;
  int c1 = getColor();
  int c2 = getColor();
  c1 = c2;
  float alp1 = 240;//random(120)*random(1);
  float alp2 = 240;//random(120)*random(1);
  PVector a1 = new PVector();
  PVector a2 = new PVector();
  PVector c = desform(x, y);
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= cc; i++) {
    a1 = desform(x+cos(da*i)*r1, y+sin(da*i)*r1);
    if (i > 0) {
      fill(c1, alp1);
      vertex(a1.x, a1.y);
      vertex(a2.x, a2.y);
    }
    a2.set(a1);
  }
  endShape(CLOSE);
}


//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
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
  return lerpColor(c1, c2, pow(v%1, 10.8));
}
