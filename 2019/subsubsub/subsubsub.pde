import peasy.PeasyCam;

int seed = int(random(999999));

PeasyCam cam;

void setup() {
  size(960, 540, P3D);
  //size(1920, 1080, P3D);
  smooth(8);
  //pixelDensity(2);
  rectMode(CENTER);
  imageMode(CENTER);

  generate();
}

void draw() {

  //lights();

  background(220);

  randomSeed(seed);

  float time = millis()*0.001;

  float velOsc = random(0.6, 1)*0.2;

  float desCol = random(10000);
  float detCol = random(0.001, 0.0015)*10;

  noStroke();

  for (int i = 0; i < 500; i++) {
    float xx = random(width); 
    float yy = height*(random(-0.1, 1.1)+cos(time*velOsc+xx*0.0012)*0.1);
    float zz = height*random(-0.5);
    float ss = random(width*0.05)*random(1)*random(1);
    pushMatrix();
    translate(xx, yy, zz);
    rotateX(random(TAU)+time*random(-1, 1)*random(1));
    rotateY(random(TAU)+time*random(-1, 1)*random(1));
    rotateZ(random(TAU)+time*random(-1, 1)*random(1));

    float noiseCol = noise(desCol+xx*detCol, desCol+yy*detCol, desCol+zz*detCol);
    fill(getColor(noiseCol*colors.length));
    float s = ss*(0.1+pow(cos(random(TAU)+time*random(0.8)*0.5+0.5), random(0.5, 2))*3);
    float s2 = s*random(0.05, 0.15);
    float amp = random(1, 10);

    box(s);

    box(s*amp, s2, s2);
    box(s2, s*amp, s2);
    box(s2, s2, s*amp);
    popMatrix();
  }
}

void keyPressed() {
  if (key == ' ') {
    generate();
  } else if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));
}

//int colors[] = {#2C6CF6, #76FB87, #FBFDFD, #652D90};
//int colors[] = {#D12C34, #4DC3C3, #F5D407, #652D90};
//int colors[] = {#ff250d, #0d4de0, #fff317, #210557};
int colors[] = {#ffffff, #000000, #ff3300, #0033ff};

int rcol() {
  int col = colors[int(random(colors.length))];
  return col;
}

int getColor() {
  return getColor(random(colors.length));
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 2));
}
