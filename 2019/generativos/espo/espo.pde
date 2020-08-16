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

  //background(lerpColor(rcol(), color(0), random(0.9, 1)*0.8  ));
  background(240);

  stroke(rcol());
  int sub = int(random(40, 100)*0.8);
  strokeWeight(2);
  float ss = height*1./sub;

  float det = random(0.001);

  noFill();
  for (int i = -20; i <= sub+20; i++) {
    stroke(0, 40);
    beginShape(POINTS);
    for (int j = 0; j < height; j+=3) {
      float x = i*ss+noise(i*det*0.1, j*det)*400-200;
      vertex(x, j+random(-3));
    }
    endShape();
    stroke(rcol(), 220);
    beginShape(POINTS);
    for (int j = 0; j < height; j+=3) {
      float x = i*ss+(noise(i*det*0.1, j*det)*400-200)*random(0.99, 1);
      strokeWeight(2);
      vertex(x, j+random(-1.5));
    }
    endShape();
  }
  strokeWeight(1);


  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.15);
    fill(rcol());

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      float d = dist(x, y, p.x, p.y);
      if (d < (s+p.z)*0.7) {
        add = false;
        break;
      }
    }
    if (add) {
      points.add( new PVector(x, y, s));
      circle(x, y, s);
    }
  }


  for (int i = 0; i < 14; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.1, 0.4);

    circle(x, y, s);
  }
  
    for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.05);

    circle(x, y, s);
  }
}

void circle(float x, float y, float s) {
  float r = s*0.5;
  noStroke();
  fill(0, 60);
  ellipse(x+2, y+2, s, s);
  fill(rcol());
  ellipse(x, y, s, s);

  int cc = int(r*r*PI*random(1, 5));
  if (random(1) < 0.5) blendMode(ADD);
  else blendMode(NORMAL);

  beginShape(POINTS);
  for (int j = 0; j < cc; j++) {
    float ang = random(TAU);
    float dis = random(random(0.5, 0.98));
    stroke(rcol(), 80);
    vertex(x+cos(ang)*dis*r, y+sin(ang)*dis*r);
  }
  endShape();

  beginShape(POINTS);
  for (int j = 0; j < cc*0.4; j++) {
    float ang = random(TAU);
    float dis = random(1, random(1, 1.4));
    stroke(rcol(), 80);
    vertex(x+cos(ang)*dis*r, y+sin(ang)*dis*r);
  }
  endShape();
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

int colors[] = {#FFA9E7, #FF84E8, #7F2CCB, #414361, #2A2D43};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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
  return lerpColor(c1, c2, pow(v%1, 3.8));
}
