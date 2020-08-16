void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  //noLoop();
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  background(58);

  noStroke();
  fill(60);
  rect(width/2, height/2, width-120, height-120, 2);

  for (int j = 0; j <= width; j+=15) {
    for (int i = 0; i <= width; i+=15) {
      float s = 1;
      if (i%2 == 0 && j%2 == 0) s = 3;
      fill(56);
      rect(i, j, s, s);
      fill(40);
      rect(i, j, 1, 1);
    }
  }

  drawFont(width/2-100, height/2-150, 200, 300, 60, random(1)<0.5, random(1)<0.5, random(1)<0.5, random(1)<0.5);
}

void drawFont(float x, float y, float w, float h, float r, boolean c1, boolean c2, boolean c3, boolean c4) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  if (c1) {
    points.add(new PVector(x, y+r));
    points.add(new PVector(x+r, y));
  } else {
    points.add(new PVector(x, y));
  }
  if (c2) {
    points.add(new PVector(x+w-r, y));
    points.add(new PVector(x+w, y+r));
  } else {
    points.add(new PVector(x+w, y));
  }
  if (c3) {
    points.add(new PVector(x+w, y+h-r)); 
    points.add(new PVector(x+w-r, y+h));
  } else {
    points.add(new PVector(x+w, y+h));
  }
  if (c4) {
    points.add(new PVector(x+r, y+h));
    points.add(new PVector(x, y+h-r));
  } else {
    points.add(new PVector(x, y+h));
  }
  fill(0);
  stroke(100);
  beginShape();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    vertex(p.x, p.y);
  }
  fill(100);
  stroke(90);
  endShape(CLOSE);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    rect(p.x, p.y, 4, 4, 1);
  }
}

int colors[] = {#4100DB, #EFC6D0, #FFA305, #FF2D2D, #E56299};
int rcol() {
  return colors[int(random(colors.length))];
}