import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
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

  background(0);

  int cc = int(random(30, 50));
  float ss = width*1./cc;

  blendMode(ADD);

  int bb = 1;

  for (int i = bb; i <= cc-1; i++) {
    stroke(155, random(20, 40)*0.4);
    line(i*ss, ss*bb, i*ss, height-ss*bb);
    line(ss*bb, i*ss, width-ss*bb, i*ss);
  }

  /*
  noStroke();
   fill(255, 10);
   rectMode(CENTER);
   for (int i = bb; i <= cc*cc*2; i++) {
   float xx = (int(random(bb, cc))+0.5)*ss;
   float yy = (int(random(bb, cc))+0.5)*ss;
   float s = 0.12;
   if (random(1) < 0.1) s = 0.05;
   rect(xx, yy, ss*s, ss*s);
   }
   */

  for (int i = 0; i < 0; i++) {
    float x1 = int(random(bb, cc-bb))*ss;
    float y1 = int(random(bb, cc-bb))*ss; 
    float x2 = int(random(bb, cc-bb))*ss;
    float y2 = int(random(bb, cc-bb))*ss; 

    float mx = max(x1, x2);
    x1 = min(x1, x2);
    x2 = mx;
    float my = max(y1, y2);
    y1 = min(y1, y2);
    y2 = my;

    //float ww = x2-x1;
    //float hh = y2-y1;

    float alp1 = 2;
    float alp2 = 0;
    if (random(1) < 0.5) {
      alp2 = alp1;
      alp1 = 0;
    }

    noStroke();
    beginShape();
    fill(#E3DEDA, alp1);
    vertex(x1, y1);
    vertex(x2, y1);
    fill(#E3DEDA, alp2);
    vertex(x2, y2);
    vertex(x1, y2);
    endShape();
  }

  noFill();
  for (int i = 0; i < 30; i++) {
    float x1 = int(random(2, cc-1))*ss;
    float y1 = int(random(2, cc-1))*ss; 
    float x2 = int(random(2, cc-1))*ss;
    float y2 = int(random(2, cc-1))*ss; 
    float x3 = int(random(2, cc-1))*ss;
    float y3 = int(random(2, cc-1))*ss; 
    float x4 = int(random(2, cc-1))*ss;
    float y4 = int(random(2, cc-1))*ss; 
    float ic = random(colors.length);
    float dc = random(0.1)/30;
    float alp = random(120, 180)*0.09;
    float dis = max(dist(x1, y1, x2, y2), dist(x3, y3, x4, y4));
    dis = int(dis*random(0.15, 0.35));
    beginShape();
    float velOscAlp = random(20);

    float v1 = int(random(30));
    float v2 = int(random(30));

    for (int j = 0; j <= dis; j++) {
      float v = j*1./dis;
      float vv1 = v;//cos(v*TAU*v1)*0.5+0.5;
      float vv2 = v;//cos(v*TAU*v2)*0.5+0.5;
      float oscAlp = cos(v*velOscAlp)*0.5+0.5;
      stroke(getColor(ic+dc*j), alp+oscAlp*alp*0.8);
      float xx1 = lerp(x1, x2, vv1);
      float yy1 = lerp(y1, y2, vv1);
      float xx2 = lerp(x3, x4, vv2);
      float yy2 = lerp(y3, y4, vv2);
      line(xx1, yy1, xx2, yy2);
      xx1 = lerp(x1, x3, vv1);
      yy1 = lerp(y1, y3, vv1);
      xx2 = lerp(x2, x4, vv2);
      yy2 = lerp(y2, y4, vv2);
      line(xx1, yy1, xx2, yy2);
    }
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
//int colors[] = {#4D8E6A, #D11D02, #E2B40B, #5496A8};
int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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

float random2 (float x, float y) {
  float d = x*12.9898+y*78.233;
  return (abs(sin(d)*43758.5453123))%1;
}


float noise2 (float x, float y) {
  float ix = floor(x);
  float iy = floor(y);
  float fx = x%1;
  float fy = y%1;

  // Four corners in 2D of a tile
  float a = random2(ix, iy);
  float b = random2(ix+1, iy);
  float c = random2(ix, iy+1);
  float d = random2(ix+1, iy+1);

  float ux = fx * fx * (3.0 - 2.0 * fx);
  float uy = fy * fy * (3.0 - 2.0 * fy);

  return lerp(a, b, ux) +
    (c - a)* uy * (1.0 - ux) +
    (d - b) * ux * uy;
}

float fbm (float x, float y) {
  int oct = 4;
  float val = 0.0;
  float amp = .5;
  for (int i = 0; i < oct; i++) {
    val += amp * noise2(x, y);
    x *= 2.;
    y *= 2.;
    amp *= .5;
  }
  return val;
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int res = int(max(2, (r1*r2)*PI*0.2));
  float da = (a2-a1)/res;
  //col = rcol();
  beginShape(QUAD_STRIP);
  for (int i = 0; i < res; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(col, alp2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape();
}
