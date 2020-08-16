int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale));
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
  else {
    seed = int(random(999999));
    generate();
  }
}



void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(250);

  float detCol = random(10000);
  float desCol = random(0.0001);


  float detSca = random(10000);
  float desSca = random(0.02);


  int mode = 5;//int(random(9));

  for (int i = 0; i < 300; i++) {
    /*
    if (mode == 0) blendMode(ADD);
    if (mode == 1) blendMode(SUBTRACT);
    if (mode == 2) blendMode(DARKEST);
    if (mode == 3) blendMode(LIGHTEST);
    if (mode == 4) blendMode(DIFFERENCE);
    if (mode == 5) blendMode(EXCLUSION);
    if (mode == 6) blendMode(MULTIPLY);
    if (mode == 7) blendMode(SCREEN);
    if (mode == 8) blendMode(REPLACE);
    */

    //if(i == i%50) filter(BLUR, 0.3);
    float x = random(width);
    float y = random(height);
    float aw = random(0.2, 30*pow(random(1), 2));
    float ah = random(0.2, 30*pow(random(1), 0.5));
    float sca = random(0.2, 1.6)*noise(desSca+x*detSca, desSca+y+detSca);
    pushMatrix();
    translate(x, y);
    rotate((TAU/6.)*int(random(6)));

    int col = getColor(noise(desCol+x*detCol, desCol+y*detCol)*8);
    fill(col);


    rectMode(CENTER);
    noStroke();
    int size = int(random(80, 100)*sca);
    for (int k = 0; k < 20; k++) {
      fill(col, random(random(100, 220), 250));
      rect(size*random(-0.5, 0.5), size*random(-0.5, 0.5), random(size)*aw, random(size)*ah);
    }
    
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A};//#489B4D};
int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #f4221a, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
