import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
    seed = int(random(999999));
    generate();
  }
}



void generate() { 

  println(seed);
  randomSeed(seed);
  scale(scale);

  background(30);

  float des = random(10000);
  float det = random(0.0002, 0.0006);

  float desCol = random(10000);
  float detCol = random(0.0004, 0.001);

  int cc = int(random(15, 18)*20);
  float ss = width*1./cc;
  
  blendMode(ADD);
  
  float lar = random(120);

  noiseDetail(2);
  strokeWeight(random(0.4, 1.2));
  for (int k = -5; k < cc+5; k++) {
    for (int j = -5; j < cc+5; j++) {
      ArrayList<PVector> points = new ArrayList<PVector>();
      float x = j*ss;
      float y = k*ss;

      float ang = 0;



      stroke(getColor(noise(desCol+x*detCol, desCol+y*detCol)*10+((k+j)/8)%2), 16);

      for (int i = 0; i < lar; i++) {

        ang = ((float) SimplexNoise.noise(des+x*det, des+y*det)*2-1)*HALF_PI*18;

        x += cos(ang)*0.5;
        y += sin(ang)*0.5;

        points.add(new PVector(x, y));
      }

      noFill();
      beginShape();
      for (int i = 0; i < points.size(); i++) {
        PVector p = points.get(i);
        vertex(p.x, p.y);
      }
      endShape();
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#B0E7FF, #143585, #5ACAA2, #F98FC0, #D08714};
//int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
