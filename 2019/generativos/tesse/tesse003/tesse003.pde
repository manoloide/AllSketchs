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
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
    seed = int(random(999999));
    generate();
  }
}



void generate() { 

  println(seed);
  randomSeed(seed);
  background(rcol());
  scale(scale);

  int sw = int(random(8, 20));
  float ww = width*1./sw;
  int sh = int(random(8, 20)*2);
  float hh = height*1./sh;

  rectMode(CENTER);

  int res = 120;
  noiseDetail(2);
  ArrayList<PVector> line1 = createLine(0, 0, ww, 0, res);
  ArrayList<PVector> line2 = createLine(0, 0, ww, 0, res);

  stroke(0, 10);
  for (int j = -2; j < sh+2; j++) {
    for (int i = -2; i < sw+2; i++) {

      float x = (i+0.5)*ww;
      float y = (j+0.5)*hh;


      float s = 1; //constrain(noise(des+x*det, des+y*det)*3-0.5, 0.5, 1);
      int ind = abs((i+j)%4)+j%2;
      fill(getColor(ind));
      drawMosaic(x, y, ww*s, hh*s, line1, line2, ((j%2) >= 1));
      /*
      noFill();
       stroke(0, 40);
       rect(x, y, ww, hh);
       
       fill(0);
       text(ind, x, y);
       */
    }
  }
}

ArrayList<PVector> createLine(float x1, float y1, float x2, float y2, int res) {
  ArrayList<PVector> line = new ArrayList<PVector>();

  float xx = 0;
  float yy = 0;

  float desAng = random(1000);
  float detAng = random(0.2);

  float amp = random(0.6, 1)*2.2;

  for (int i = 0; i < res; i++) {
    line.add(new PVector(xx, yy));
    float ang = noise(desAng+xx*detAng, desAng+yy*detAng)*TAU*amp;
    xx += cos(ang);
    yy += sin(ang);
  }

  PVector last = line.get(line.size()-1);
  float ang = atan2(last.y, last.x)-atan2(y2-y1, x2-x1);

  float dis = dist(x1, y1, x2, y2);
  float newMag = dis/last.mag();

  for (int i = 0; i < line.size(); i++) {
    PVector p = line.get(i);
    p.rotate(-ang);
    p.mult(newMag);
  }

  return line;
}

void drawMosaic(float x, float y, float w, float h, ArrayList<PVector> line1, ArrayList<PVector> line2, boolean inv) {
  x -= w*0.5;
  y -= h*0.5;

  beginShape();
  if (inv) {
    vline(x, y, x+w, y, line1, false);
    //vline(x+w, y, x+w, y+h, line2, false);
    vline(x+w, y+h, x, y+h, line1, true);
   // vline(x, y+h, x, y, line2, false);
  } else {
    vline(x+w, y, x, y, line1, true);
    //vline(x+w, y, x+w, y+h, line2, false);
    vline(x, y+h, x+w, y+h, line1, false);
  }
  endShape();
}

void vline(float x1, float y1, float x2, float y2, ArrayList<PVector> line, boolean inv) {
  float lineDis = line.get(0).dist(line.get(line.size()-1));
  float dis = dist(x1, y1, x2, y2);
  float mul = dis/lineDis;
  float ang = atan2(y2-y1, x2-x1);
  for (int i = 0; i < line.size(); i++) {
    int ind = i;
   //if (inv) ind = line.size()-1-i;
    PVector p = line.get(ind).copy();
    if(inv) p.y *= -1;
    p.rotate(ang);
    p.mult(mul);

    vertex(x1+p.x, y1+p.y);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
