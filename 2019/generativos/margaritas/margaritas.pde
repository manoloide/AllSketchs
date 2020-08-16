import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
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

  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

class Rect {
  float x, y, w, h; 
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  hint(DISABLE_DEPTH_MASK);

  beginShape();
  fill(#1279F6);
  vertex(0, 0);
  vertex(width, 0);
  fill(#8BD5F4);
  vertex(width, height);
  vertex(0, height);
  endShape();

  hint(ENABLE_DEPTH_MASK);


  float fov = PI/3.0;//random(1.2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);


  pushMatrix();
  translate(width*0.5, height*0.7);


  ArrayList<PVector> pelatos = new ArrayList<PVector>();

  //blendMode(ADD);


  rotateX(PI*(random(-0.05, 0.05)));//+random(1, 1.2)));
  rotateY(PI*random(-0.05, 0.05));
  rotateZ(PI*random(-0.05, 0.05));
  scale(random(1, 3));


  ArrayList<PVector> flowers = new ArrayList<PVector>();

  for (int i = 0; i < 400; i++) {
    float x = random(-1, 1)*width*0.8;
    float y = random(-1, 1)*width*0.8;
    float z = random(-1, 1)*width*0.01;

    x -= x%10;
    y -= y%10;
    z -= z%10;

    boolean add = true;
    for (int j = 0; j < flowers.size(); j++) {
      PVector f = flowers.get(j);
      if (dist(x, y, z, f.x, f.y, f.z) < 40) {
        add = false; 
        break;
      }
    }

    if (add) flowers.add(new PVector(x, y, z));
  }

  for (int i = 0; i < flowers.size(); i++) {
    PVector f = flowers.get(i);
    float x = f.x;
    float y = f.y;
    float z = f.z;
    float s = random(14, 28);


    pushMatrix();
    translate(x, y, z);
    stroke(10, 140, 20);
    //line(0, 0, 0, 0, 0, -800);
    rotateX(PI*random(0.15, 0.3));
    noStroke();
    noFill();
    float r = s*0.5;
    //strokeWeight(5);
    for (int j = 0; j < s*20; j++) {
      float a1 = random(PI*1.5, PI*2.5);
      float a2 = random(PI);
      fill(lerpColor(color(255, 150, 0), #F5C019, cos(a1)*random(0.8)));
      //ellipse(0, 0, s, s);
      pushMatrix();
      translate(sin(a1)*cos(a2)*r, sin(a1)*sin(a2)*r, cos(a1)*r*0.2);
      ellipse(0, 0, 5, 5);
      popMatrix();
    } 
    strokeWeight(1);   

    noStroke();
    int sub = 20;//int(random(18, 30))*20;
    if (random(1) < 0.5) sub *= int(random(random(2), 4)*2);
    float da = TAU/sub;
    float a = random(TAU);


    float dry = random(-1, 1)*random(0.5, 1);
    for (int j = 0; j < sub; j++) {

      float a2 = random(-1, 1)*random(1);

      fill(random(235, 250));
      pushMatrix();
      rotate(a+da*j);
      translate(s*0.5, 0);
      rotateX(random(-0.02, 0.02));
      rotateY(dry+random(-0.1, 0.1));
      rotateZ(random(-0.02, 0.02));
      translate(s*0.5, 0);
      float xx = modelX(0, 0, 0);
      float yy = modelY(0, 0, 0);
      float zz = modelZ(0, 0, 0);
      pelatos.add(new PVector(xx, yy, zz));
      //translate(cos(da*j+a)*s*1.0, sin(da*j+a)*s*1.0);
      ellipse(0, 0, s, s*0.4);
      popMatrix();

      /*
      float x1 = cos(a2)*cos(da*j+a)*s*0.5;
       float y1 = cos(a2)*sin(da*j+a)*s*0.5;
       float z1 = sin(a2)*s*0.5;
       
       float x2 = cos(a2)*cos(da*j+a)*s*1.5;
       float y2 = cos(a2)*sin(da*j+a)*s*1.5;
       float z2 = sin(a2)*s*1.5;
       
       stroke(255, 170);//getColor(ic+dc*j), 180);
       line(x1, y1, z1, x2, y2, z2);
       */
    }
    popMatrix();
  }
  noFill();
  stroke(255, 60);
  ArrayList<Triangle> tris = Triangulate.triangulate(flowers);
  beginShape();
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    if (random(1) < 0.8) {
      vertex(t.p1.x, t.p1.y, t.p1.z);
    }
  }
  endShape();

  popMatrix();


  /*
  noFill();
   stroke(255, 60);
   ArrayList<Triangle> tris = Triangulate.triangulate(pelatos);
   beginShape();
   for (int i = 0; i < tris.size(); i++) {
   Triangle t = tris.get(i);
   if (random(1) < 0.1) {
   vertex(t.p1.x, t.p1.y, t.p1.z);
   }
   }
   endShape();
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #ED493D, #77C9EC, #C5C4C4};
//int colors[] = {#2B81A2, #040109, #82BA94, #82BA94, #2B81A2};
int colors[] = {#EB4313, #E9CA54, #684C61, #749AB2};
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
