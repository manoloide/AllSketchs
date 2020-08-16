int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(190);

  rectMode(CENTER);
  int cc = 40;
  float dd = width*1./cc;
  noStroke();
  fill(200);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      rect(i*dd, j*dd, 4, 4);
    }
  }

  for (int i = 0; i < 8; i++) {
    float xx = random(width+dd);
    float yy = random(width+dd); 
    xx -= xx%dd;
    yy -= yy%dd;
    float ss = int(random(1, 3))*dd;

    fill(rcol());
    ellipse(xx, yy, ss, ss);
  }

  for (int j = 0; j < 40; j++) {
    ArrayList<PVector> points = new ArrayList<PVector>();
    int dir = 3;
    float xx = int(random(1, cc));
    float yy = cc;

    int vel = int(random(1, random(1, 8)));

    strokeWeight(3);
    for (int i = 0; i < 100; i++) {
      xx += int(cos(dir*HALF_PI)*vel);
      yy += int(sin(dir*HALF_PI)*vel);
      points.add(new PVector(xx, yy));
      if (random(1) < 0.5) {
        if (random(1) < 0.5) {
          dir++;
          dir = dir%4;
        } else {
          dir--;
          if (dir < 0) dir += 4;
        }
      } else {
        if (dir == 1) dir += (random(1) < 0.5)? -1 : 1;
        else if (random(1) < 0.5) dir = 3;
      }
    }

    noFill();
    stroke(rcol());
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      stroke(rcol());
      vertex(p.x*dd, p.y*dd);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FE4D9F, #EE1C25, #2F3293, #3CB74C, #0272BE, #BDCBD5, #FEFEFE};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
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