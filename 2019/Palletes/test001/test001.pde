int seed = int(random(99999999));

void setup() {
  size(960, 420);
  generateColors();
}

void draw() {

  background(190);

  noStroke();
  float ss = width*1./colors.length;
  for (int i = 0; i < colors.length; i++) {
    fill(colors[i]);
    rect(i*ss+1, 0, ss-2, height-2);
  }
}

void keyPressed() {

  generateColors();
}

int colors[];

void generateColors() {

  int cc = int(random(3, 6));
  cc = 4;

  int divHue = int(random(2, 5));
  float desHue = 1./divHue;
  float initHue = random(desHue)*random(1)+desHue*int(random(divHue)); 

  if (random(1) < 0.4) desHue = 0;

  float minBri = random(255)*random(1)*random(1);
  float pwrBri = random(1, 4);
  if (random(1) < 0.5) pwrBri = 1./pwrBri;
  colorMode(HSB);
  colors = new int[cc];
  for (int i = 0; i < cc; i++) {
    float hue = (initHue+desHue*i)%1; 
    float sat = pow(random(random(0.7), 1), 1.2);
    float bri = pow(map(i+1, 0, cc, 0, 1), pwrBri);//random(map(i, 0, cc, 0.3, 0), 1);

    bri = random(map(i+1, 0, cc, 0.9, 1), 1);

    colors[i] = color(hue*255, sat*255, bri*255);
    sat = 255;
    bri = random(random(random(minBri, 255), 255), 255);
    //colors[i] = color(random(255), random(255), random(255));
  }
}
