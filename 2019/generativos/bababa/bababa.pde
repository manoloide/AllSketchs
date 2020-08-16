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

  blendMode(ADD);

  float sx = width*0.5;
  float sy = height*0.5;

  float s = width*0.02;
  noFill();
  float det = random(0.008, 0.01)*0.3;

  float amp = random(10, 14)*1.4;

  for (int j = 0; j < 900; j++) {
    float alp = random(10, 16)*2.4;
    float aa = random(TAU);
    float xx = sx+cos(aa)*s*0.5*random(90);
    float yy = sy+sin(aa)*s*0.5*random(90);
    float ia = noise(xx*det+seed, yy*det);
    float velRot = random(2, 6);
    if (random(1) < 0.5) velRot *= -1;

    float ic = random(colors.length);
    float dc = random(0.002, 0.003);

    beginShape();
    for (int i = 0; i < 600; i++) {//random(200, 1000); i++) {
      stroke(getColor(ic+dc*i), alp);
      vertex(xx, yy);
      aa += ((noise(xx*det+seed, yy*det+seed)-ia)*2-1)*velRot;
      xx += cos(aa)*amp;
      yy += sin(aa)*amp;
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

//int colors[] = {#F582DA, #8187F4, #F2F481, #81F498, #81E1F4};
//int colors[] = {#E65EC9, #5265E8, #F2F481, #81F498, #52D8E8};
int colors[] = {#B2354A, #3A48A5, #D69546, #683910, #46BCC9};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}
