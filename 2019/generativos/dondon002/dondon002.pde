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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(3);

  translate(width*0.5, height*0.5, 200);
  
  

  float lrx = random(-0.1, 0.1);
  float lry = random(-0.1, 0.1);
  float lrz = -1;//random(-1, 1);
  ambientLight(40, 30, 40);
  directionalLight(255, 240, 245, lrx, lry, lrz);
  println(lrx, lry, lrz);

  rotateX(HALF_PI*0.2);
  rotateZ(HALF_PI*0.5);

  stroke(0, 40);
  strokeWeight(0.5);

  int cc = 600;
  float size = width*1.4;
  float ss = size*1./cc;
  float values[][] = new float[cc][cc];

  float det = random(0.004);
  float des = random(1000);


  float detCol = random(0.02, 0.03)*0.06;
  float desCol = random(1000);

  float detSize = random(0.02, 0.03)*0.4;
  float desSize = random(1000);

  for (int i = 0; i < 3400000; i++) {
    int x = int(random(cc));
    int y = int(random(cc));
    values[x][y] += pow(noise(des+x*det, des+y*det), 1.3)*0.8;
  }
  
  float detAmp = random(0.02, 0.03);
  float desAmp = random(1000);

  noiseDetail(6);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float amp = 8+2*max(0, pow(noise(desAmp+i*detAmp, desAmp+j*detAmp), 10.4)-0.4);
      float col = noise(desCol+j*detCol+cos(j*0.004)*0.9, desCol+i*detCol, noise(desCol+i*detCol, desCol+j*detCol)*20)*amp;
      fill(lerpColor(getColor(pow(col, 1.2)*2), color(255), 0.0));
      pushMatrix();
      translate(i*ss-size*0.5, j*ss-size*0.5);
      for (int k = 0; k < min(values[i][j], 1); k++) {
        float noi = (0.6+pow(noise(desSize+i*detSize, desSize+j*detSize), 0.8)*0.4);
        box(ss*1.01*random(0.92, 1)*noi);
        translate(0, 0, ss);
      }
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
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
  return lerpColor(c1, c2, pow(v%1, 2.4));
}
