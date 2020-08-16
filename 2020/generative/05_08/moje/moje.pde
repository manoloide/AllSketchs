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

  generate();
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

  randomSeed(seed);
  noiseSeed(seed);
  //background(252, 250, 245);
  background(rcol());

  noStroke();



  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 4000; i++) {
    float x = width*random(0, 1);
    float y = height*random(random(1), 1);
    x -= x%5;
    y -= y%5;
    float s = random(10, 20)*random(1)*0.15;
    float w = s; 
    float h = s; 
    if (random(1) < 0.5) w *= random(8, 30);
    else h *= random(8, 30);
    if (s > 10) {
      points.add(new PVector(x, y));
    }
    fill(rcol());
    ellipse(x, y, s, s);
    //rect(x, y, w, h);
  }

  if (points.size() > 0) {
    beginShape(TRIANGLES);
    for (int i = 0; i < 10; i++) {
      PVector p1 = points.get(int(random(points.size())));
      PVector p2 = points.get(int(random(points.size()))); 
      PVector p3 = points.get(int(random(points.size()))); 
      fill(rcol(), random(255));
      vertex(p1.x, p1.y);
      fill(rcol(), random(255));
      vertex(p2.x, p2.y);
      fill(rcol(), random(255));
      vertex(p3.x, p3.y);
    }
    endShape();
  }

  rectMode(CENTER);
  for (int i = 0; i < 60; i++) {
    float rx = random(1);
    float ry =random(random(1), 1);
    float x = width*rx;
    float y = height*ry;
    x -= x%10;
    y -= y%10;
    float s = random(10, 40)*random(1)*random(10)*lerp(0.8, 1, ry);
    s *= random(3);//*random(1);
    fill(rcol());
    pushMatrix();
    translate(x, y);
    rotate(random(-0.5, 0.5)*random(0.8, 1));
    rect(0, -s*random(0.2, 0.4), s*0.5, s*4);
    fill(rcol());
    ellipse(0, 0, s*0.5, s*0.5);


    rama(0, 0, s*0.02, s*0.3, HALF_PI, 5);
    ramab(0, 0, s*random(0.2, 0.6), s*random(1, 3), PI*1.5, 10, random(5)*random(0.4, 1));
    noStroke();
    popMatrix();
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


void ramab(float x, float y, float w, float h, float a, int ite, float ampAng) {
  ite--;
  float ax = x; 
  float ay = y; 
  float nx = x+cos(a)*h;
  float ny = y+sin(a)*h;
  if (ite > 0) {

    float mw1 = w*0.6;
    float mw2 = w*0.1;

    textureMode(NORMAL);
    noStroke();

    fill(getColor(ite));
    beginShape(QUAD);
    vertex(ax+cos(a-HALF_PI)*mw1, ay+sin(a-HALF_PI)*mw1, 0, 0);
    vertex(ax+cos(a+HALF_PI)*mw1, ay+sin(a+HALF_PI)*mw1, 1, 0);
    vertex(nx+cos(a+HALF_PI)*mw2, ny+sin(a+HALF_PI)*mw2, 1, 1);
    vertex(nx+cos(a-HALF_PI)*mw2, ny+sin(a-HALF_PI)*mw2, 0, 1);
    endShape(CLOSE);

    fill(0);
    float head = random(0.3, 0.6);
    ellipse(ax, ay, mw1*head, mw1*head);
    ellipse(nx, ny, mw2*head, mw2*head);

    int cc = int(random(2, random(2, 4.6)*random(1)));
    if (ite%4 == 0) {
      float v = random(random(0.3, 0.5), 1);
      float aa = a+(random(-1, 1)*ampAng)*random(random(1), 1)*random(1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
      ramab(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.9, h*random(0.6, 0.8)*0.9, aa, ite, ampAng*1.1);
    } else {
      for (int k = 0; k < cc; k++) {
        float v = random(random(0.3, 0.5), 1);
        float aa = a+(random(-1, 1)*random(0.8, 4.2)+random(-0.4, 0.4))*random(random(1), 1)*random(1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
        ramab(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.9, h*random(0.6, 0.8)*0.9, aa, ite-int(random(1.1)), ampAng*1.1);
      }
    }
    cc = int(random(-20, 2));
    for (int k = 0; k < cc; k++) {
      float hh = dist(ax, ay, nx, ny)*random(0.2, 0.6)*10;
      //fill(rcol());
      stroke(rcol());
      noFill();
      //curve(ax, ay-hh, ax, ay, nx, ny, nx, ny-hh);
    }
  }
}

void rama(float x, float y, float w, float h, float a, int ite) {
  ite--;
  float ax = x; 
  float ay = y; 
  float nx = x+cos(a)*h;
  float ny = y+sin(a)*h;
  if (ite > 0) {

    float mw1 = w*0.6;
    float mw2 = w*0.1;

    textureMode(NORMAL);
    noStroke();

    fill(getColor(ite));
    beginShape(QUAD);
    vertex(ax+cos(a-HALF_PI)*mw1, ay+sin(a-HALF_PI)*mw1, 0, 0);
    vertex(ax+cos(a+HALF_PI)*mw1, ay+sin(a+HALF_PI)*mw1, 1, 0);
    vertex(nx+cos(a+HALF_PI)*mw2, ny+sin(a+HALF_PI)*mw2, 1, 1);
    vertex(nx+cos(a-HALF_PI)*mw2, ny+sin(a-HALF_PI)*mw2, 0, 1);

    endShape(CLOSE);

    fill(0);
    //ellipse(ax, ay, mw1*0.5, mw1*0.5);
    //ellipse(nx, ny, mw2*0.5, mw2*0.5);

    int cc = int(random(2, random(2, 4.6)*random(1)));
    if (ite%4 == 0) {
      float v = random(random(0.3, 0.5), 1);
      float aa = a+(random(-1, 1)*random(0.8, 4.2)+random(-0.4, 0.4))*random(random(1), 1)*random(1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
      rama(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.9, h*random(0.6, 0.8)*0.9, aa, ite);
    } else {
      for (int k = 0; k < cc; k++) {
        float v = random(random(0.3, 0.5), 1);
        float aa = a+(random(-1, 1)*random(0.8, 4.2)+random(-0.4, 0.4))*random(random(1), 1)*random(1);//, noise(time*random(0.1, 0.2)*0.5, random(100)));
        rama(lerp(ax, nx, v), lerp(ay, ny, v), w*random(0.6, 0.8)*0.9, h*random(0.6, 0.8)*0.9, aa, ite-int(random(1.1)));
      }
    }
    cc = int(random(-20, 2));
    for (int k = 0; k < cc; k++) {
      float hh = dist(ax, ay, nx, ny)*random(0.2, 0.6)*10;
      //fill(rcol());
      stroke(rcol());
      noFill();
      //curve(ax, ay-hh, ax, ay, nx, ny, nx, ny-hh);
    }
  } else {
    if (random(1) < 0.002) {
      fill(rcol());
      float s = w*random(20);
      //ellipse(ax, ay, s, s);
    }

    /*
    if (random(1) < 0.1) {
     for (int k = 0; k < 3; k++) {
     float hh = abs(ny-ax)*random(-0.2, 0.2);
     fill(rcol());
     curve(ax, ay-hh, ax, ay, nx, ny, nx, ny-hh);
     }
     */
    /*
      fill(rcol());
     float s = w*random(10);
     float da = PI*random(0.1);
     for (int k = 0; k < 10; k++) {
     arc(ax, ay, s, s, a+da*k, a+da*k+PI);
     }
     */
  }

  /*
    fill(rcol(), 100);
   float s = w*random(20)*random(1)*2*random(1)*random(1);
   ellipse(ax, ay, s, s);
   */
}


//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
