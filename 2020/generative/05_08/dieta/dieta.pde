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
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brush = loadImage("diente.png");

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
  background(0);

  rectMode(CENTER);
  imageMode(CENTER);



  float detCol = random(0.001);

  float detSca = random(0.001);

  ArrayList<PVector> points = new ArrayList<PVector>();


  for (int i = 0; i < 9000; i++) {

    float mult = 1;
    if (random(1) < 0.1) {
      blendMode(ADD);
      mult = 0.5;
    } else blendMode(NORMAL);
    float x = random(width); 
    float y = random(height);
    float ns = pow(noise(x*detSca, y*detSca), 1.4);
    float sca = 0.05+random(0.5, 1.2)*random(1.4)*random(1)*ns*4;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < 740*pow((sca+other.z)*0.3, 0.9)) {
        add = false;
        break;
      }
    }

    if (add) {
      float nc = noise(x*detCol, y*detCol)*20;
      for (int k = 0; k < 8; k++) {
        pushMatrix();
        translate(x, y);
        rotate(random(TAU));
        float ns2 = pow(noise(x*detSca*2, y*detSca*2), 2);
        int col = getColor(sca*3+k*0.5);
        col = lerpColor(col, color(0), ns2*0.1);
        tint(col, random(250)*mult*random(0.8, 1));//lerpColor(color(0), rcol(), random(0.18)), random(255)*0.1);

        scale(1+k*0.05);
        image(brush, 0, 0, brush.width*sca*0.6, brush.height*sca*0.6);
        popMatrix();
      }

      points.add(new PVector(x, y, sca));
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#030005, #2E3F0E, #F91800, #F6E479, #F0F2F5};
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
  return lerpColor(c1, c2, pow(v%1, 1.2));
} 
