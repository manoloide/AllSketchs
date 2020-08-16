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
  background(80);

  int sub = int(random(8, 30));
  FloatList ps = new FloatList();
  ps.append(0);
  ps.append(1);
  for (int i = 2; i < sub; i++) {
    ps.append(random(1));
  }
  ps.sort();

  for (int i = 1; i < ps.size(); i++) {
    float x = ps.get(i-1)*width;
    float w = width*(ps.get(i)-ps.get(i-1));
    FloatList hh = new FloatList();
    int cc = int(random(8, random(40, 120)));
    for (int j = 2; j < cc; j++) {
      hh.append(random(1));
    }
    hh.append(0);
    hh.append(1);
    hh.sort();
    for (int j = 1; j < hh.size(); j++) {
      float y = height*hh.get(j-1);
      float h = height*(hh.get(j)-hh.get(j-1));
      beginShape();
      fill(getMix());
      vertex(x, y);
      vertex(x+w, y);
      fill(getMix());
      vertex(x+w, y+h);
      vertex(x, y+h);
      endShape(CLOSE);
    }
  }




  float des = random(1000);
  float det = random(0.006);
  float pwr = random(0.8, 1.2);
  noStroke();
  noiseDetail(2);
  int div = int(random(1, 100));
  float dh = height/div;
  for (int j = 0; j < div; j++) {
    float y1 = dh*j;
    float y2 = dh*(j+1);
    beginShape();
    fill(getMix());
    for (int i = 0; i <= width; i+=2) {
      float h = map(pow(noise(des+i*det, y1*det), pwr), 0, 1, height*0.2, height*0.7);
      vertex(i, h+y1);
    }
    fill(getMix());
    for (int i = width; i >= 0; i-=2) {
      float h = map(pow(noise(des+i*det, y2*det), pwr), 0, 1, height*0.2, height*0.7);
      vertex(i, h+y2);
    }
    endShape(CLOSE);
  }

  //vertex(width, height);
  //vertex(0, height);
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
int getMix() {
  return lerpColor(rcol(), rcol(), random(1));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}