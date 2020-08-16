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
}

void generate() {

  background(255);

  noStroke();
  for (int i = 0; i < 100; i++) {
    float x = width*random(random(0.5), random(0.5, 1));
    float y = height*random(random(0.2), random(0.2, 1));

    x -= x%10;
    x += 5;

    y -= y%10;
    y += 5;

    float s = width*random(0.1)*random(0.6, 1)*random(0.2, 1);
    float r = s*0.5;
    int col1 = rcol();
    int col2 = rcol();
    noStroke();
    beginShape(); 
    fill(col1, 250);
    vertex(x-r, y);
    vertex(x+r, y);
    fill(col1, 0);
    vertex(x+r, height);
    vertex(x-r, height);
    endShape();

    float det = random(0.01);

    for (int j = 0; j < 60; j++) {
      float ss = r*random(0.2);
      float rr = ss*0.5;
      float xx = x+random(-r+rr, r-rr);
      float yy = y;
      float ia = (float) SimplexNoise.noise(xx*det, yy*det)*20;
      noFill();
      //stroke(0);
      beginShape(QUAD_STRIP);
      for (int k = 0; k < 1000; k++) { 
        float v = map(k, 0, 1000, 0, 1);
        float a = (float) SimplexNoise.noise(xx*det, yy*det)*20-ia+PI*1.5; 
        fill(lerpColor(col1, col2, v));
        vertex(xx+cos(a-HALF_PI)*rr, yy+sin(a-HALF_PI)*rr);
        vertex(xx+cos(a+HALF_PI)*rr, yy+sin(a+HALF_PI)*rr);
        xx += cos(a);
        yy += sin(a);
      }
      endShape();
    }
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
int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
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
