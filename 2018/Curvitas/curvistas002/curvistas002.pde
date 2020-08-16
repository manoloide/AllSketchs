float det, des;
float time;
int seed = int(random(999999));


void setup() {
  size(960, 540, P2D);
  smooth(4);
  pixelDensity(2);
  noiseDetail(3);

  generate();
}

void draw() {

  time = millis()*0.001;

  generate();
}

void keyPressed() {
  if (key == 's') {
    saveImage();
  } else {
    seed = int(random(10000));
    //generate();
  }
}

void generate() {

  time = millis()*0.001;

  noiseSeed(seed);
  randomSeed(seed);
  background(255);
  
  translate(width*0.5, height*0.5);

  float des = random(10000);
  float det = random(0.001, 0.01);

  noiseDetail(int(random(4)));
  float res = int(random(120));
  float tt = time*random(1)*random(0.2, 1);
  float ang = random(TAU)+tt*random(-2, 2)*random(1);

  float x, y, a;
  float dt = random(1);
  noFill();
  for (int i = 0; i < 4000; i++) {
    x = (pow(noise(i, tt), 0.8)-0.5)*width*0.8; 
    y = (pow(noise(tt, i), 0.8)-0.5)*height*0.8; 
    int col = rcol();

    stroke(col, 8);
    beginShape();
    vertex(x, y);
    float ttt = tt+i*0.00001*dt;
    for (int j = 0; j < 80; j++) {
      a = ang+noise(des+x*det, des+y*det, ttt)*TAU*res;
      x += cos(a);
      y += sin(a);
      vertex(x, y);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

int colors[] = {#000000}; 
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