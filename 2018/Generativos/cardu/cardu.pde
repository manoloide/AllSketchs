import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
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

void generate() {

  //blendMode(ADD);

  blendMode(ADD);

  randomSeed(seed);
  noiseSeed(seed);
  background(#010101);
  
  translate(width*0.5, height*0.5);

  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));

  Noise nrotx = new Noise(random(0.001), random(1000));
  Noise nroty = new Noise(random(0.001), random(1000));
  Noise nrotz = new Noise(random(0.001), random(1000));
  Noise nsize = new Noise(random(0.001), random(1000));
  Noise ncol = new Noise(random(0.001), random(1000));

  noStroke();
  for (int i = 0; i < 200000; i++) {
    float x = random(-480, 480);
    float y = random(-480, 480);
    float z = random(-480, 480);
    float s = nsize.get(x, y, z)*5;
    pushMatrix();
    translate(x, y, z);
    rotateX(nrotx.get(x, y, z)*TAU);
    rotateX(nroty.get(x, y, z)*TAU);
    rotateX(nrotz.get(x, y, z)*TAU);
    fill(getColor(ncol.get(x, y, z)), 180);
    ellipse(0, 0, s, s);
    popMatrix();
  }

  //SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*30;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
