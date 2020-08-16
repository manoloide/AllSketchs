import toxi.math.noise.SimplexNoise;

int seed = 88;//int(random(99999999));

boolean export = false;
float timeExport = 20;

PImage text;
PShader blur;

void setup() {
  size(1920, 1080, P2D);
  //size(960, 540, P2D);
  frameRate(30);
  smooth(4);
  blur = loadShader("blur.glsl");
  text = loadImage("circleGrad.png");

  background(255);
}


void draw() {

  if (frameCount%20 == 0) blur = loadShader("blur.glsl");

  float time = frameCount*(1./30);
  float nt = time/timeExport;
  nt = nt%1;

  //println(time, nt);

  randomSeed(seed);
  noiseSeed(seed);

  noStroke();
  int sub = 80;
  for (int i = 0; i < sub; i++) {
    float val = map(i, 0, sub, 1, 0);

    float ang1 = nt*TAU*int(random(1, 6));    
    float ang2 = nt*TAU*int(random(1, 6));
    float det1 = random(0.05);
    float det2 = random(0.05);
    float des1 = random(1000);
    float des2 = random(1000);

    float xx = (float) (SimplexNoise.noise(cos(ang1)*det1, sin(ang1)*det1, des1)+0.5)*width;
    float yy = (float) (SimplexNoise.noise(cos(ang2)*det2, sin(ang2)*det2, des2)+0.5)*height;
    float ss = 60*(0.5+val)*1.8;

    int col = getColor((val+nt*8.0)*colors.length);
    //col = color(0);

    imageMode(CENTER);
    tint(col, 16);
    image(text, xx, yy, ss, ss);
  }

  noTint();
  float blurAmp = map(cos(time*10), -1, 1, 0.001, 0.005)*0.04;
  blur.set("time", nt);//nt+random(1000));
  for (int i = 0; i < 5; i++) {
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp);
    filter(blur);
  }

  if (export) {
    if (frameCount >= timeExport*30) saveFrame("export/####.png");
    if (frameCount >= timeExport*30*2)exit();
    //else saveFrame("export/####.png");
  }
  
  println(frameRate);
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(9999999));
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#fffc3d, #000ed9, #f5adff};
//int colors[] = {#F7743B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#F7513B, #6789AA, #4B4372, #262626};
//int colors[] = {#50A85F, #DD2800, #F2AF3C, #5475A8};
//int colors[] = {#FFCC33, #F393FF, #6666FF, #01CCCC, #EDFFFC};
//int colors[] = {#FFCC33, #FFA8F4, #4949FF, #00DBDB, #EDFFFC};
//int colors[] = {#E8E6DD, #DFBB66, #D68D46, #857F5D, #809799, #5D6D83, #0F1C15};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};
int colors[] = {#EA0707, #c9bf08, #163572, #163572};
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
  return lerpColor(c1, c2, pow(v%1, 2.8));
}
