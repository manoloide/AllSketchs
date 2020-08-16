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
  
  float time = random(10);
  
  randomSeed(seed);
  noiseSeed(seed);
  background(230);
  translate(width*0.5, height*0.5);
  scale(1.2);
  rotateX(PI*time);
  rotateY(PI*time);
  rotateZ(PI*time);
  
  float size = 400;

  line(-size, 0, 0, size, 0, 0);
  line(0, -size, 0, 0, size, 0);
  line(0, 0, -size, 0, 0, size);

  float d1 = random(0.1)*10.1;
  float d2 = random(0.1)*10.1;
  float d3 = random(0.1)*10.1;
  float i1 = random(TAU)*random(1);
  float i2 = random(TAU)*random(1);
  float i3 = random(TAU)*random(1);
  noFill();
  stroke(0, 120);
  beginShape();
  for (int i = 0; i < 100000; i++) {
    vertex(cos(i1+d1*i)*size, cos(i2+d2*i)*size, cos(i3+d3*i)*size);
  }
  endShape();
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
