import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 58621;//int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PGraphics mask;
PShader blur;
PImage brush;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

PImage eyes[];
int eyesCount = 1;

void setup() {



  eyes = new PImage[eyesCount];
  for (int i = 0; i < eyesCount; i++) {
    int ind = (i+1);
    eyes[i] = loadImage("eye"+str(ind)+".png");
  }

  blur = loadShader("blur.glsl");
  brush = loadImage("brush.png");

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {


  blur = loadShader("blur.glsl");

  randomSeed(seed);
  noiseSeed(seed);
  
  imageMode(CENTER);
  PImage img = eyes[0];
  for(int i = 0; i < 300; i++){
     float x = random(width);
     float y = random(height);
     float s = random(0.8)*random(0.2, 1);
     pushMatrix();
     translate(x, y);
     rotate(random(TAU));
     tint(rcol(), random(200));
     image(img, 0, 0, img.width*s, img.height*s);
     popMatrix();
  }

  //nt+random(1000));
  /*
  blur.set("mask", mask.get());
  float it = random(100);
  float dt = random(0.01);
  for (int i = 0; i < 8; i++) {
    blur.set("time", it+i*dt);
    float blurAmp = 0.0001+(i*0.002);
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp*random(0.5, 1));
    filter(blur);
  }
  */

  //image(mask, 10, 10, 100, 100);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#0A0B0B, #2E361E, #ACB2A4, #B66F3A, #B91A1B};
int colors[] = {#B85807, #FAC440, #F4C8BF, #A0B9A6, #A1B2EA};
//int colors[] = {#B2734B, #A69050, #897E6A, #5B6066, #292E31};
//int colors[] = {#FCB375, #FEAE02, #FED400, #F0EBBE, #B0DECE, #01B6D2, #18AD92, #90BC96};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
