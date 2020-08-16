import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

import java.util.Collections;

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

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Point implements Comparable {
  float x, y, s;
  Point (float x, float y, float s) {
    this.x = x; 
    this.y = y; 
    this.s = s;
  }
  public int compareTo (Object o) {
    Point n = (Point) o;
    float dif = ((y+s*0.5) - (n.y+n.s*0.5));
    if (dif < 0) return -1;
    else if (dif > 0) return 1;

    return 0;
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  int fogColor = getColor();

  int mountains = 20;

  float detH = random(0.0012, 0.002)*0.8;
  float amp = height*0.9;

  float detCol = random(0.001, 0.004)*0.7;
  float detSiz = random(0.01);
  float detZon = random(0.004, 0.008)*0.7;

  float hpx = random(-0.2, 1.2)*width;
  float hpy = random(-0.5, -0.2)*height;

  blendMode(ADD);

  noStroke();
  for (int i = 8; i < mountains; i++) {
    float av = (i+0)*1./mountains;
    float v = (i+1)*1./mountains;
    av = pow(av, 4);
    v = pow(v, 4);

    float y = v*amp;
    float hh = (v-av)*amp*random(3, 6);

    //noi.set("displace", random(100));
    //shader(noi);
    blendMode(ADD);
    int backCol = lerpColor(rcol(), fogColor, v*0.8);
    beginShape();
    fill(backCol, 8);
    vertex(0, 0);
    vertex(width, 0);
    fill(backCol, 0);
    vertex(width, amp);
    vertex(0, amp);
    endShape();

    resetShader();

    ArrayList<Point> three = new ArrayList<Point>();
    ArrayList<Point> thruu = new ArrayList<Point>();

    int aux[] = {#F7AA06, #88AFD8, #EA527F, #BF052A, #214CA2};
    colors = aux;

    int grassCol = getColor(2+i*0.1);
    //fill(grassCol, 80);//lerpColor(grassCol, color(0), random(0.0, 0.1)));
    //fill(#B8BF1F);//
    float osc = random(0.01)*random(1)*random(1);
    blendMode(NORMAL);
    beginShape(QUAD_STRIP);
    int colba = rcol();
    float mixGrad = random(1);//*random(1);
    for (int j = 0; j <= width; j+=2) {
      grassCol = lerpColor(getColor(2+i*0.2+j*osc), colba, mixGrad);
      fill(grassCol, 250);//3lerpColor(grassCol, color(0), random(0.0, 0.1)), 100);
      float noi = (float)SimplexNoise.noise(j*detH*lerp(2, 0.8, av), y*detH, seed*0.001)*0.5+0.5;
      noi = pow(noi, 1.4);
      float yy = y-hh*noi; 
      if (random(1) < 0.2) {
        vertex(j, yy);
        vertex(j, height);
      }


      for (int l = 0; l < 20; l++) {
        float nx = j;
        float vv = random(random(0.8, 1.4));
        float ny = lerp(yy, y, vv);
        float ns = hh*0.7*lerp(0.3, 1, v)*lerp(0.003, 0.1, noise(nx*detSiz, ny*detSiz)); //*random(0.004, 0.1)
        ns *= lerp(0.5, 1, vv);
        ns *= random(1, 2);

        ns *= pow(constrain(noise(nx*detZon, ny*detZon, i*200*detZon)*16-7, 0, 1), 8);
        if (ns <= 0) {
          boolean add = true;
          for (int k = 0; k < thruu.size(); k++) {
            Point other = thruu.get(k);
            if (dist(nx, ny, other.x, other.y) < (ns+other.s)*0.3) {
              add = false;
              break;
            }
          }
          if (add) {
            thruu.add(new Point(nx, ny, 1-ns));
          }
        }

        boolean add = true;
        for (int k = 0; k < three.size(); k++) {
          Point other = three.get(k);
          if (dist(nx, ny, other.x, other.y) < (ns+other.s)*0.3) {
            add = false;
            break;
          }
        }
        if (add) {
          three.add(new Point(nx, ny, ns));
        }
      }
    }
    endShape();

    int aux2[] = {#F7A102, #3F81D0, #EA215A, #BF0226, #153D9C};//{#2B2C01, #886E0B, #93040F, #0F1B36};//{#1D2469, #B44021, #F6EB00, #01A14E};
    colors = aux2;

    Collections.sort(three);
    noStroke();
    for (int k = 0; k < three.size(); k++) {
      Point t = three.get(k);
      float noi = noise(t.x*detCol*0.6, t.y*detCol);
      float col = i+noi*colors.length*3;
      if (random(1) < 0.1) col = random(colors.length);
      float s = t.s*random(1, 2);
      cir(t.x, t.y, s*random(0.8, 1.2), s, col);
    }
    noStroke();


    int aux3[] = {#380000, #000065, #4C0000, #460000, #00005E};//{#1D2469, #B44021, #F6EB00, #01A14E};
    colors = aux3;

    /*
    Collections.sort(thruu);
     noStroke();
     for (int k = 0; k < thruu.size(); k++) {
     Point t = thruu.get(k);
     float noi = noise(t.x*detCol*0.6, t.y*detCol);
     float col = i+noi*colors.length*3;
     if (random(1) < 0.1) col = random(colors.length);
     float s = t.s*random(1, 2);
     cir(t.x, t.y, s*random(0.8, 1.2), s, col);
     }
     noStroke();
     */


    blendMode(ADD);
    for (int l = 0; l < 2; l++) {
      float dd = width*random(0.4, 2.4);
      beginShape();
      fill(fogColor, random(100, 200)*random(0.4, 0.8)*random(1));
      vertex(hpx, hpy);
      float a1 = random(PI);
      float a2 = a1+PI*random(0.04, 0.1)*random(1, 2);
      fill(#B4CBFD, 0);
      vertex(hpx+cos(a1)*dd, hpy+sin(a1)*dd);
      vertex(hpx+cos(a2)*dd, hpy+sin(a2)*dd);
      endShape();
    }


    PImage back = get();
    float glow = 1.2;
    tint(18*glow, 8*glow, 14*glow);
    image(back, 0, 0);

    blendMode(NORMAL);




    //birds
    birds();

    blendMode(ADD);
    beginShape();
    fill(255, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(rcol(), random(80, 120)*(1-v*0.5)*0.1);
    vertex(width, height);
    vertex(0, height);
    endShape();
    blendMode(NORMAL);
  }
}

void cir(float x, float y, float w, float h, float val) {
  //blendMode(ADD);
  noStroke();
  fill(lerpColor(rcol(), getColor(val), 1-random(0.05, 0.25)), 180);
  //fill(col);
  ellipse(x, y, w-1, h-1);

  int cc = int(PI*w*h*random(0.06, random(0.08, 0.1))*0.8);
  for (int i = 0; i < cc; i++) {
    float dd = sqrt(random(random(0.05, 0.8), 1)*random(0.98, 1))*0.5;
    float va = random(1);
    float ang = lerp(random(TAU), lerp(PI, TAU, va), random(random(0.4), 1));
    strokeWeight(random(1, 1.8));
    //stroke(getColor(val+random(2)*random(1)+va), random(255));
    stroke(255, random(255)*random(1));
    if (random(1) < 0.1+va*0.5) blendMode(ADD);
    else blendMode(NORMAL);
    point(x+cos(ang)*dd*w, y+sin(ang)*dd*h);
  }
  blendMode(NORMAL);


  float mh = h*random(0.6, 0.85);
  float gros = w*random(0.02, 0.04)*random(0.8, 1.2);
  float dx = gros*random(-1, 1)*random(0.8);
  noStroke();
  //fill(#CFDADC);
  fill(rcol());
  float px = x+gros*random(-1.5, 1.5)*random(1);
  float py = y-mh*random(0.3);
  float ax = x+dx;
  float ay = y+mh;
  triangle(px, py, ax+gros*0.2, ay, ax+gros, ay);
  fill(#00497C);
  triangle(px, py, ax-gros, ay, ax+gros*0.2, ay);

  int c = int(random(1, 4));
  float dd = dist(px, py, ax, ay);

  //fill(#CFDADC);
  fill(rcol());
  beginShape(TRIANGLES);
  int ddd = int(random(2));
  for (int i = 0; i < c; i++) {
    float v = random(0.2, 0.3)+i*0.12;
    float ox = lerp(px, ax, v);
    float oy = lerp(py, ay, v);
    float g = gros*v*0.6;
    float a = PI*1.5+random(random(0.2, 0.8), 1)*HALF_PI*(((i+ddd)%2 == 0)? -1 : 1);
    float d = dd*random(0.2, 0.4)*(0.5+(1-v)*0.5)*0.6;

    vertex(ox+cos(a)*d, oy+sin(a)*d);
    vertex(ox+cos(a-HALF_PI)*g, oy+sin(a-HALF_PI)*g);
    vertex(ox+cos(a+HALF_PI)*g, oy+sin(a+HALF_PI)*g);
  }
  endShape();
}

void birds() {


  fill(0);
  float des = random(10000);
  float det = random(0.01);

  fill(0);
  for (int k = 0; k < 100; k++) {
    float x = random(width);
    float vy = random(1);
    float y = height*vy;
    ;
    if (noise(des+x*det, des+y*det) < 0.6) continue;
    float r = random(3, 5)*random(0.5, lerp(1, 3, vy));
    float ang = random(-0.3, 0.3);

    float hdx = cos(ang+0)*r;
    float hdy = sin(ang+0)*r;
    float vdx = cos(ang+HALF_PI)*r;
    float vdy = sin(ang+HALF_PI)*r;
    float dy = random(-0.2, 0.2);
    beginShape();
    vertex(x-hdx, y-hdy);
    vertex(x-hdx*0.5, y-hdy*0.5);
    vertex(x+vdx*(0.15+dy), y+vdy*(0.15+dy));
    vertex(x+hdx*0.5, y+hdy*0.5);
    vertex(x+hdx, y+hdy);
    vertex(x+hdx*0.5+vdx*0.05, y+hdy*0.5+vdy*0.05);
    vertex(x+vdx*(0.3+dy), y+vdy*(0.3+dy));
    vertex(x-hdx*0.5+vdx*0.05, y-hdy*0.5+vdy*0.05);
    //vertex(x, y-10);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#284E34, #BCA978, #896F3D, #38271D, #BF0624};
//int colors[] = {#120F1F, #1F3018, #7B7D30, #B08247, #FAD47D};
//int colors[] = {#2B2400, #684D07, #820318, #0F1B36};
//https://coolors.co/f7aa06-88afd8-ea527f-bf052a-214ca2
int colors[] = {#F7AA06, #88AFD8, #EA527F, #BF052A, #214CA2};

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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
