import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brush;
PImage forms[];
PImage img;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brush = loadImage("plumas.png");

  //loadForms();

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

  randomSeed(seed);
  noiseSeed(seed);
  background(10);

  rectMode(CENTER);
  imageMode(CENTER);


  float detCol = random(0.0005);


  blendMode(NORMAL);
  for (int i = 0; i < 1200; i++) {

    float x = random(width); 
    float y = random(height);
    float sca = random(1.4)*random(1)*random(1)*0.8;


    if (dist(x, y, width*0.5, height*0.5) > width*0.38) {
      sca *= 0.8;
    }

    pushMatrix();
    translate(x, y);

    tint(getColor(noise(x*detCol, y*detCol)*10+random(1)), random(10));
    image(brush, 0, 0, brush.width*sca, brush.height*sca);
    popMatrix();
  }


  detCol = random(0.005);
  float detSca = random(0.01);
  float detAmp = random(0.01);

  ArrayList<PVector> points = new ArrayList<PVector>();

  hint(DISABLE_DEPTH_MASK);

  for (int i = 0; i < 3400; i++) {

    float mult = 1.0;
    if (random(1) < 0.3) {
      blendMode(ADD);
      mult = 0.1;
    } else blendMode(NORMAL);
    float x = random(width); 
    float y = random(height);

    if (dist(x, y, width*0.5, height*0.5) > width*random(0.38, 0.7)) continue;

    float amp = constrain(noise(x*detAmp, y*detAmp)*20-12, 0, 1)*0.1+0.9;
    float sca = pow(noise(x*detSca, y*detSca), 2)*random(0.5, 1);//random(0.5, 1.2)*random(0.2, 1)*random(1)*random(1);
    sca = pow(sca, 0.9)*amp;
    sca *= 0.8;
    if (sca < 0.1) {
      sca = 0.1;
      continue;
    }
    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      float dis = dist(x, y, o.x, o.y);
      if (dis < (sca+o.z)*0.28) {
        add = false;
        break;
      }
    }

    if (add) {

      blendMode(NORMAL);
      float nc = noise(x*detCol, y*detCol)*colors.length*2;
      int cc = int(random(4, 7));
      for (int k = 0; k < cc; k++) {
        pushMatrix();
        translate(x, y);
        scale(1-k*0.02);
        rotateX(random(TAU)*random(1));
        rotateY(random(TAU)*random(1));
        rotateZ(random(TAU)*random(1));
        float col = sca*0.6+nc+k*0.5;
        tint(getColor(col), random(255)*random(0.9, 1)*mult*1.5);//, random(260)*random(1)*mult*0.7);//lerpColor(color(0), rcol(), random(0.18)), random(255)*0.1);

        float ampSca = 0.3;
        image(brush, 0, 0, brush.width*sca*ampSca, brush.height*sca*ampSca);
        popMatrix();
      }
      points.add(new PVector(x, y, sca*brush.width));
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#130038, #94A039, #F90400, #DDAB4D, #F0F2F5};
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
