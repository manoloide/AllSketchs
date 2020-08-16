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

  randomSeed(seed);

  background(255);

  rectMode(CENTER);
  noStroke();
  fill(0, 240);
  for (int i = 0; i < 240; i++) {
    float x = random(width);
    float y = random(height*1.2);
    
    x -= x%4;
    y -= y%4;
    
    float s = random(20, 160)*4*random(0.2, 1);
    pushMatrix();
    translate(x, y);
    rotate(random(PI)*int(random(2)));
    fill(0);
    rect(0, 0, s*0.2, s);
    float dd = 2+random(random(40));
    int cc = int(s/dd);
    for (int j = 1; j < cc; j++) {
      fill(0);
      rect(0, map(j, 0, cc, -s*0.5, s*0.5), s*0.42, 1.3);
      fill(255);
      rect(0, map(j, 0, cc, -s*0.5, s*0.5), s*0.2, 1.3);
    }
    fill(255);
    ellipse(0, 0, s*0.008, s*0.008);
    popMatrix();
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FB5D40, #D48300, #E5964B, #008172, #165253, #1C1C1A, #D8D8B9};
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
