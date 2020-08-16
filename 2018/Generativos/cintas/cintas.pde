int seed = int(random(999999));
void setup() {
  size(960, 960, P3D);
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
  background(#181818);

  translate(width/2, height/2, 0);//-2000);
  ortho();
  rotateX(random(-1.2, 1.2));
  rotateY(random(-1.2, 1.2));

  //lights();

  noFill();
  noiseDetail(1);
  float det = random(0.001, 0.02)*random(1);
  for (int i = 0; i < 10; i++) {
    float ang = random(TWO_PI);
    float x = 0;//+cos(ang)*width;
    float y = 0;//+sin(ang)*height;
    float des = random(100);
    float vel = 5;
    ArrayList<PVector> points = new ArrayList<PVector>();
    for (int j = 0; j < 1000; j++) {
      float a = noise(des+x*det, des+y*det)*TWO_PI-ang;
      points.add(0, new PVector(x, y));
      x += cos(a)*vel;
      y += sin(a)*vel;
    }
    x = 0; 
    y = 0;
    for (int j = 0; j < 1000; j++) {
      float a = noise(des+x*det, des+y*det)*TWO_PI-ang;
      points.add(new PVector(x, y));
      x -= cos(a)*vel;
      y -= sin(a)*vel;
    }

    //stroke(0, 20);
    noStroke();
    fill(rcol());
    for (int j = 0; j < points.size()-1; j++) {
      PVector p1 = points.get(j);
      PVector p2 = points.get(j+1);
      beginShape();
      vertex(p1.x, p1.y, 0);
      vertex(p1.x, p1.y, 100);
      vertex(p2.x, p2.y, 100);
      vertex(p2.x, p2.y, 0);
      endShape(CLOSE);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};

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