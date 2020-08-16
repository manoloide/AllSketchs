int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  noCursor();
  pixelDensity(2);
  generate();
}

void draw() {
  if (frameCount%60 == 0) {
    seed = int(random(999999));
  }
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void generate() {


  float time = millis()*0.001;

  lights();

  background(60);
  randomSeed(seed);

  ortho();
  translate(width/2, height/2);
  rotateX(map(mouseY, 0, height, +PI, -PI));
  rotateY(map(mouseX, 0, width, -PI, PI));

  translate(-width/2, -height/2);

  int cw = int(random(4, 33));
  float ww = width*1./cw;

  noStroke();
  int sub = 600; 
  float hh = height*1./sub;
  for (int i = 0; i < cw; i++) {
    float wave[] = new float[sub+1];
    float des = time*random(-1, 1);
    float osc = random(80)/height;
    for (int j = 0; j < sub+1; j++) {
      wave[j] = cos(des+j*osc);
    }

    float x1 = ww*i;
    float x2 = ww*(i+1);
    float dis = random(200);
    float dc = random(0.1)*random(1);
    for (int j = 0; j < sub; j++) {
      float y1 = hh*j;
      float y2 = hh*(j+1);
      fill(cos(dc*j)*128+127);
      beginShape();
      vertex(x1, y1, wave[j]*dis);
      vertex(x2, y1, wave[j]*dis);
      vertex(x2, y2, wave[j+1]*dis);
      vertex(x1, y2, wave[j+1]*dis);
      endShape(CLOSE);
    }
  }
}

float sign(float v) {
  if (v < 0) return -1; 
  if (v > 0) return +1; 
  return 0;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#F79832, #F18315, #DB6B01, #9C3702, #AD4B02};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}