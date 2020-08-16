import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

PShader noi;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Quad {
  PVector p1, p2, p3, p4;
  Quad(PVector p1, PVector p2, PVector p3, PVector p4) {
    this.p1 = p1; 
    this.p2 = p2; 
    this.p3 = p3; 
    this.p4 = p4;
  }

  void show() {
    int col = rcol();
    float alp1 = random(250);
    float alp2 = random(250);
    float alp3 = random(250);
    float alp4 = random(250);
    if(random(1) < 0.5){
       alp1 = alp2;
       alp3 = alp4;
    }else{
       alp1 = alp4;
       alp3 = alp2;
    }
    beginShape();
    fill(col, alp1);
    vertex(p1.x, p1.y);
    fill(col, alp2);
    vertex(p2.x, p2.y);
    fill(col, alp3);
    vertex(p3.x, p3.y);
    fill(col, alp4);
    vertex(p4.x, p4.y);
    endShape(CLOSE);
  }
}

PVector[][] vertices;
ArrayList<Quad> quads;

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  blendMode(ADD);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");
  noi.set("displace", random(100));

  int cc = int(random(8, 15));
  vertices = new PVector[cc][cc];
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;
      vertices[i][j] = new PVector(xx, yy);
    }
  }

  quads = new ArrayList<Quad>();
  for (int j = 0; j < cc-1; j++) {
    for (int i = 0; i < cc-1; i++) {
      PVector p1 = vertices[i][j];
      PVector p2 = vertices[i+1][j];
      PVector p3 = vertices[i+1][j+1];
      PVector p4 = vertices[i][j+1];
      quads.add(new Quad(p1, p2, p3, p4));
    }
  }

  for (int i = 0; i < cc*cc*0.3; i++) {
    Quad q = quads.get(int(random(quads.size())));
    float des = ss*0.25;
    if (random(1) < 0.5) {
      if (random(1) < 0.5) {
        q.p1.y -= des;
        q.p4.y += des;
      } else {
        q.p2.y -= des;
        q.p3.y += des;
      }
    } else {
      if (random(1) < 0.5) {
        q.p1.x -= des;
        q.p2.x += des;
      } else {
        q.p4.x -= des;
        q.p3.x += des;
      }
    }
  }

  stroke(0);
  strokeWeight(2);
  for (int i = 0; i < quads.size(); i++) {
    fill(rcol(), random(255));
    noi.set("displace", random(100));
    shader(noi);
    quads.get(i).show();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
int colors[] = {#4E87C5, #BA8FE7, #F76A0B};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
