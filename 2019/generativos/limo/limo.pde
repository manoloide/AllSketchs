int seed = int(random(999999));


float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  //background(lerpColor(rcol(), color(0), random(40)));
  background(230);

  DoubleNoise dn = new DoubleNoise();
  dn.noiseDetail(9);

  float des = random(1000);
  float det = random(0.0006, 0.0008)*0.4;
  float amp = random(16, 20)*random(0.5, 1);

  noFill();
  for (int i = 0; i < 9000; i++) {
    double x = random(width);
    double y = random(height);
    int col = color(rcol());//0);//rcol();
    fill(0, 80);
    ellipse((float)x, (float)y, 2, 2);
    noFill();
    beginShape();
    for (int j = 0; j < 300; j++) {
      stroke(col, 100+cos(j*0.1)*20);
      double a = dn.noise(dn.noise(des+x*det, des+y*det)*amp*3)*amp;
      x += Math.cos(a);
      y += Math.sin(a);
      vertex((float)x, (float)y);
    }
    double lx = x;
    double ly = y;
    for (int j = 0; j < 20; j++) {
      x = lx;
      y = ly;
      float da = random(TAU);
      float v1 = random(0.5, 1.5);
      for (int k = 0; k < 90; k++) {
        double a = dn.noise(dn.noise(des+x*det*10, des+y*det*10)*amp*3)*amp+da;
        x += Math.cos(a)*v1;
        y += Math.sin(a)*v1;
        vertex((float)x, (float)y);
      }
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
  return lerpColor(c1, c2, pow(v%1, random(1.4, 2.4)));//2.4)));
}
