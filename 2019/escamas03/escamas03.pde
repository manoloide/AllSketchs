import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;
PImage texture, blurs[];
PShader blur, blurWhite;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  int w = 120;
  int h = 120;
  PGraphics render = createGraphics(w, h, P2D);

  blurs = new PImage[10];

  blur = loadShader("blur.glsl");
  blurWhite = loadShader("blurWhite.glsl");

  for (int k = 0; k < 10; k++) {
    render.beginDraw();
    render.clear();
    render.noStroke();
    //render.fill(255, 180);
    render.fill(255, 0);
    render.rect(0, 0, width, height);
    for (int i = 0; i < 100; i+=2) {
      render.fill(255, i*0.2);
      render.ellipse(w*0.5, h*0.5, i*0.4, i*0.4);
    }

    float blurAmp = 0.004*k;
    for (int i = 0; i < 2; i++) {
      blur.set("direction", blurAmp, 0);
      render.filter(blur); 
      blur.set("direction", 0, blurAmp);
      render.filter(blur);
    }

    //render.ellipse(w*0.5, h*0.5, 100, 100);
    render.endDraw();
    blurs[k] = render.get();
  }

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
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

  /*
  blendMode(NORMAL);
   noStroke();
   fill(5, 0, 40, random(8));
   rectMode(CORNER);
   rect(0, 0, width, height);
   */
  background(5, 0, 40);
  hint(DISABLE_DEPTH_MASK);
  blendMode(ADD);

  int cc = int(random(40, 120)*0.3);
  float dd = width*1./(cc+2);

  /*
  fill(#F4F751);
   noStroke();
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   float xx = dd*(i+1.5);
   float yy = dd*(j+1.5);
   float ss = dd*0.12*2;
   if (random(1) < 0.5) continue;
   if (random(1) < 0.08) ss *= 4;
   ellipse(xx, yy, ss, ss);
   }
   }
   
   stroke(#F4F751);
   for (int i = 0; i < cc; i++) {
   float x1 = dd*(int(random(cc))+1.5);
   float y1 = dd*(int(random(cc))+1.5);
   float x2 = dd*(int(random(cc))+1.5);
   float y2 = dd*(int(random(cc))+1.5);
   if (random(1) < 0.4) x1 = x2;
   else y1 = y2;
   line(x1, y1, x2, y2);
   }
   */
  float time = millis()*random(0.0005)*0.1;
  //time += cos(time*random(0.1))*random(0.02)*random(1);

  rectMode(CENTER);
  fill(255, 160);
  float det = random(0.001);
  float detSpri = random(0.001);

  int c1 = color(random(255), random(255), random(255));
  int c2 = color(random(255), random(255), random(255));

  noStroke();
  rectMode(CENTER);
  imageMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = dd*(i+1.5);
      float yy = dd*(j+1.5);

      float rotX = (float) SimplexNoise.noise(xx*det, yy*det, time*random(1))*TAU*0.5;
      float rotY = (float) SimplexNoise.noise(xx*det*0.2, yy*det, time*random(1))*TAU*0.5;
      float rotZ = (float) SimplexNoise.noise(xx*det, yy*det*2, time*random(1))*TAU*0.5;

      int sprite = int(1+((float) SimplexNoise.noise(xx*detSpri, yy*detSpri, time*10.8)*0.5+0.5)*9);
      pushMatrix();
      translate(xx, yy);
      rotateX(rotX);
      rotateY(rotY);
      rotateZ(rotZ);

      int type = int(random(1.6));
      scale(pow((float) SimplexNoise.noise(xx*det, yy*det, time)*0.9+0.1, 1.2)*4);
      //rect(00, 00, dd*0.6, dd*0.6);
      //ellipse(00, 00, dd*0.6, dd*0.6);
      tint((type == 0)? c1 : c2, random(200));
      image(blurs[sprite], 0, 0);
      popMatrix();
    }
  }

  //image(texture, 120, 120);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F4F751, #000000, #FAFAFA};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
