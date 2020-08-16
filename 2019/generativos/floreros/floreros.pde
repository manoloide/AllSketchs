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


  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  background(#0A0D0B);
  rectMode(CENTER);
  noStroke();

  //lights();
  //ambientLight(60, 60, 60);
  hint(DISABLE_DEPTH_MASK);
  
  beginShape();
  fill(rcol(), 40);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 40);
  vertex(width, height);
  vertex(0, height);
  endShape();



  float fov = PI/3.0;//random(1.2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);


  pushMatrix();
  translate(width*0.5, height*0.7);


  //blendMode(ADD);


  rotateX(PI*(random(-0.05, 0.05)));//+random(1, 1.2)));
  rotateY(PI*random(-0.05, 0.05));
  rotateZ(PI*random(-0.05, 0.05));


  pushMatrix();
  translate(0, 0, -2000);
  for (int i = 0; i < 100; i++) {
    float x = width*random(-0.5, 0.5)*4;
    float y = height*random(-0.5, 0.5)*4;

    float ic = random(colors.length);
    float dc = random(0.004);

    float da = random(-0.1, 0.1)*0.2;
    float ma = random(0.999, 1.001);

    float ss = random(8, 20);

    float ang = random(TAU);
    for (int j = 0; j < 100; j++) {

      float s = pow(map(j, 0, 100, 0.1, 1), 2)*ss;

      da *= ma;
      ang += da;

      x += cos(ang);
      y += sin(ang);

      fill(getColor(ic+dc*j));
      ellipse(x, y, s, s);
    }
  }
  popMatrix();

  float detType = random(0.01);
  float desType = random(1000);

  for (int i = 0; i < 900; i++) {
    float x = random(-1, 1)*width*0.8;
    float y = random(-1, 1)*width*0.8;
    float z = random(-1, 1)*width*0.01;

    x -= x%10;
    y -= y%10;
    z -= z%10;

    float type = noise(desType+x*detType, desType+y*detType, desType+z*detType)*4;//int(random(4));
    type = type-pow((type%1), 0.2);
    int col = getColor(type);

    float s = (type+1)*20;

    pushMatrix();
    translate(x, y, z);

    //rotateX(random(1));
    //rotateY(random(-1, 1)*20);

    rotateX(PI*random(0.15, 0.3));

    /*
    noStroke();
     fill(col);
     box(s*0.1);
     
     noFill();
     stroke(col);
     ellipse(0, 0, s, s);
     */

    noStroke();
    fill(col, 180);
    fill(0);
    ellipse(0, 1, s*0.6, s*0.6);
    fill(col);
    ellipse(0, 0, s*0.6, s*0.6);


    int sub = 5;//int(random(18, 30))*20;
    float da = TAU/sub;
    float a = random(TAU);

    stroke(255);

    float ic = random(colors.length);
    float dc = random(0.04)*random(1);

    /*
    for (int j = 0; j < sub; j++) {
     
     float a2 = random(-1, 1)*random(1);
     
     float x1 = cos(a2)*cos(da*j+a)*s;
     float y1 = cos(a2)*sin(da*j+a)*s;
     float z1 = sin(a2)*s;
     
     stroke(col, 170);//getColor(ic+dc*j), 180);
     line(0, 0, 0, x1, y1, z1);
     }
     */
    popMatrix();
  }

  popMatrix();
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
