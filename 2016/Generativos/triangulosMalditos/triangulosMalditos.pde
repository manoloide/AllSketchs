void setup() {
  size(960, 960);
  rectMode(CENTER);
  generate();
}

void draw () {
}

void keyPressed() {
  if (key == 's') saveFrame();
  else generate();
}

void generate() {
  translate(width/2, height/2);
  rotate(PI/4);

  int cc = 8000;
  for (int i = 0; i < cc; i++) {
    float xx = random(-width*1.5, width*1.5);
    float yy = random(-height*1.5, height*1.5);
    float ss = 50*pow(2, int(random(1, map(i, 0, cc, 10, 2))+3*int(random(1.02)))*random(0, 1))+1;
    xx -= xx%50;
    yy -= yy%50;
    float c = rcol();
    if (random(1) < 0.5 && i < cc/2) {
      stroke(0, 3);
      noFill();
      for (int j = 5; j > 0; j--) {
        strokeWeight(j);
        rect(xx, yy, ss, ss);
      }
      strokeWeight(ss*0.01);
      stroke(max(0, c-2));
      fill(c);
      noStroke();
      rect(xx, yy, ss, ss);
    } else if (random(1) < 0.5) {
      stroke(0, 2);
      noFill();
      for (int j = 5; j > 0; j--) {
        strokeWeight(j);
        beginShape();
        vertex(xx-ss/2, yy);
        vertex(xx, yy+ss/2);
        vertex(xx+ss/2, yy);
        endShape(CLOSE);
      }
      strokeWeight(ss*0.01);
      stroke(max(0, c-2));
      fill(c);
      noStroke();
      beginShape();
      vertex(xx-ss/2, yy);
      vertex(xx, yy+ss/2);
      vertex(xx+ss/2, yy);
      endShape(CLOSE);
    } else {
      stroke(0, 3);
      noFill();
      for (int j = 3; j > 0; j--) {
        strokeWeight(j);
        rect(xx, yy, ss, ss*random(0, 0.1));
      }
      fill(c);
      noStroke();
      rect(xx, yy, ss, ss*random(0, 0.1));
    }
  }
}


float rcol() {
  float v = (random(1)< 0.4)? 0 : 225;
  return random(30)+v;
}

