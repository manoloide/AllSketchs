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
  int sh = int(random(8, 20));
  float hh = height*1./sh;

  rectMode(CENTER);

  float des = random(1000);
  float det = random(0.008);


  int res = 50;
  noiseDetail(2);
  ArrayList<PVector> line1 = createLine(0, 0, ww, 0, res);
  ArrayList<PVector> line2 = createLine(0, 0, 0, hh, res);

  float desCol = random(1000);
  float detCol = random(0.01);

  for (int j = -1; j < sh+1; j++) {
    for (int i = -1; i < sw+1; i++) {

      float x = (i+0.5)*ww;
      float y = (j+0.5)*hh;
      int col = getColor(noise(desCol+x*detCol, desCol+y*detCol)*8); 

      float s = constrain(noise(des+x*det, des+y*det)*3-0.5, 0.5, 1);
      s = 1;

      for (int k = 0; k < 1; k++) {
        fill(col);
        drawMosaic(x, y, ww*s, hh*s, line1, line2);
        s *= 0.8;
        col = lerpColor(col, getColor(), random(0.14));
      }
    }
  }
}

ArrayList<PVector> createLine(float x1, float y1, float x2, float y2, int res) {
  ArrayList<PVector> line = new ArrayList<PVector>();

  float xx = 0;
  float yy = 0;

  float desAng = random(1000);
  float detAng = random(0.2);

  float amp = random(0.2, 1)*10.2;

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

void drawMosaic(float x, float y, float w, float h, ArrayList<PVector> line1, ArrayList<PVector> line2) {
  x -= w*0.5;
  y -= h*0.5;

  noStroke();
  fill(g.fillColor);
  beginShape();
  for (int i = 0; i < line1.size(); i++) {
    PVector p = line1.get(i);
    vertex(x+p.x, y+p.y);
  }

  for (int i = 0; i < line2.size(); i++) {
    PVector p = line2.get(i);
    vertex(x+p.x+w, y+p.y);
  }


  for (int i = 0; i < line1.size(); i++) {
    PVector p = line1.get(line1.size()-i-1);
    vertex(x+p.x, y+p.y+h);
  }

  for (int i = 0; i < line2.size(); i++) {
    PVector p = line2.get(line2.size()-i-1);
    vertex(x+p.x, y+p.y);
  }

  /*
  for(int i = 0; i < line2.size(); i++){
   PVector p = line2.get(i);
   vertex(x+p.x, y+p.y);
   }
   */
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
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
