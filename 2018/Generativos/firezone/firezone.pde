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

  randomSeed(seed);
  noiseSeed(seed);
  background(252, 251, 254);
  
  //blendMode(DARKEST);

  desAng = random(1000);
  detAng = random(0.002, 0.01)*0.5;
  desDes = random(1000);
  detDes = random(0.002, 0.01)*0.7;

  noiseDetail(1);
  
  translate(width*0.5, height*0.5);
  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));
  
  float size = 520;
  stroke(10, 20, 230, 180);
  noFill();
  for(int i = 0; i < 2200; i++){
      lline(random(-size, size), random(-size, size), random(-size, size), random(-size, size), random(-size, size), random(-size, size));
  }
}  

float desAng, detAng, desDes, detDes;

void lline(float x1, float y1, float z1, float x2, float y2, float z2) {
  int res = int(dist(x1, y1, z1, x2, y2, z2)*2);
  if(random(1) < 0.4) beginShape();
  else beginShape(LINES); 
  for (int i = 0; i < res; i++) {
    float v = i*1./res;
    PVector p = new PVector(lerp(x1, x2, v), lerp(y1, y2, v), lerp(z1, z2, v));
    p = desform(p.x, p.y, p.z);
    float col = (float) SimplexNoise.noise(desAng+p.x*detAng*0.18, desAng+p.y*detAng*0.18, desAng+p.z*detAng*0.18);
    stroke(getColor(col), pow(v, 1.4)*240);
    strokeWeight(v*12);
    vertex(p.x, p.y, p.z);
  }
  endShape();
}

PVector desform(float x, float y, float z) {
  double ang1 = (float) SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng, desAng+z*detAng)*TAU*5;
  double ang2 = (float) SimplexNoise.noise(desAng+y*detAng, desAng+z*detAng, desAng+x*detAng)*TAU*5;
  float des = (float) SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes, desAng+z*detAng)*30; 
  return new PVector((float)(x+Math.cos(ang1)*Math.cos(ang2)*des), (float)(y+Math.sin(ang1)*Math.cos(ang2)*des), (float)(z+Math.sin(ang2)*des));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
int colors[] = {#F6C9CC, #119489, #7AC3AB, #F47AD4, #6AC8EC, #5BD5D4, #1E4C5B, #CF350A, #F5A71C};
//int colors[] = {#3102F7, #F6C9CC, #F47AD4, #CF350A, #F5A71C};
//int colors[] = {#FFF4D4, #FD8BA4, #FF5500, #018CC7, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000};
//int colors[] = {#FCF0E3, #F3C6BD, #F36B7F, #F8CF61, #3040C4};
//int colors[] = {#FFFFFF, #FFFFFF, #000000, #000000, #000000, #000000, #000000, #000000, #FFFFFF, #000000};
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
