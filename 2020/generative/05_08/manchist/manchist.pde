import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

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
int eyesCount = 2;

void setup() {
  frameRate(1);

  eyes = new PImage[eyesCount];
  for (int i = 0; i < eyesCount; i++) {
    int ind = (i+1);
    eyes[i] = loadImage("eye"+str(ind)+".png");
  }

  blur = loadShader("blur.glsl");

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

  background(rcol());

  imageMode(CENTER);
  PImage img = eyes[0];//(k < cc*0.5)? eyes[0] : eyes[1]; 

  for (int i = 0; i < 120; i++) {
    float x = random(width);
    float y = random(height);

    x -= x%20;
    y -= y%20;

    float s = random(0.1, 0.8)*random(0.6, 1)*random(0.2, 1)*1.6;
    s *= random(1.0, 1.5);
    float a = random(TAU);
    float da = random(-0.05, 0.05);
    float ms = random(0.9999, 1.0001);

    float ic = random(colors.length); 
    float dc = random(0.2)*random(1)*random(0.6, 1)*random(0.2, 1);
    int cc = int(random(100, 500)*random(1));
    float aa = random(TAU);

    float vel = random(2);

    float detAng = random(0.006);
    float desAng = random(100);
    float alp = random(200, 256);
    textureMode(NORMAL);
    noStroke();
    for (int k = 0; k < cc; k++) {

      float v = k*1./(cc-1);

      pushMatrix();
      translate(x, y);
      float ang = noise(desAng+k*detAng, i)*TAU*2;//a+k*da;
      float amp = pow(sin(v*PI), 0.1);
      float ww = img.width*s*amp;
      float hh = img.height*s*amp;
      rotate(ang+aa);
      scale(1+random(-0.01, 0.01));
      tint(getColor(ic+dc*k), alp);
      /*
      beginShape(QUAD);
       texture(img);
       vertex(-ww*0.5, -hh*0.5, 0, 0);
       vertex(+ww*0.5, -hh*0.5, 1, 0);
       vertex(+ww*0.5, +hh*0.5, 1, 1);
       vertex(-ww*0.5, +hh*0.5, 0, 1);
       endShape();
       */
      image(img, 0, 0, ww, hh);
      //s *= ms;
      popMatrix();
      x += cos(ang)*vel;
      y += sin(ang)*vel;
    }
  }

  /*
  PGraphics blank = createGraphics(1, 1);
   blank.beginDraw();
   blank.background(255);
   blank.endDraw();
   */
  /*
  //blur.set("mask", mask.get());
   float it = random(100);
   //float dt = random(0.01);
   noTint();
   for (int i = 0; i < 4; i++) {
   //blur.set("time", it+i*dt);
   float blurAmp = 0.001;
   blur.set("direction", blurAmp, 0);
   filter(blur); 
   blur.set("direction", 0, blurAmp*random(0.5, 1));
   filter(blur);
   }
   */
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
int colors[] = {#EF3428, #E5D256, #70B394, #519FCF, #DE6DAC, #8F61B4, #141514, #E7E7EE};
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
