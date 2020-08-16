import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 58621;//int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;


PShader blur;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

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

  blendMode(NORMAL);

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  int cc = 29; 
  float ss = width*1.0/cc;
  for (int i = 0; i < cc; i++) {
    float val = (i+0.5)*ss;
    stroke(255, random(200));
    line(0, val, width, val);
    stroke(255, random(200));
    line(val, 0, val, height);
  }

  for (int i = 0; i < 20; i++) {
    float a1 = PI*random(1.0, 1.5);
    float a2 = PI*random(1.5, 2.0);
    float ca = lerp(a1, a2, 0.5);
    int col = rcol();

    float xx = random(width);
    float yy = random(height);
    xx -= xx%ss;
    xx += ss*0.5;

    yy -= yy%ss;
    yy += ss*0.5;

    noStroke();
    float dis = width*random(0.2, 0.5);
    beginShape(TRIANGLE);
    fill(col, 180);
    vertex(xx, yy);
    fill(col, 0);
    vertex(xx+cos(a1)*dis, yy+sin(a1)*dis);
    fill(col, 20);
    vertex(xx+cos(ca)*dis, yy+sin(ca)*dis);
    endShape();

    beginShape(TRIANGLE);
    fill(col, 180);
    vertex(xx, yy);
    fill(col, 0);
    vertex(xx+cos(a2)*dis, yy+sin(a2)*dis);
    fill(col, 20);
    vertex(xx+cos(ca)*dis, yy+sin(ca)*dis);
    endShape();
  }

  //nt+random(1000));
  float it = random(100);
  float dt = random(0.01);
  for (int i = 0; i < 4; i++) {
    blur.set("time", it+i*dt);
    float blurAmp = 0.0001+(i*0.0001);
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp);
    filter(blur);
  }

  /*
  blendMode(ADD);
   
   for (int i = 0; i < cc*10; i++) {
   float xx = random(width);
   float yy = random(height);
   xx -= xx%ss;
   xx += ss*0.5;
   yy -= yy%ss;
   yy += ss*0.5;
   fill(rcol(), random(255));
   rect(xx, yy, ss, ss);
   }
   
   float detCol = random(0.001);
   for (int i = 0; i < 1000; i++) {
   float x = random(width);
   float y = random(height);
   fill(getColor(noise(x*detCol, y*detCol)));
   ellipse(x, y, 5, 5);
   }
   
   for (int i = 0; i < cc; i++) {
   float val = (i+0.5)*ss;
   stroke(255, random(200));
   line(0, val, width, val);
   stroke(255, random(200));
   line(val, 0, val, height);
   }
   
   it = random(100);
   dt = random(0.01);
   for (int i = 0; i < 4; i++) {
   blur.set("time", it+i*dt);
   float blurAmp = 0.00001+(i*0.0004);
   blur.set("direction", blurAmp, 0);
   filter(blur); 
   blur.set("direction", 0, blurAmp);
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
int colors[] = {#F7E242, #425CBC, #E885EA};


//int colors[] = {#B85807, #FAC440, #F4C8BF, #A0B9A6, #A1B2EA};
//int colors[] = {#F4C8BF, #A0B9A6, #A1B2EA};

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
