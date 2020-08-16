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
  scale(scale);


  //background(rcol());

  beginShape();
  fill(getColor());
  vertex(0, 0);
  vertex(width, 0);
  fill(getColor());
  vertex(width, height);
  vertex(0, height);
  endShape();


  int sw = int(random(2, 6)*2);
  float ww = width*1./sw;
  int sh = int(random(2, 6)*2);
  float hh = height*1./sh;

  int s1 = int(random(4, 50)*random(0.8, 1));
  int s2 = int(random(4, 50)*random(0.8, 1));

  float aw = random(0.9);
  float ah = random(0.9);


  int res = 10;//80;
  noiseDetail(2);
  ArrayList<PVector> l1 = createLine(0, 0, ww, 0, res);
  ArrayList<PVector> l2 = createLine(0, 0, ww, 0, res);


  float detCol = random(0.0002, 0.001);
  float desCol = random(10000); 

  strokeWeight(0.2);

  for (int j = -3; j < sh+2; j++) {
    for (int i = -3; i < sw+2; i++) {

      //if ((i+j)%2 < 1) continue;

      float x = (i+0.5)*ww;
      float y = (j+0.5)*hh;

      noStroke();

      stroke(0, 20);


      float s = 1; //constrain(noise(des+x*det, des+y*det)*3-0.5, 0.5, 1);
      int ind = abs((i+j+j/2)%5);//+j%2;
      int c1 = lerpColor(getColor(ind), color(0), ((i+j)%2)*0.08);
      int c2 = lerpColor(getColor(ind+2), color(0), ((i+j)%2)*0.08);

      int sub = abs(i+j)%4;
      fill(getColor(noise(desCol+x*detCol, desCol+y*detCol)*20));

      if ((i+j)%2 == 0) fill((((i+j)%4)/2)*250, 220);


      drawForm(x, y, ww*s, hh*s, l1, l2, ((abs(i)%2) >= 1), ((abs(j)%2) >= 1), s1*sub, s2*sub, aw, ah, c1, c2);
    }
  }
}

void vline(float x1, float y1, float x2, float y2, ArrayList<PVector> line, boolean inv, boolean rev) {
  float lineDis = line.get(0).dist(line.get(line.size()-1));
  float dis = dist(x1, y1, x2, y2);
  float mul = dis/lineDis;
  float ang = atan2(y2-y1, x2-x1);
  for (int i = 0; i < line.size(); i++) {
    int ind = i;
    if (rev) ind = line.size()-1-i;
    PVector p = line.get(ind).copy();
    if (inv) p.y *= -1;
    p.rotate(ang);
    p.mult(mul);

    vertex(x1+p.x, y1+p.y);
  }
}

void drawForm(float x, float y, float w, float h, ArrayList<PVector> l1, ArrayList<PVector> l2, boolean i1, boolean i2, int s1, int s2, float aw, float ah, int c1, int c2) {
  x -= w*0.5;
  y -= h*0.5;

  float dx = w*aw;
  float dy = h*ah;//h*0.5;

  if (i1) {
    float dw = 1;
    if (i2) dw = -1;
    float dh = 1;
    //grid(x-dx*dw, y-dy*dh, x+dx*dw, y+h-dy*dh, x+w+dx*dw, y+h+dy*dh, x+w-dx*dw, y+dy*dh, s1, s2, c1, c2);
  } else {
    float dir = +1;
    if (i2) dir = -1;
    float dh = 1;
    //grid(x-dx*dir, y+dy*dh, x+w-dx*dir, y-dy*dh, x+w+dx*dir, y+h-dy*dh, x+dx*dir, y+h+dy*dh, s2, s1, c1, c2);
  }


  beginShape();




  if (i1) {
    float dw = 1;
    if (i2) dw = -1;
    float dh = 1;
    
    PVector p1 = new PVector(x-dx*dw, y-dy*dh);
    PVector p2 = new PVector(x+w-dx*dw, y-dy*dh);
    PVector p3 = new PVector(x+w-dx*dw, y+h-dy*dh);
    PVector p4 = new PVector(x-dx*dw, y+h-dy*dh);
    
    drawPoint(p1, "1");
    drawPoint(p2, "2"); 
    drawPoint(p3, "3");
    drawPoint(p4, "4");
    //vline(x-dx*dw, y-dy*dh, x+w-dx*dw, y-dy*dh, l1, true, false);
    //vline(x-dx, y, x, y+h, l2, true, false);
    //fill(getColor());
    //vline(x+w-dx*dw, y+h+dy*dh, x-dx*dw, y+h+dy*dh, l1, false, false);
    //vline(x+w-dx, y, x+w, y+h, l2, true, true);
  } else {

    dx *= -1;
    //vline(x+w+dx, y, x+dx, y, l1, true, false);
    //vline(x-dx, y, x, y+h, l2, true, false);
    //vline(x-dx, y+h, x+w-dx, y+h, l1, false, false);
    //vline(x+w-dx, y, x+w, y+h, l2, true, true);
  }
  endShape();
}

void drawPoint(PVector p, String t) {
  fill(220);
  ellipse(p.x, p.y, 4, 4);
  fill(0);
  text(t, p.x+5, p.y+5);
}

void grid(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int subW, int subH, int c1, int c2) {

  println(subW, subH);

  PVector ps[][] = new PVector[subW+1][subH+1];
  for (int j = 0; j <= subH; j++) {
    float v1 = pow(j*1./subH, 1);
    float nx1 = lerp(x1, x2, v1); 
    float ny1 = lerp(y1, y2, v1); 
    float nx2 = lerp(x4, x3, v1); 
    float ny2 = lerp(y4, y3, v1); 
    for (int i = 0; i <= subW; i++) {
      float v2 = pow(i*1./subW, 1);
      float xx = lerp(nx1, nx2, v2); 
      float yy = lerp(ny1, ny2, v2);
      ps[i][j] = new PVector(xx, yy);
    }
  }
  //noStroke(); 
  for (int j = 0; j < subH; j++) {
    for (int i = 0; i < subW; i++) {
      fill(((i+j)%2 == 0)? c1 : c2);
      beginShape();
      vertex(ps[i][j].x, ps[i][j].y); 
      vertex(ps[i+1][j].x, ps[i+1][j].y); 
      vertex(ps[i+1][j+1].x, ps[i+1][j+1].y); 
      vertex(ps[i][j+1].x, ps[i][j+1].y); 
      endShape(CLOSE);
    }
  }

  //quad(x1, y1, x2, y2, x3, y3, x4, y4);
}

ArrayList<PVector> createLine(float x1, float y1, float x2, float y2, int res) {
  ArrayList<PVector> line = new ArrayList<PVector>();

  float xx = 0;
  float yy = 0;

  float desAng = random(1000);
  float detAng = random(0.04);

  float amp = random(0.8, 1)*6.6;

  for (int i = 0; i < res; i++) {
    line.add(new PVector(xx, yy)); 
    float a = abs(i/res-0.5)*2;
    float ang = noise(desAng+xx*detAng, desAng+yy*detAng)*TAU*amp*a;
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


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#E40833, #FA1457, #00137C, #008050, #E3CC24, #F376B3};
//int colors[] = {#B0E7FF, #143585, #5ACAA2, #F98FC0, #D08714};
//int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
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
