void setup() {
  size(960, 960); 
  textFont(createFont("Chivo Light", 48, true));
  smooth(8);
  generate();
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
  blendMode(BLEND);
  background(254);
  strokeWeight(2);
  stroke(252);
  for (int i = -4; i < width+height; i+=8) {
    line(-1, i, i, -1);
  }
  blendMode(DARKEST);
  for (int i = 0; i < 8; i++) {
    float x = random(width);
    float y = random(height);
    float ang = random(TWO_PI);
    float dis = random(width*0.9);
    x = width/2+cos(ang)*dis;
    y = height/1.6+sin(ang)*dis;
    float s = 2*pow(2, 7+floor(random(5)*random(0, 1)));
    color col = rcol();//(random(1) < 0.5)? color(255, 120, 0) : color(0, 120, 255);
    fill(col);
    noStroke();
    ellipse(x, y, s, s);

    if (s > 50) {
      stroke(col);
      strokeWeight(1);
      noFill();
      beginShape();
      vertex(x, y);
      vertex(x+s*0.5, y-s*0.5);
      //vertex(x+s*0.9, y-s*0.5);
      endShape();
      textAlign(LEFT, DOWN);
      textSize(s*0.25);
      text(x+"x"+y, x+s*0.5, y-s*0.5);
    }
  }

  noFill();
  blendMode(ADD);
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(2, 16)*random(1);
    float a1 = random(TWO_PI);
    float a2 = a1+PI*random(0.8);
    stroke(255, random(255)*random(1)*random(1));
    arc(x, y, s, s, a1, a2);
  }
}

int rcol() {
  IntList ind = new IntList();
  ind.append(0);
  ind.append(80);
  ind.append(255);
  ind.shuffle();
  color col = color(ind.get(0), ind.get(1), ind.get(2));
  return col;
}