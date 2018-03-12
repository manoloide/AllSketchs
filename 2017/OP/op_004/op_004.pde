void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
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
  background(0);
  translate(width/2, height/2);
  float diag = dist(0, 0, width, height);
  float ang = random(TWO_PI);

  float dx = -diag*0.5;
  float minSep = random(1, 10);
  float maxSep = random(3, 50);
  float minLen = random(5, 20);
  float maxLen = minLen*random(3, 10);
  stroke(255);
  fill(0);
  float bs = random(0.8, 1);
  float str = random(0.3, 0.7);
  float vc = random(0.1);
  float ss = random(1, 6);
  float sa = random(0.2, 1);
  strokeWeight(1);
  while (dx < diag*0.5) {
    float sep = map(noise(40+dx*vc), 0, 1, minSep, maxSep);
    float b = sep*bs*(1+str);
    strokeWeight(sep*sa);
    dx += sep*0.5;
    float cx = cos(ang)*dx;
    float cy = sin(ang)*dx; 
    float dy = -diag*0.5;
    while (dy < diag*0.5) {
      float x1 = cos(ang+HALF_PI)*dy;
      float y1 = sin(ang+HALF_PI)*dy; 
      dy += random(minLen, maxLen);
      float x2 = cos(ang+HALF_PI)*dy;
      float y2 = sin(ang+HALF_PI)*dy; 
      dy += b;
      line(cx+x1, cy+y1, cx+x2, cy+y2);
    }
    dx += sep*0.5+ss;
  }
}

int colors[] = {#fe435b, #19b596, #9061bf, #e0dc3f};
int rcol() {
  return colors[int(random(colors.length))];
};