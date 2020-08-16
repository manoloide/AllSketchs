int pallet[] = {
  #FFE700, 
  #FE4E6E, 
  #613864, 
  #D8D7D7
};

void setup() {
  size(960, 960);
}

void draw() {
}


void keyPressed() {  
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  noiseSeed(int(random(999999999)));
  background(255);
  float dl = random(0.0005, 0.01);
  float da = random(0.0005, 0.01);
  float dc = random(0.0002, 0.01);
  float maxLar = random(6, 40);
  float d = 0.8;
  for (float j = 0; j < height; j+=d) {
    frame.setTitle(map(j, 0, height, 0, 100)+"%");
    for (float i = 0; i < width; i+=d) {
      float ang = noise(i*da, j*da)*TWO_PI;
      float lar = noise(i*dl+500.4, j*dl+67)*maxLar;
      stroke(getColor(noise(i*dc+400, j*dc+37)*8), 60);
      line(i+random(-d, d), j+random(-d, d), i+cos(ang)*lar, j+sin(ang)*lar);
    }
  }
}

color getColor(float v) {
  float m = v%1;
  int c2 = ceil(v)%pallet.length;
  int c1 = floor(v)%pallet.length;
  return lerpColor(pallet[c1], pallet[c2], m);
}

int rcol() {
  return pallet[int(random(pallet.length))];
}