int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  rectMode(CENTER);

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
  background(10);

  int ss = 10;

  stroke(20);
  noFill();
  for (int j = ss; j < height-ss; j+=ss) {
    for (int i = ss; i < width-ss; i+=ss) {
      rect(i, j, ss, ss);
    }
  }

  float cx = width/2;
  float cy = height/2;

  FloatList radius = new FloatList();
  int c = 40;
  radius.append(0.1);
  radius.append(0.9);
  float pwr = random(1, 10);
  if (random(1) < 0.5) pwr = 1/pwr;
  for (int i = 1; i < c; i++) {
    radius.append(pow(random(0.1, 0.9), pwr));
  }
  radius.sort();

  for (int i = 0; i < c; i+=int(random(1, random(1, 4)))) {
    float r1 = width*radius.get(i);
    float r2= width*radius.get(i+1);

    FloatList angles = new FloatList();

    int sub = int(random(2600*random(1)*random(0.5, 1))*random(1))*2;
    for (int j = 0; j < sub; j++) {
      angles.append(random(1)*TWO_PI);
    }

    angles.sort();

    noStroke();
    float ia = random(TWO_PI);
    for (int k = 0; k < sub; k+= 2) {
      fill(rcol());
      arc2(cx, cy, r1, r2, angles.get(k)+ia, angles.get(k+1)+ia);
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  int col = g.fillColor;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    fill(col);
    beginShape();
    //fill(col1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    //fill(col2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);

    /*
    beginShape();
     fill(0, 0);
     vertex(x+cos(ang)*r1, y+sin(ang)*r1);
     vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
     fill(0, 30);
     vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
     vertex(x+cos(ang)*r2, y+sin(ang)*r2);
     endShape(CLOSE);
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/190A33-db3b4b-edd23b-d4dbdd-2172ba
//int colors[] = {#DB204F, #EAC43A, #d4dbdd, #2172ba};
int colors[] = {#db3b4b, #edd23b, #d4dbdd, #2172ba};
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