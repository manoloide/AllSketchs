int seed = int(random(999999));
PShader repeat;

void setup() {
  size(displayWidth, displayHeight, P2D);
  //smooth(8);
  pixelDensity(2);

  repeat = loadShader("repeat.glsl");
  repeat.set("resolution", float(width*2), float(height*2));

  generate();
}

void draw() {
  float time = millis()*0.001;
  //if (frameCount%40 == 0) generate();
  randomSeed(seed);
  noStroke();
  fill(map(cos(time*random(100)), -1, 1, 0, 256), 250);
  rect(0, 0, width, height);
  for (int k = 0; k < 12; k++) {
    float x = random(width)*0.5+cos(time*random(3))*width*0.5;
    float y = random(height)*0.5+cos(time*random(3))*height*0.5;
    float s = random(width)*0.6*random(1)*(1+cos(time*random(8))*random(0.5));
    float ra = random(-1, 1);
    int col1 = color(map(cos(time*random(40)), -1, 1, 0, 256));//getColor(random(colors.length));
    int col2 = color(map(cos(time*random(40)), -1, 1, 0, 256));//getColor(random(colors.length));

    int sub = int(random(4, 10));
    float ss = s/sub;
    pushMatrix();
    translate(x, y);
    rotate(random(TWO_PI)+ra*time);
    translate(random(-s), random(-s));
    noStroke();
    for (int j = 0; j < sub; j++) {
      for (int i = 0; i < sub; i++) {
        if ((i+j)%2 == 0) fill(col1);
        else fill(col2);
        rect(ss*i, ss*j, ss, ss);
      }
    }
    popMatrix();

    /*
    for (int j = 0; j < height; j++) {
     for (int i = 0; i < width; i++) {
     int col = get(i, j);
     set(width*2-i, j, col);
     }
     }
     */
  }

  filter(repeat);
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
  seed = int(random(999999999));
  newPallet();
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
//int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
//int colors[] = {#181A99, #5D93CC, #84ACD6, #454593, #E05328, #E28976};
int original[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A, #110206};
int colors[];

void newPallet() {
  colors = new int[original.length]; 
  colorMode(HSB, 360, 100, 100);
  float mod = random(360);
  for (int i = 0; i < original.length; i++) {
    colors[i] = color((hue(original[i])+mod)%360, saturation(original[i]), brightness(original[i]));
  }
  colorMode(RGB, 256, 256, 256);
}

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}