import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  randomSeed(seed);
  noiseSeed(seed);

  background(230);



  desAng = random(1000);
  detAng = random(0.0008);
  desDes = random(1000);
  detDes = random(0.006, 0.001)*0.5;

  float des = random(1000);
  float det = random(0.0006, 0.001)*240;

  float des2 = random(1000);
  float det2 = random(0.0006, 0.001)*240;

  int cc = int(random(30, 40)*0.8);
  int dd = int(random(5));
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float dc = noise(des2+i*det2, des2+j*det2)*80;
      for (int k = 0; k < 1; k++) {
        float nc = int(noise(des+i*det, des+j*det)*8);
        float xx = i*ss-k;
        float yy = j*ss-k*5;
        float alp1 = random(80)*random(1);
        float alp2 = random(180)*random(1);
        int col = rcol();
        noStroke();
        fill(getColor(i*dd+j+nc+dc*k));
        rect(xx, yy, ss, ss);
        beginShape();
        fill(col, 0);
        vertex(xx, yy);
        vertex(xx+ss, yy);
        fill(col, alp1);
        vertex(xx+ss, yy+ss);
        vertex(xx, yy+ss);
        endShape(CLOSE);

        fill(rcol());
        float s3 = ss*random(0.4);
        if (random(1) < 0.2) rect(xx+ss*0.5-s3*0.5, yy+ss*0.5-s3*0.5, s3, s3);

        beginShape();
        fill(col, 0);
        vertex(xx+1, yy+ss+1);
        vertex(xx+1, yy+1);
        fill(col, alp2);
        vertex(xx+ss, yy);
        vertex(xx+ss, yy+ss);
        endShape(CLOSE);


        for (int l = 0; l < 5; l++) {
          float s2 = ss*random(0.3)*random(1)*random(1);
          float x2 = xx+ss*(0.5+random(-0.2, 0.2)*random(1))-s2*0.5;
          float y2 = yy-s2;
          noStroke();
          fill(rcol());
          rect(x2, y2, s2, s2);
          fill(rcol());
        }
      }
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  for (int i = 0; i < 120; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(10, 250);

    x -= x%ss;
    y -= y%ss;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.5) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float s = ss*int(random(1, 5));

    pushMatrix();
    translate(p.x, p.y);

    float r = s*0.5;
    float vel = 5;
    float ang = random(100);
    float xx = cos(ang)*r;
    float yy = sin(ang)*r;
    beginShape();
    for (int k = 0; k < r*3; k++) {
      float x = xx+cos(ang)*vel;
      float y = yy+sin(ang)*vel;
      PVector p2 = desform(x, y);
      vertex(p2.x, p2.y);
    }
    endShape();
    int col = rcol();
    noStroke();
    rotate(int(random(8))*HALF_PI);
    beginShape();
    fill(col, 180);
    vertex(-r, 0);
    vertex(+r, 0);
    fill(col, 0);
    vertex(+r, +r*8);
    vertex(-r, +r*8);
    endShape();

    arc2(0, 0, ss, ss*5, 0, TAU, rcol(), 200, 0);

    arc2(0, 0, ss*0.2, ss, 0, TAU, rcol(), 40, 0);


    noStroke();
    fill(rcol());
    ellipse(0, 0, s, s);
    fill(255);
    //ellipse(xx, yy, 5, 5);

    strokeWeight(ss*0.05*random(1));
    strokeCap(SQUARE);
    stroke(rcol());
    float amp = random(0.2, 0.4)*0.3;
    line(-s*amp, -s*amp, +s*amp, +s*amp);
    line(-s*amp, +s*amp, +s*amp, -s*amp);
    popMatrix();
  }
}


float desAng = random(1000);
float detAng = random(0.01);
float desDes = random(1000);
float detDes = random(0.006, 0.01);

PVector desform(float x, float y) {
  float ang = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*2;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*50; 
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.25, 2));
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    endShape();
  }
}



//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
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
  return lerpColor(c1, c2, pow(v%1, 4));
}
