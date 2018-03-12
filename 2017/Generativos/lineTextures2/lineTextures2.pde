void setup() {
  size(1920, 1920);
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
  blendMode(ADD);
  translate(width/2, height/2);
  float diag = dist(0, 0, width, height);
  float ang = random(TWO_PI);

  float dx = -diag*0.5;
  float minLen = random(5, 40);
  float maxLen = minLen*random(2, 12);
  float sep = random(2, random(30));
  float b = sep*random(0.8, 1);
  float g = random(0.2, 0.9);
  stroke(255);
  fill(0);
  while (dx < diag*0.5) {
    sep = random(2, random(30));
    b = sep*random(0.8, 1);
    dx += sep*0.5;
    float cx = cos(ang)*dx;
    float cy = sin(ang)*dx; 
    float dy = -diag*0.5;
    strokeWeight(sep*g);
    while (dy < diag*0.5) {
      float x1 = cos(ang+HALF_PI)*dy;
      float y1 = sin(ang+HALF_PI)*dy; 
      dy += random(minLen, maxLen);
      float x2 = cos(ang+HALF_PI)*dy;
      float y2 = sin(ang+HALF_PI)*dy; 
      dy += b;
      stroke(rcol(), random(50, 200));
      line(cx+x1, cy+y1, cx+x2, cy+y2);
      line(cx+x1, cy+y1, cx+x2, cy+y2);
    }

    dx += sep*0.5;
  }
}

int colors[] = {#d9601a, #5ae68b, #770101, #d9601a, #5ae68b};
int rcol() {
  return colors[int(random(colors.length))];
};