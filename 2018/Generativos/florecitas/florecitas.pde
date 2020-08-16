import toxi.math.noise.SimplexNoise;

int seed = 0;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  if(key == LEFT){
     seed--;
     generate();
  }
  else if (key == RIGHT){
     generate();
     seed++; 
  }
  else {
    //seed = int(random(999999));
    generate();
  }
}

void generate() {
  
  println("seed", seed);
  
  background(0);
  randomSeed(seed);

  background(getColor());

  defx = random(0.08, 0.12)*random(2);
  defy = random(0.08, 0.12)*random(2);

  desAng = random(1000);
  detAng = random(0.006, 0.01)*0.04;
  desDes = random(1000);
  detDes = random(0.006, 0.01)*0.04;


  int cc = int(random(60, 80)*1.4);
  float ss = width*1./cc;
  /*
  stroke(255, 10);
   for (int i = 0; i <= cc; i++) {
   l(ss*i, 0, ss*i, height);
   l(0, ss*i, width, ss*i);
   }
   */

  /*
  ArrayList<PVector> rocks = new ArrayList<PVector>();
   for (int i = 0; i < rocks.size(); i++) {
   float x = random(width);
   float y = random(height);
   float s = random(48);
   rocks.add(new PVector(x, y, s));
   }
   */
  stroke(255);
  noStroke();
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      if (random(1) < 0.1) continue;
      fill(rcol(), random(200));
      c((i+0.5)*ss, (j+0.5)*ss, ss*0.1);
    }
  }


  //colors = back;
  noStroke();
  beginShape();
  fill(rcol(), random(40, 60)*0.8);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), random(40, 60)*0.8);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  beginShape();
  fill(rcol(), random(40, 60)*0.8);
  vertex(0, height);
  vertex(0, 0);
  fill(rcol(), random(40, 60)*0.8);
  vertex(width, 0);
  vertex(width, height);
  endShape(CLOSE);

  float des = random(1000);
  float det = random(0.01);
  float desP = random(1000);
  float detP = random(0.003, 0.004);


  float desc = random(1000);
  float detc = random(0.01);

  //colors = koi;

  float lar = random(32, 42);
  for (int i = 0; i < 800; i++) {
    float x = random(width);
    float y = random(height);
    noFill();
    stroke(rcol());
    beginShape();
    for (int j = 0; j < lar; j++) {
      float v = j*1./lar;
      float n = noise(desc+x*detc, desc+y*detc);
      strokeWeight(0.2+v*0.6);
      stroke(getColor(n+v*0.2), v*120);

      PVector p = water(x, y);
      vertex(p.x, p.y);
      float ang = noise(desP+x*detP, desP+y*detP)*TAU*3;
      x += cos(ang);
      y += sin(ang);
    }
    endShape();
  }
  
  float detC = random(0.002, 0.004)*0.4;
  float desC = random(1000);

  for (int i = 0; i < 520; i++) {
    float x = int(random(cc+1))*ss;
    float y = int(random(cc+1))*ss;
    float s = ss*random(0.6, 0.6)*2*int(pow(noise(des+x*det, des+y*det), 1.3)*6);
    float a = random(1.5, 2)*PI;

    float ic = noise(desC+x*detC, desC+y+detC)*2;//random(1);
    for (float j = 1; j > 0; j-=0.03) {
      stroke(0, 4);
      fill(getColor(pow(j*0.24, 1.3)+ic));
      flower(x, y, s*j*1.4, random(TAU));
    }
  }
}

void nenufar(float x, float y, float s, float a) {
  float r = s;
  int seg = int(max(8, s*PI));
  float da = TAU/seg;
  beginShape();
  for (int j = 0; j < seg; j++) {
    float ang = da*j;
    float rr = cos(ang)*2*r*(1-(max(0, cos(ang))));
    PVector p = new PVector(x+cos(ang+a)*rr, y+sin(ang+a)*rr);
    p = desform(p.x, p.y);
    //p = water(p.x, p.y);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void flower(float x, float y, float s, float a) {
  float r = s;
  int seg = int(max(8, s*PI*3));
  float da = TAU/seg;
  beginShape();
  for (int j = 0; j < seg; j++) {
    float ang = a+da*j;
    float rr = cos(da*j)*2*r;
    PVector p = desform(x+cos(ang)*rr, y+sin(ang)*rr);
    //p = water(p.x, p.y);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
  /*
  float ia2 = random(TAU);
  float da2 = TAU/9;
  stroke(rcol(), 80);
  strokeWeight(0.4);
  noFill();
  for(int i = 0; i < 90; i++){
    l(x, y, x+cos(ia2+da2*i)*s, y+sin(ia2+da2*i)*s);
  }
  strokeWeight(1);
  */
}

void c(float x, float y, float s) {
  float r = s;
  int seg = int(max(8, s*PI));
  float da = TAU/seg;
  beginShape();
  for (int j = 0; j < seg; j++) {
    PVector p = desform(x+cos(da*j)*r, y+sin(da*j)*r);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

void l(float x1, float y1, float x2, float y2) {
  int cc = int(dist(x1, y1, x2, y2));
  beginShape();
  for (int i = 0; i <= cc; i++) {
    float v = i*1./cc;
    float x = lerp(x1, x2, v);
    float y = lerp(y1, y2, v);
    PVector p = desform(x, y);
    p = water(p.x, p.y);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}

float defx = random(0.08, 0.12);
float defy = random(0.08, 0.12);

PVector desform(float x, float y) {
  float dx = x+cos(x*defx)*4;
  float dy = y+sin(y*defy)*4;
  return new PVector(dx, dy);
}

float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.01);

PVector water(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*8; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #F94D21, #FFEDE8}; //EFFF43

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
