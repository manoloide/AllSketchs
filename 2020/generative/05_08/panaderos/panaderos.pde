import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960;
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

PImage brush;

boolean export = false;
void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  brush = loadImage("diente.png");

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {

  generate();
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
  background(0 );

  ArrayList<PVector> points = new ArrayList<PVector>();
  
  imageMode(CENTER);

  float detSca = random(0.01);
  noStroke();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*noise(x*detSca, y*detSca)*0.9*random(0.8, 1)*random(1);//width*random(2)*random(1)*random(1)*random(1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      float max = max(max(s, other.z)*0.5, (s+other.z))*0.5;
      if (dist(x, y, other.x, other.y) < max) {
        add = false;
        break;
      }
    }
    if (add) {
      /*
      fill(getColor(0));
       ellipse(x, y, s*1.16, s*1.16);
       fill(getColor());
       ellipse(x, y, s*1.0, s*1.0);
       fill(getColor(s*0.02));
       ellipse(x, y, s*0.6, s*0.6);
       fill(0);
       ellipse(x, y, s*0.12, s*0.12);
       fill(rcol());
       ellipse(x, y, s*0.1, s*0.1);
       */
      pushMatrix();
      translate(x, y);
      rotate(random(TAU));
      fill(getColor(0));
      image(brush, 0, 0, s*1.16, s*1.16);
      fill(getColor());
      image(brush, 0, 0, s*1.0, s*1.0);
      fill(getColor(s*0.02));
      image(brush, 0, 0, s*0.6, s*0.6);
      popMatrix();

      points.add(new PVector(x, y, s));
    }
  }

  for (int i = 0; i < 1000000; i++) {
    float x = random(width);
    x = lerp(x, width*0.5, random(random(1), 1));
    float y = random(height);
    y = lerp(y, height*0.5, random(random(1), 1));
    float s = width*noise(x*detSca, y*detSca)*0.1*random(0.8, 1)*random(1);//width*random(2)*random(1)*random(1)*random(1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.5) {
        add = false;
        break;
      }
    }
    if (add) {
      pushMatrix();
      translate(x, y);
      rotate(random(TAU));
      tint(getColor(s*0.08+2));
      image(brush, 0, 0, s, s);
      popMatrix();
      points.add(new PVector(x, y, s));
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#CC00C8, #A600C7, #3500C4, #1447C6, #15BBB4};
int colors[] = {#dd0d52, #350E3D, #3500C4, #BCCDD8, #10F27A};
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
  return lerpColor(c1, c2, pow(v%1, 0.1));
} 
