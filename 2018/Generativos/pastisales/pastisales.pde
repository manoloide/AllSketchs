int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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
  background(rcol(colors));

  float des = random(100000);
  float det = random(0.0012, 0.004);//random(0.05);
  float des2 = random(100000);
  float det2 = random(0.005, 0.002);//random(0.05);
  fill(rcol(colors));
  noiseDetail(2);
  noStroke();
  int cc = 200000;
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = map(i, 0, cc, 0, height);//random(height);
    float amp = map(y, 0, height, 0.6, 1.4);
    float a = 0.5;//random(0.2, 0.25);
    float n = noise(des+x*det, des+y*det*6);
    float n2 = noise(des2+x*det2, des2+y*det2*6);
    if (n < a) {
      float sa = pow(map(n, 0, a, 1, 0), 4);
      float s = 30*sa*random(0.5, 2)*amp;
      noStroke();
      fill(getColor(colors, random(colors.length)));
      ellipse(x, y, s, s);
      if (n < a && random(1) < 0.03 && s > 2) {
        noStroke();
        sa = map(n, a, 1, 0.1, 1);
        float h = 80*n2;//200*sa*amp;
        float w = h*random(0.02, 0.2);
        fill(0, 30);
        ellipse(x, y, w, h*0.2);
        fill(getColor(colors, random(colors.length)));
        rect(x-w*0.5, y-h, w, h);
      }
    } 
    if (n > a*0.5 && random(1) < 0.0008) {
      float s = random(2, 8)*random(1);
      if (random(1) < 0.5) {
        fill(0, 30);
        ellipse(x, y, s*2, s*0.6);
        fill(getColor(colors, random(colors.length)));
        triangle(x-s, y, x+s, y, x, y-s*1.8);
      } else {
        fill(0, 30);
        ellipse(x, y, s, s*0.3);
        fill(getColor(colors, random(colors.length)));
        quad(x-s, y-s, x, y, x+s, y-s, x, y-s*2);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FAF9F4, #DDDCDA, #D0E3E9, #A3D3C8, #F7CFCF, #F7A26B};
int back[] = {#FFF1F6, #FAF9F4, #F7F2EC, #DDDCDA, #272741};
int pas[] = {#D0E3E9, #A3D3C8, #F7CFCF, #F7A26B};
int sat[] = {#ACD3DA, #FAD988, #F7A26B, #F5B7BC};

int colors[] = {#121435, #FAF9F0, #EDEBCA, #FF5722};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}
int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}