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
  generate();
}

void generate() {

  float time = millis()*0.001;

  background(0);

  int sub = 100;
  float ss = width*1./sub;
  stroke(255);
  
  randomSeed(seed);
  
  float o1 = random(0.3);
  float o2 = random(0.8);
  float o3 = random(0.1);
  
  for (int j =  -20; j < sub+20; j++) {
    for (int i = -20; i < sub+20; i++) {
      strokeWeight(cos(i*0.1+time)*1+3);
      stroke(255);//getColor(tan(i*0.002+time)*cos(j*0.01+time)*5.));
      point(i*ss, j*ss+cos(i)*40, cos(i*o2+time)*sin(j*o3+time)*80);
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
