import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  800;
float nheight = 800;
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
  //generate();
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
  background(255);

  stroke(0);
  noFill();

  scale(scale);

  int div = 32;
  float ss = swidth*(1./div);
  /*
  stroke(0, 30);
   for (int j = 0; j < div; j++) {
   for (int i = 0; i < div; i++) {
   rect(i*ss, j*ss, ss, ss);
   }
   }
   */

  noStroke();
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      float amp = (((i+j)*.5)/div);
      float amp2 = 1-amp*0.4;
      fill(((i+j)%2)*255);
      //rect((i+amp*0.2)*ss, (j+amp*0.2)*ss, ss*amp2, ss*amp2, ss*amp);
      //rect(i*ss, j*ss, ss, ss);
      float xx = i*ss;
      float yy = j*ss;
      beginShape();
      dvertex(xx, yy);
      dvertex(xx+ss*0.5, yy);
      dvertex(xx+ss, yy);
      dvertex(xx+ss, yy+ss*0.5);
      dvertex(xx+ss, yy+ss);
      dvertex(xx+ss*0.5, yy+ss);
      dvertex(xx, yy+ss);
      dvertex(xx, yy+ss*0.5);
      endShape();
    }
  }

  noStroke();
  noFill();
  div = 8;
  ss = swidth*(1./div);

  rrect(swidth*0.25, sheight*0.5, ss*2, ss*6, 8, 24);
  rrect(swidth*0.75, sheight*0.5, ss*2, ss*6, 8, 24);

  //zebra();
}

void zebra() {
  float ia = PI*0.75;
  float ir = swidth*(0.25+0.125*0.5);
  float ea = -PI*1.5;
  float er = 0;
  float cx = swidth*0.5;
  float cy = sheight*0.5;

  int res = 180;
  noFill();
  //beginShape();
  strokeWeight(5);
  for (int i = 0; i < res; i++) {
    float v = i*1./res;
    float a = lerp(ia, ea, v);
    float r = lerp(ir, er, pow(v, 5));
    float xx = cx+cos(a)*r;
    float yy = cy+sin(a)*r;
    stroke((i%2)*255);
    float a1 = a-PI*0.25;
    float a2 = a+PI*0.25;
    line(xx, yy, xx+cos(a1)*40, yy+sin(a1)*40);
    line(xx, yy, xx+cos(a2)*40, yy+sin(a2)*40);
  }
  //endShape();


  /*
  noStroke();
   res = 120;
   for (int i = 0; i < res; i++) {
   float v = i*1./res;
   float a = lerp(ia, ea, lerp(v, pow(v, 0.7), 0.2));
   float r = lerp(ir, er, pow(v, 5));
   float xx = cx+cos(a)*r;
   float yy = cy+sin(a)*r;
   fill((i%2)*255);
   float s = 30*pow((1-v), 0.4)*2;
   ellipse(xx, yy, s, s);
   }
   */
}

void rrect(float x, float y, float w, float h, int cw, int ch) {

  float sw = w/cw;
  float sh = h/ch;

  /*
  fill(#DC8342);
   for (int j = 0; j <= ch; j++) {
   for (int i = 0; i < cw; i++) {
   float xx = x-w*0.5+sw*i;
   float yy = y-h*0.5+sh*j;
   beginShape();
   dvertex(xx, yy);
   dvertex(xx+sw*0.5, yy);
   dvertex(xx+sw, yy);
   dvertex(xx+sw, yy+sh*0.5);
   dvertex(xx+sw, yy+sh);
   dvertex(xx+sw*0.5, yy+sh);
   dvertex(xx, yy+sh);
   dvertex(xx, yy+sh*0.5);
   endShape();
   }
   }
   */

  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float xx = x-w*0.5+sw*i;
      float yy = y-h*0.5+sh*j;
      //rect(xx, yy, sw, sh);
      float sw1 = ((i+j)%2 < 1)? sw*1.5 : sw*0.5;
      sw1 *= 0.5;
      float sh1 = ((i+j)%2 < 1)? sh*0.5 : sh*1.5;
      sh1 *= 0.5;

      noStroke();
      fill(getColor((j%2 == 0)? ((i%2== 0)? 0 : 1) : ((i%2== 0)? 1 : 2)));
      beginShape();

      dvertex(xx-sw1, yy);
      dvertex(xx, yy-sh1);
      dvertex(xx+sw1, yy);
      dvertex(xx, yy+sh1);
      /*
      vertex(xx-sw1, yy);
       vertex(xx, yy-sh1);
       vertex(xx+sw1, yy);
       vertex(xx, yy+sh1);
       */
      endShape();
    }
  }

  /*
  stroke(255, 0, 0);  
   
   line(swidth*0.5, 0, swidth*0.5, sheight);
   line(0, sheight*0.5, swidth, sheight*0.5);
   
   line(0, 0, swidth, sheight);
   line(0, sheight, swidth, 0);
   noFill();
   ellipse(swidth*0.5, sheight*0.5, swidth*(3./4), sheight*(3./4));
   */
}

void dvertex(float x, float y) {
  PVector d = def(x, y);
  vertex(d.x, d.y);
}

PVector def(float x, float y) {
  float cx = swidth*0.5;
  float cy = sheight*0.5;
  float dis = dist(cx, cy, x, y);

  float maxDist = swidth*0.4;

  if (dis < maxDist) {
    float ang = atan2(y-cy, x-cx);

    dis = pow(dis/maxDist, 0.65)*maxDist;

    x = cx+cos(ang)*dis;
    y = cy+sin(ang)*dis;
  }
  return new PVector(x, y);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #82023B};
int colors[] = {#E6D8B6, #D52106, #287D87, #000200};
//int colors[] = {#FFFFFF, #000000};//, #02B59E, #DCE404, #82023B};
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
