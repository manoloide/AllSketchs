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

  background(#D4C8B8);

  int cc = int(random(20, 50));
  float ss = width*1./cc;

  int bb = 1;

  for (int i = bb; i < cc-bb+1; i++) {
    stroke(0, random(20, 40)*0.9);
    line(i*ss, ss*bb, i*ss, height-ss*bb);
    line(ss*bb, i*ss, width-ss*bb, i*ss);
  }

  for (int i = 0; i < 100; i++) {
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

    float alp1 = 8;
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

  float det1 = random(0.01);
  float det2 = random(0.01);
  noFill();
  float vel = random(0.5, 3);
  for (int i = 0; i < 4; i++) {
    float x1 = int(random(bb, cc-bb))*ss;
    float y1 = int(random(bb, cc-bb))*ss; 
    float x2 = int(random(bb, cc-bb))*ss;
    float y2 = int(random(bb, cc-bb))*ss; 
    float ic = random(1);
    float dc = 2./100;
    beginShape();
    for (int j = 0; j < ss*5; j++) {
      float a1 = noise(x1*det1, y1*det1)*TAU;
      float a2 = noise(x1*det2, y1*det2)*TAU;
      line(x1, y1, x2, y2);
      stroke(getColor(ic+dc), 100);
      x1 += cos(a1)*vel;
      y1 += sin(a1)*vel;
      x2 += cos(a2)*vel;
      y2 += sin(a2)*vel;
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

int colors[] = {#CAB18A, #C99A4E, #2D2A10};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
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
