import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

ArrayList<Particle> particles;
int count = 40000;
int seed = int(random(999999));
int back = #212026;

//PImage gradient;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  //gradient = loadImage("gradient.png");
  generate();
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

float desCol, detCol;
float des, det;

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  desCol = random(1000);
  detCol = random(0.004);
  des = random(1000);
  det = random(0.001);

  particles = new ArrayList<Particle>(); 
  for (int i = 0; i < count; i++) {
    particles.add(new Particle());
  }


  background(rcol());

  pushMatrix();
  translate(width*0.5, height*0.5);
  for (int i = 0; i < particles.size(); i++) {
    Particle p = particles.get(i); 
    p.update();
    p.show();
  }
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#202130, #193766, #2FABD0, #E6F9FF};
int colors[] = {#0F2442, #0168AD, #8AC339, #E65B61, #EDA787};
//int colors[] = {#EFE5D1, #F09BC4, #F54034, #1F43B1, #02ADDC};
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
  return lerpColor(c1, c2, v%1);
}
