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

  randomSeed(seed);
  noiseSeed(seed);

  background(0, 2, 4);


  float hor = random(0.15, 0.3);

  //blendMode(NORMAL);ç
  noStroke();
  for (int i = 0; i < 3; i++) {
    fill(rcol()); 
    float det = random(0.01);
    float y = height*hor;
    beginShape();
    for (int j = 0; j < width; j++) {
      float noi = pow(constrain(noise(j*det)*4-2, 0, 1), 1.4);
      float h = width*(-noi*0.012);
      vertex(j, h+y);
    }
    vertex(width, y);
    vertex(0, y);
    endShape();
  }


  int sub = 1000;


  float pwr = 4.2;//random(1, 3);
  {
    float ic1 = random(colors.length);
    float dc1 = random(0.1)*random(0.4, 1)*hor;  
    float ic2 = random(colors.length);
    float dc2 = random(0.1)*random(0.4, 1)*hor;
    noStroke();
    //stroke(#152425, 20);
    for (int i = 0; i < sub; i++) {
      float v1 = pow(map(i, 0, sub, 0, 1), pwr)*(1-hor)+hor;
      float v2 = pow(map(i+1, 0, sub, 0, 1), pwr)*(1-hor)+hor;
      float y1 = v1*height;
      float y2 = v2*height;

      beginShape();
      fill(getColor(ic1+dc1*(i+1)), 180);
      vertex(0, y2);
      fill(getColor(ic1+dc1*(i)), 180);
      vertex(0, y1);
      fill(getColor(ic2+dc2*(i)), 180);
      vertex(width, y1);
      fill(getColor(ic2+dc2*(i+1)), 180);
      vertex(width, y2);
      endShape(CLOSE);
    }
  }

  {
    float ic1 = random(colors.length);
    float dc1 = random(0.1)*random(0.4, 1)*hor*0.1;  
    float ic2 = random(colors.length);
    float dc2 = random(0.1)*random(0.4, 1)*hor*0.1;

    noStroke();
    //stroke(#152425, 20);
    for (int i = 0; i < sub; i++) {
      float v1 = (1-pow(map(i, 0, sub, 0, 1), pwr))*hor;
      float v2 = (1-pow(map(i+1, 0, sub, 0, 1), pwr))*hor;
      float y1 = v1*height;
      float y2 = v2*height;

      beginShape();
      fill(getColor(ic1+dc1*(i+1)), 180);
      vertex(0, y2);
      fill(getColor(ic1+dc1*(i)), 180);
      vertex(0, y1);
      fill(getColor(ic2+dc2*(i)), 180);
      vertex(width, y1);
      fill(getColor(ic2+dc2*(i+1)), 180);
      vertex(width, y2);
      endShape(CLOSE);
    }
  }

  /*
  noStroke();
   beginShape(QUAD);
   fill(0, 150);
   vertex(0, 0);
   vertex(width, 0);
   fill(0, 0);
   vertex(width, height*(1-hor));
   vertex(0, height*(1-hor));
   
   fill(0, 130);
   vertex(0, 0);
   vertex(width, 0);
   fill(0, 0);
   vertex(width, height*0.3);
   vertex(0, height*0.3);
   endShape();
   */

  {
    ArrayList<PVector> points = new ArrayList<PVector>();
    ArrayList<PVector> points2 = new ArrayList<PVector>();

    for (int i = 0; i < 50; i++) {
      float val = random(0, random(0.98));
      float xx = width*random(1);
      float yy = height*(hor+val*(1-hor));
      float ss = (0.06+pow(val, 1.4))*120;

      boolean add = true;
      for (int j = 0; j < points.size(); j++) {
        PVector other = points.get(j);
        if (dist(xx, yy, other.x, other.y) < (ss+other.z)*0.6) {
          add = false;
          break;
        }
      }
      if (add) {
        points.add(new PVector(xx, yy, ss));
        points2.add(new PVector(xx, yy, ss));
      }
    }


    ArrayList<Triangle> tris = Triangulate.triangulate(points2);

    stroke(255, 10);
    noFill();
    beginShape(TRIANGLES);
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      vertex(t.p1.x, t.p1.y);
      vertex(t.p2.x, t.p2.y);
      vertex(t.p3.x, t.p3.y);
    }
    endShape(CLOSE);

    stroke(255, 10);
    noStroke();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float xx = p.x; 
      float yy = p.y;
      float ss = p.z;
      arc2(xx, yy+ss*0.5, 0, 0, ss*1.4, ss*1.4*0.2, 0, TAU, color(0), 60, 0);
      arc2(xx, yy+ss*0.5, 0, 0, ss*0.8, ss*0.8*0.2, 0, TAU, color(0), 90, 0);
      fill(rcol());
      ellipse(xx, yy, ss, ss);
      arc2(xx, yy, ss, ss*8, 0, TAU, rcol(), 30, 0);
      arc2(xx, yy, ss, ss*2, 0, TAU, color(255), 8, 0);
      arc2(xx, yy, ss, ss*0.6, 0, TAU, rcol(), 14, 0);
    }

    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      PVector center = t.p1.copy().add(t.p2).add(t.p3);
      center.div(3);
      float ss = random(3);
      float r = ss*0.5;
      noStroke();

      float ang = random(0, PI);
      float amp = random(200);
      beginShape();
      fill(rcol());
      vertex(center.x+cos(ang-HALF_PI)*r, center.y+sin(ang-HALF_PI)*r);
      vertex(center.x+cos(ang+HALF_PI)*r, center.y+sin(ang+HALF_PI)*r);
      vertex(center.x+cos(ang)*r*amp, center.y+sin(ang)*r*amp);
      //vertex(center.x+cos(ang+HALF_PI)*r, center.y+sin(ang+HALF_PI)*r);
      fill(255, 240);
      ellipse(center.x, center.y, ss, ss);
      endShape(CLOSE);
    }
  }
}
void arc2(float x, float y, float w1, float h1, float w2, float h2, float a1, float a2, int col, float alp1, float alp2) {
  int cc = (int) max(2, PI*pow(max(max(w1, w2), max(h1, h2))*0.25, 2));
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*w1*0.5, y+sin(ang1)*h1*0.5);
    vertex(x+cos(ang1)*w1*0.5, y+sin(ang2)*h1*0.5);
    fill(col, alp2);
    vertex(x+cos(ang2)*w2*0.5, y+sin(ang2)*h2*0.5);
    vertex(x+cos(ang1)*w2*0.5, y+sin(ang1)*h2*0.5);
    endShape();
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*2*pow(max(r1, r2)*0.06, 2));
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    endShape();
  }
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

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
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
  return lerpColor(c1, c2, pow(v%1, 10.8));
}
