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

  background(0);

  float radius = width;
  blendMode(ADD);


  //float alp = 150;//random(100, 250);
  //stroke(255, 220);
  for (int i = 0; i < 1200000; i++) {
    float ang = random(TAU);
    float amp = random(random(0.4), 0.5)*random(0.2, 1)*radius;
    amp -= ((amp+ang*0.1)%60)*random(1);
    amp *= (1+cos(ang*20)*0.2);
    float x = width*0.5+cos(ang)*amp;
    float y = height*0.5+sin(ang)*amp;
    float s = random(1.4);
    float d = s*0.5*random(random(1), 2)*random(1);
    //d -= (d%10)*random(1);
    float alp = random(100, 250)*0.6;
    strokeWeight(s);
    stroke(rcol(), alp);
    point(x, y);
  }

  //filter(INVERT);
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
