import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = 773004;//int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = true;

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

  randPallets();

  background(rcol());

  //blendMode(ADD);

  noStroke();

  rectMode(CENTER);
  float grid = 10;
  for (int i = 0; i < 600; i++) {
    float x = random(width+grid);
    float y = random(height+grid);
    float s = pow(2, int(random(1, random(2, 4))));

    x -= x%grid;
    y -= y%grid;

    fill(rcol());
    rect(x, y, s, s);
  }

  grid = 40;
  for (int i = 0; i < 100; i++) {
    float x = random(width+grid);
    float y = random(height+grid);
    float s = grid*random(1)*random(1)*random(1)*0.6;

    x -= x%grid;
    y -= y%grid;

    fill(rcol());
    ellipse(x, y, s, s);

    if (random(1) < 0.1) {
      fill(rcol(), 50);
      ellipse(x, y, s*4, s*4);
    }
  }


  for (int i = 0; i < 100; i++) {
    float x = random(width+grid);
    float y = random(height+grid);
    float s = grid*random(0.8, 1)*0.9;

    x -= x%grid;
    y -= y%grid;

    x += grid*0.5; 
    y += grid*0.5; 

    fill(rcol());
    rect(x, y, s, s);
  }

  for (int i = 0; i < 100; i++) {

    float x1 = random(width+grid);
    float y1 = random(height+grid);
    float x2 = random(width+grid);
    float y2 = random(height+grid);

    x1 -= x1%grid;
    y1 -= y1%grid;
    x2 -= x2%grid;
    y2 -= y2%grid;

    if (random(1) < 0.5) x1 = x2;
    else y1 = y2;

    stroke(rcol());
    line(x1, y1, x2, y2);
  }

  for (int i = 0; i < 100; i++) {

    float x1 = random(width+grid);
    float y1 = random(height+grid);
    float x2 = random(width+grid);
    float y2 = random(height+grid);

    x1 -= x1%grid;
    y1 -= y1%grid;
    x2 -= x2%grid;
    y2 -= y2%grid;

    if (random(1) < 0.5) x1 = x2;
    else y1 = y2;

    stroke(rcol());
    line(x1, y1, x2, y2);
  }

  blendMode(NORMAL);


  {
    //stroke(rcol());
    noStroke();
    fill(rcol());
    //noFill();
    float det = random(0.001);
    float des = random(1000);
    fill(0);
    for (int i = 0; i < 1000; i++) {
      float x = random(width);
      float y = random(height);
      beginShape();
      for (int k = 0; k < 120; k++) {
        float a = (float)SimplexNoise.noise(des+x*det, des+y*det)*TAU*2;
        x += cos(a);
        y += sin(a);
        vertex(x, y);
      }
      endShape();
    }
  }


  for (int i = 0; i < 200; i++) {

    float x1 = random(width+grid);
    float y1 = random(height+grid);
    float x2 = x1+random(-150, 150);
    float y2 = y1+random(-150, 150);

    x1 -= x1%grid;
    y1 -= y1%grid;
    x2 -= x2%grid;
    y2 -= y2%grid;

    ArrayList<PVector> points = new ArrayList<PVector>();

    int lar = int(dist(x1, y1, x2, y2));

    float ix = 0;
    float iy = 0;
    float det = random(0.1);
    float des = random(1000);
    points.add(new PVector(ix, iy));
    for (int k = 0; k < lar; k++) {
      float ang = (noise(des+ix*det, des+iy*det)*2-1)*PI*3.8;
      ix += cos(ang);
      iy += sin(ang);
      points.add(new PVector(ix, iy));
    }

    PVector p1 = points.get(0);
    PVector p2 = points.get(points.size()-1);
    float ang = atan2(p2.y-p1.y, p2.x-p1.x);
    float dis = p1.dist(p2);


    for (int k = 0; k < points.size(); k++) {
      PVector p = points.get(k);
      p.rotate(-ang);
      p.mult((lar*1./dis));
    }

    noStroke();
    fill(rcol());
    beginShape();
    for (int k = 0; k < points.size(); k++) {
      PVector p = points.get(k);
      vertex(x1+p.x, y1+p.y);
    }
    endShape();


    if (random(1) < 0.5) x1 = x2; 
    else y1 = y2; 

    stroke(0);//rcol()); 
    line(x1, y1, x2, y2);
  }

  float gg = grid/4;
  float detPass = random(0.01);
  for (float j = 0; j < width; j+=gg) {
    for (int i = 0; i < height; i+=gg) {
      if (random(1) < 0.001 || noise(i*detPass, j*detPass) > 0.55) continue;
      if (random(1) < 0.1) fill(255);
      else fill(0);
      rect(i, j, gg*0.08, gg*0.08);
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 40; i++) {
    float x = random(width+grid);
    float y = random(height+grid);
    float s = grid*2;

    x -= x%grid;
    y -= y%grid;

    x += grid*0.5; 
    y += grid*0.5; 

    points.add(new PVector(x, y));

    noStroke();
    fill(rcol(), 30);
    ellipse(x, y, s, s);
    ellipse(x, y, s*0.95, s*0.95);
    noStroke();
    fill(255);
    ellipse(x, y, s*0.1, s*0.1);
  }

  for (int j = 0; j < points.size(); j++) {
    PVector p1 = points.get(j); 
    for (int i = j+1; i < points.size(); i++) {
      PVector p2 = points.get(i);
      stroke(rcol());
      if (p1.dist(p2) < 100) {
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }



  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width+grid);
    float y = random(height+grid);
    float s = grid*0.1;

    x -= x%grid;
    y -= y%grid;

    x += grid*0.5; 
    y += grid*0.5; 

    fill(rcol());
    rect(x, y, s, s);
  }
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void randPallets() {
  int aux[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a}; 
  colors = aux; 

  int aux2[] = new int[int(random(3, 6))]; 
  for (int i = 0; i < aux2.length; i++) {
    aux2[i] = rcol();
  }
  colors = aux2;
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#0E1619, #024AEE, #FE86F0, #FD4335, #F4F4F4};
//int colors[] = {#F7DF04, #EAE5E5, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
int colors[] = {#F23602, #300F96, #C9FFF6, #F72C81, #09EFA6, #fac62a}; 
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
