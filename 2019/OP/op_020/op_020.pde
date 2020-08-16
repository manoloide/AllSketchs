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

  background(0);
  int sw = int(random(6, 12));
  float ww = width*1./sw;
  int sh = int(random(16, 46)*2);
  float hh = height*1./sh;
  noFill();
  //stroke(0);
  fill(255);
  float ic = random(colors.length);
  float dc = random(1)*random(1)*random(1);
  float amp = sh*0.15;
  noStroke();
  float osc = random(0.5, 1)*0.2;
  float dos = random(-0.05, 0.05)*random(0.03)*200.2;
  for (int i = 0; i < sh; i++) {
    int cc = width/5;
    fill(getColor(ic+i*dc));
    beginShape(QUAD_STRIP);
    for (int j = 0; j <= cc; j++) {
      float x = map(j, 0, cc, 0, width);
      float des = hh*0.5;
      vertex(x, i*hh-amp+des+cos(j*osc+dos*i)*amp);
      vertex(x, i*hh+amp+des+cos(j*osc+dos*i)*amp);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
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
