import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth = 1920; 
float nheight = 1080;
float swidth = 1920; 
float sheight = 1080;
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

  background(rcol());
  rectMode(CENTER);

  noStroke();

  for (int j = 0; j < height/40+1; j++) {
    for (int i = 0; i < width/40+1; i++) {

      float x = i*40;
      float y = j*40;
      float s = 4*int(random(1, 4));

      if (random(1) < 0.4) s *= 0.5;

      x -= x%40;
      y -= y%40;

      if (random(1) < 0.4) {

        if (random(1) < 0.03) {
          float ss = s;//*0.5;

          int cc = int(random(3, random(6, 12)*random(1)));

          for (int jj = -cc; jj <= cc; jj++) {
            for (int ii = -cc; ii <= cc; ii++) {
              fill(rcol());
              rect(x+ii*ss, y+jj*ss, ss*0.5, ss*0.5);
            }
          }
        }


        fill(rcol());
        rect(x, y, s, s);
      }
    }
  }


  for (int i = 0; i < 400; i++) {

    float x = random(-120, width+120);
    float y = random(-120, height+120);
    float s = random(40)*random(1);

    x -= x%40;
    y -= y%40;

    fill(rcol());
    rect(x, y, s, s);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  for (int i = 0; i < 52; i++) {
    Rect r = new Rect();
    boolean add = true;

    for (int j = 0; j < rects.size(); j++) {
      Rect o = rects.get(j);
      int count = 0;
      if (abs(r.x-o.x) < 0.5 && (r.x-o.y) < 0.5) {
        count++;
        if (count >= 1) {
          add = false;
          break;
        }
      }
    }
    if (add) rects.add(r);
  }


  for (int i = 0; i < rects.size()*2; i++) {
    Rect r1 = rects.get(int(random(rects.size())));
    Rect r2 = rects.get(int(random(rects.size()))); 

    stroke(r1.col);
    stroke(255*int(random(2)));
    strokeWeight(random(random(0.5, 1.5), 2.5));
    rectLine(r1.x, r1.y, r2.x, r2.y);
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.show();

    ArrayList<Interception> inters = new ArrayList<Interception>();
    for (int j = 0; j < rects.size(); j++) {
      Rect r2 = rects.get(j);
      ArrayList<Interception> ps = r.interception(r2);
      if (ps != null) inters.addAll(ps);
    }

    for (int j = 0; j < inters.size(); j++) {
      Interception inter = inters.get(j);

      inter.show();
    }
  }
}

class Interception {
  Rect r1, r2;
  PVector p;
  Interception(PVector p, Rect r1, Rect r2) {
    this.p = p;
    this.r1 = r1;
    this.r2 = r2;
  }

  void show() {

    //println("inter");

    int sel = int(random(4));
    //sel = 3;

    float amp = random(0.5, 1)*2;
    color col = color(0);//r1.col;
    float a1 = 40;
    float a2 = 0;

    //blendMode(DARKEST);
    beginShape();
    if (sel == 0) {
      fill(col, a1);
      vertex(p.x-r2.str*0.5, p.y-r1.str*0.5);
      vertex(p.x-r2.str*0.5, p.y+r1.str*0.5);
      fill(col, a2);
      vertex(p.x-r2.str*amp, p.y+r1.str*0.5);
      vertex(p.x-r2.str*amp, p.y-r1.str*0.5);
    }
    if (sel == 1) {
      fill(col, a1);
      vertex(p.x+r2.str*0.5, p.y-r1.str*0.5);
      vertex(p.x+r2.str*0.5, p.y+r1.str*0.5);
      fill(col, a2);
      vertex(p.x+r2.str*amp, p.y+r1.str*0.5);
      vertex(p.x+r2.str*amp, p.y-r1.str*0.5);
    }
    if (sel == 2) {
      fill(col, a1);
      vertex(p.x-r2.str*0.5, p.y-r1.str*0.5);
      vertex(p.x+r2.str*0.5, p.y-r1.str*0.5);
      fill(col, a2);
      vertex(p.x+r2.str*0.5, p.y-r1.str*amp);
      vertex(p.x-r2.str*0.5, p.y-r1.str*amp);
    }
    if (sel == 3) {
      fill(col, a1);
      vertex(p.x-r2.str*0.5, p.y+r1.str*0.5);
      vertex(p.x+r2.str*0.5, p.y+r1.str*0.5);
      fill(col, a2);
      vertex(p.x+r2.str*0.5, p.y+r1.str*amp);
      vertex(p.x-r2.str*0.5, p.y+r1.str*amp);
    }
    endShape(CLOSE);
    //blendMode(NORMAL);
  }
}  

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors[] = {#4703BC, #D987F2, #EA1E3D, #FFD507, #E5E5E5};
//int colors[] = {#000000, #19D1FF, #8DFF1C, #FF4102, #FF4102};
//int colors[] = {#000000, #19D1FF, #8DFF1C, #FF4102, #FF4102, #4703BC, #D987F2, #EA1E3D, #FFD507, #E5E5E5};
int colors[] = {#F94F00, #F9BD18, #4646EA, #1E1E1E, #EDEDED};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}
