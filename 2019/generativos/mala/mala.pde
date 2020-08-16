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

  noStroke();

  float bb = 10;
  beginShape();
  fill(rcol());
  vertex(bb, bb);
  vertex(width-bb, bb);
  fill(rcol());
  vertex(width-bb, height-bb);
  vertex(bb, height-bb);
  endShape();
  
  for(int i = 0; i < 1000; i++){
     float xx = lerp(bb, width-bb, random(1));
     float yy = lerp(bb, height*0.5, random(1)*random(0.4, 1));
     stroke(255);
     strokeWeight(random(2));
     point(xx, yy);
  }
  
  noStroke();

  beginShape();
  fill(rcol());
  vertex(bb, height*0.3);
  vertex(width-bb, height*0.3);
  fill(rcol());
  vertex(width-bb, height-bb);
  vertex(bb, height-bb);
  endShape();

  float det = random(0.001);

  int div = 120; 
  int col = rcol();
  for (int i = 0; i < div; i++) {
    float v1 = pow(i*1./div, 9);
    float v2 = pow((i+1)*1./div, 9);
    float y1 = lerp(height*0.3, height-bb, v1);
    float y2 = lerp(height*0.3, height-bb, v2);
    int sub = int(random(50, 600*random(0.5, 1)));
    float amp = random(0.8, 1.05)-0.2;//+0.12;
    for (int j = 0; j < sub; j++) {
      if (random(1) < amp) continue;
      float vx1 = j*1./sub;
      float vx2 = (j+1)*1./sub;
      float x1 = lerp(bb, width-bb, vx1);
      float x2 = lerp(bb, width-bb, vx2);

      beginShape();
      if (random(1) < 0.2) col = rcol();
      fill(col);
      vertex(x1, y1);
      vertex(x2, y1);
      vertex(x2, y2);
      vertex(x1, y2);
      endShape();

      if (random(1) < 0.2) {
        float xx = (x1+x2)*0.5;
        float amph = sin(map(abs(width*0.5-xx), 0, width*0.5, HALF_PI, 0)); 
        float hh = (x2-x1)*6*amph*random(1, 1.3);
        fill(rcol());
        arc(xx, y1, hh, hh*random(2.4, 3), PI, TAU);
        fill(rcol());
        //arc(xx, y1, hh*0.1, hh*0.3, PI, TAU);
      }
    }
  }

  noStroke();
  for (int i = 0; i < 8; i++) {
    float x = random(bb*2, width-bb*2);
    float y = random(height*0.4, height*0.7);
    float v = map(y, 0, height, 0.2, 1);
    float s = random(10, 60)*random(1, 2)*random(0.1, 1)*v*2.0;

    float ang1 = PI*random(0.4, 0.6);
    float dis1 = random(1, 3)*2;

    float ang2 = ang1+PI*random(-0.05, 0.05)+HALF_PI;
    float dis2 = random(0.6, 0.8);
    float amp = (dis1-dis2)*random(1.5, 4)*random(0.1, random(0.15, 0.2));

    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);
    if (random(1) < 0.5) {
      fill(rcol());
      arc(x, y, s, s, ang1-PI, ang1);
    }

    float cx = x+cos(ang1)*dis2*s;
    float cy = y+sin(ang1)*dis2*s;
    //line(x+cos(ang1)*dis1*s, y+sin(ang1)*dis1*s, cx, cy);
    float dx = cos(ang2)*s*amp;
    float dy = sin(ang2)*s*amp;
    //line(cx-dx, cy-dy, cx+dx, cy+dy);
    beginShape();
    fill(rcol());
    vertex(cx-dx, cy-dy);
    vertex(cx+dx, cy+dy);
    fill(rcol());
    vertex(x+cos(ang1)*dis1*s, y+sin(ang1)*dis1*s);
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#FF00AA, #FFAA00, #ffffff, #ffffff, #ffffff};
//int colors[] = {#8395FF, #FD674E, #FCC8FF, #1CB377, #FCD500};
int colors[] = {#FE562A, #F1AA01, #176962, #77B0E1, #F3F2EE, #262A33};
//int colors[] = {#BF28ED, #1C0A26, #0029C1, #5BFFBB, #EAE4E1};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
//int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #66BB06};
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
