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

void generate() {

  int aux[] = new int[4];
  aux[0] = color(random(256), random(256), random(256));
  aux[1] = color(random(256), random(256), random(256));
  aux[2] = color(random(256), random(256), random(256));
  aux[3] = color(random(256), random(256), random(256)); 

  //colors = aux;


  background(255);

  int mode = 1;//int(random(4));
  if (mode == 0)blendMode(SUBTRACT);
  if (mode == 1)blendMode(DARKEST);
  if (mode == 2)blendMode(LIGHTEST);
  if (mode == 3)blendMode(SCREEN);

  for (int k = 0; k < 100; k++) {
    float ic = random(colors.length);
    float v1 = random(2)*random(1);
    float v2 = random(2)*random(1);
    float o1 = random(1);
    float o2 = random(1);

    float xx = width*random(1);
    float yy = height*random(1);

    float a = random(TAU);

    int div = 6;
    float da = TAU/div;
    float ia = random(TAU);

    noStroke();
    float ss = random(20);
    float rr = random(60);

    float dx1 = random(-2, 2)*random(1)*random(1);
    float dy1 = random(-2, 2)*random(1)*random(1);
    float dx2 = random(-2, 2)*random(1)*random(1);
    float dy2 = random(-2, 2)*random(1)*random(1);
    float dx3 = random(-2, 2)*random(1)*random(1);
    float dy3 = random(-2, 2)*random(1)*random(1);

    for (int i = 0; i < 400; i++) {
      float vc1 = map(cos(i*o1), -1, 1, v1, v2);
      float vc2 = map(cos(i*o2), -1, 1, v1, v2);
      float vel = (vc1+vc2)*0.005;
      ic += vel;
      int col = getColor(ic);
      float alp = 1;//6;
      fill(col, 10);
      //point(xx, yy);
      for (int j = 0; j < div; j++) {
        float dx = cos(ia+da*j)*rr;
        float dy = sin(ia+da*j)*rr;
        fill(red(col), 255, 255, alp);
        ellipse(xx+dx+dx1, yy+dy+dy1, ss, ss);
        fill(255, green(col), 255, alp);
        ellipse(xx+dx+dx2, yy+dy+dy2, ss, ss);
        fill(255, 255, blue(col), alp);
        ellipse(xx+dx+dx3, yy+dy+dy3, ss, ss);
      }
      a += vel*2;
      xx += cos(a);
      yy += sin(a);
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
int colors[] = {#FFFDF1, #FDD2E1, #EF694C, #DBDDC4, #4DA1CF};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
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
  return lerpColor(c1, c2, pow(v%1, 5.8));
}
