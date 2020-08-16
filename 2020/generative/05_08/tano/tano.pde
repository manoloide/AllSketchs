import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  
  img = loadImage("diente.png");

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
  background(250);

  ArrayList<PVector> points = new ArrayList<PVector>();
  noStroke();
  for (int i = 0; i < 60; i++) {
    float xx = width*random(-0.5, 1.5); 
    float yy = height*random(-0.5, 1.5);
    xx -= xx%30;
    yy -= yy%30;
    float ss = width*random(random(0.01, 0.1), 0.6)*0.4*random(1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(xx, yy, other.x, other.y) < (ss+other.z)*0.3) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add(new PVector(xx, yy, ss));
    }
  }


  for (int i = 0; i < 18000*4; i++) {
    float xx = width*random(-0.5, 1.5); 
    float yy = height*random(-0.5, 1.5);
    float ss = width*random(random(0.01, 0.1), 0.6)*0.06*random(0.2, 1);
    boolean add = true;
    boolean inRange = false;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      float dist = dist(xx, yy, other.x, other.y);
      if (dist < (ss+other.z)*0.6) {
        add = false;
        break;
      } else if (dist < (ss+other.z)*0.8) {
        inRange = true;
      }
    }
    if (add && inRange) {
      points.add(new PVector(xx, yy, ss));
    }
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  int cc = rcol();

  /*
   stroke(cc);
   strokeWeight(1.2);
   noStroke();
   beginShape(TRIANGLES);
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = triangles.get(i);
   fill(rcol());
   vertex(t.p1.x, t.p1.y);
   fill(rcol());
   vertex(t.p2.x, t.p2.y);
   fill(rcol());
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */

  /*
  strokeWeight(3);
   stroke(#040DDE);
   for (int i = 0; i < points.size(); i++) {
   
   PVector p = points.get(i);
   float xx = p.x; 
   float yy = p.y; 
   float ss = p.z;
   
   float hh = width*random(0.2, 0.5);
   float x2 = lerp(xx, width*0.5, 0.2);
   
   fill(rcol());
   line(xx, yy, x2, yy+hh);
   }
   */
  noStroke();
  float det = random(0.001);
  for (int i = 0; i < points.size(); i++) {

    PVector p = points.get(i);
    float xx = p.x; 
    float yy = p.y; 
    float ss = p.z;

    //arc(xx, yy, ss*10, ss*2, 0, 0, 0, 12);
    //arc(xx, yy, ss*4, ss*2, rcol(), 0, rcol(), 40);
    
    tint(rcol());
    imageMode(CENTER);
    float s = ss*random(2.5, 3);
    image(img, xx, yy, s, s);
    
    float ncol = noise(xx*det, yy*det)*colors.length;
    fill(getColor(ncol));
    ellipse(xx, yy, ss*2, ss*2);
    fill(rcol());
    ellipse(xx, yy, ss*0.4, ss*0.4);
    fill(rcol());
    ellipse(xx, yy, ss*0.12, ss*0.12);
  }

  for (int i = 0; i < points.size(); i++) {

    PVector p = points.get(i);
    float xx = p.x; 
    float yy = p.y; 
    float ss = p.z;

    fill(rcol());
    //arc(xx, yy, ss*4, ss*2, 0, 0, 0, 4);
  }

  /*
  for (int i = 0; i < points.size(); i++) {
   
   PVector p = points.get(i);
   float xx = p.x; 
   float yy = p.y; 
   float ss = p.z;
   
   fill(rcol());
   ellipse(xx, yy, ss, ss);
   
   if (p.z > width*0.01) {
   float ang = random(TAU);
   float r = ss*0.5;
   int sep = int(random(5, int(random(10, 20))));
   float da = TAU/sep;
   beginShape(TRIANGLES);
   float amp = random(1);
   for (int j = 0; j < sep; j++) {
   fill(rcol());
   float a = ang+da*j;
   float dd = da*0.04*amp;
   vertex(xx, yy);
   vertex(xx+cos(a-dd)*r, yy+sin(a-dd)*r);
   vertex(xx+cos(a+dd)*r, yy+sin(a+dd)*r);
   //line(x, y, xx, yy);
   }
   endShape(CLOSE);
   stroke(rcol(), 10);
   //arc(xx, yy, ss, ss*4.2, 0, 20, 0, 0);
   noStroke();
   //arc(xx, yy, ss*3.9, ss*4.1, rcol(), 20, rcol(), 0);
   arc(xx, yy, ss, ss*2, color(255), 0, color(255), 90);
   arc(xx, yy, ss*1.4, ss*2, color(255), 0, color(255), 90);
   arc(xx, yy, ss*1.8, ss*2, 0, 0, 0, 10);
   arc(xx, yy, ss, ss*2, 0, 0, 0, 20);
   arc(xx, yy, ss, ss*0.6, rcol(), 200, rcol(), 0);
   arc(xx, yy, ss, ss*0.7, color(0), 50, color(0), 0);
   fill(rcol());
   ellipse(xx, yy, ss*0.5, ss*0.5);
   fill(rcol());
   ellipse(xx, yy, ss*0.4, ss*0.4);
   }
   }
   */

  /*
  stroke(0, 30);
   strokeWeight(1.2);
   for (int k = 0; k < 4; k++) {
   noFill();
   beginShape(TRIANGLES);
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = triangles.get(i);
   //fill(rcol(), 0);
   vertex(t.p1.x, t.p1.y);
   vertex(t.p2.x, t.p2.y);
   //fill(rcol());
   vertex(t.p3.x, t.p3.y);
   
   PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
   vertex(lerp(t.p1.x, cen.x, 0.8), lerp(t.p1.y, cen.y, 0.8));
   vertex(lerp(t.p2.x, cen.x, 0.8), lerp(t.p2.y, cen.y, 0.8));
   vertex(lerp(t.p3.x, cen.x, 0.8), lerp(t.p3.y, cen.y, 0.8));
   
   float ang = random(TAU);
   float amp = sqrt(random(1))*k*random(0.6, 1);
   t.p1.x += cos(ang)*amp;
   t.p1.y += sin(ang)*amp;
   
   ang = random(TAU);
   amp = sqrt(random(1))*k*random(0.6, 1);
   t.p2.x += cos(ang)*amp;
   t.p2.y += sin(ang)*amp;
   
   ang = random(TAU);
   amp = sqrt(random(1))*k*random(0.6, 1);
   t.p3.x += cos(ang)*amp;
   t.p3.y += sin(ang)*amp;
   }
   endShape();
   }
   */
}

void arc(float x, float y, float s1, float s2, int col1, float alp1, int col2, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;

  int res = int(TAU*max(r1, r2)*0.25);
  float da = TAU*1./res;
  beginShape(QUAD_STRIP);
  for (int i = 0; i <= res; i++) {
    float a = da*i;
    fill(col1, alp1);
    vertex(x+cos(a)*r1, y+sin(a)*r1);
    fill(col2, alp2);
    vertex(x+cos(a)*r2, y+sin(a)*r2);
  }
  endShape(CLOSE);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#DD1616, #72522A, #EDF4F9, #EA9FB6, #202DA3};
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
