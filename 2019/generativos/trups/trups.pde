import org.processing.wiki.triangulate.*;

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

  //mask = loadImage("image.jpg");

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

  background(250);

  for (int i = 0; i < 2000; i++) {
    stroke(getColor(), random(random(255)));
    float d = random(width);
    line(d, 0, d, height); 
    d = random(height);
    line(0, d, width, d);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  float des = random(10000);
  float det = random(10000);
  float bb = 20;
  int cc = int(random(6000, 12000)*0.2);
  for (int i = 0; i < cc; i++) {
    float x = random(bb, width-bb);
    float y = random(bb, height-bb);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      float dis = dist(p.x, p.y, x, y);
      if (dis  < pow(noise(des+x*det, des+y*det), 4)*50) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y));
  }

  for (int i = 0; i < 800; i++) {
    float x = random(bb*2, width-bb*2);
    float y = random(bb*2, height-bb*2);
    if(random(1) < 0.5) x -= x%10;
    if(random(1) < 0.5) y -= y%10;
    points.add(new PVector(x, y));
    points.add(new PVector(x+10, y));
    points.add(new PVector(x+10, y+10));
    points.add(new PVector(x, y+10));
  }
  
  for(int i = 0; i < points.size(); i++){
    PVector p1 = points.get(i);
    for(int j = i+1; j < points.size(); j++){
       PVector p2 = points.get(j);
       if(p1.dist(p2) < 0.5) {
          points.remove(j);
       }
    }
  }  


  ArrayList<Triangle> triangles = Triangulate.triangulate(points);
  float desCol = random(10000);
  float detCol = random(0.003, 0.008);
  stroke(0, 20);
  fill(255, 40);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector c = t.p1.get().add(t.p2).add(t.p3).div(3);
    fill(lerpColor(rcol(), getColor(noise(desCol+c.x*detCol, desCol+c.y*detCol)*20), random(255)*random(1)));
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  noStroke();
  fill(0);
  
  float desLar = random(10000);
  float detLar = random(0.005, 0.01);
  
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    
    float dis = dist(p.x, p.y, width/2, height/2)*0.003;
    float ang = atan2(p.y-height/2,p.x- width/2);
    float lar = 1+noise(desLar+p.x*detLar, desLar+p.y+detLar)*8;
    stroke(rcol());
    line(p.x, p.y, p.x+cos(ang)*dis*lar, p.y+sin(ang)*dis*lar);
    noStroke();
    ellipse(p.x, p.y, 1.2, 1.2);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
int colors[] = {#E49D20, #F7F2DD, #E62024, #86278B, #1A7DB6, #E14998};
//int colors[] = {#fc8e19, #F7F2DD, #f2271d, #4a2768, #1A7DB6, #E14998};
//int colors[] = {#F65DD9, #F74432, #F7B639, #2B5B39, #2D7AF1};
//int colors[] = {#FF5071, #F9C066, #09465D, #544692, #817A9C};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#FE6C6B, #FDD182, #FECDC9, #63D1A3, #6297C6};
//int colors[] = {#026AF7, #429BD6, #444C5D, #EE3B25, #24C230, #FDCC26}; 
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
