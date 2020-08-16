int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(0);

  float fov = PI/random(1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5, -400);

  for (int c = 0; c < 20; c++) {
    pushMatrix();
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));

    //lights();

    noStroke();

    int cc = int(random(4, 140));
    float ss = width*1.4/cc;
    float dd = cc*0.5*ss;

    //ss = 10;

    fill(rcol());
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        pushMatrix();
        translate(ss*i-dd, ss*(j-i)-dd, ss*i-dd);
        box(ss*0.8);
        popMatrix();
      }
    }
    popMatrix();
  }
}

void box(float ss) {
  float ms = ss*0.5;
  beginShape();
  fill(getColor());
  vertex(-ms, -ms, -ms);
  fill(getColor());
  vertex(+ms, -ms, -ms);
  fill(getColor());
  vertex(+ms, +ms, -ms);
  fill(getColor());
  vertex(-ms, +ms, -ms);
  endShape(CLOSE);


  beginShape();
  fill(getColor());
  vertex(-ms, -ms, +ms);
  fill(getColor());
  vertex(+ms, -ms, +ms);
  fill(getColor());
  vertex(+ms, +ms, +ms);
  fill(getColor());
  vertex(-ms, +ms, +ms);
  endShape(CLOSE);

  beginShape();
  fill(getColor());
  vertex(-ms, -ms, -ms);
  fill(getColor());
  vertex(+ms, -ms, -ms);
  fill(getColor());
  vertex(+ms, -ms, +ms);
  fill(getColor());
  vertex(-ms, -ms, +ms);
  endShape(CLOSE);

  beginShape();
  fill(getColor());
  vertex(-ms, +ms, -ms);
  fill(getColor());
  vertex(+ms, +ms, -ms);
  fill(getColor());
  vertex(+ms, +ms, +ms);
  fill(getColor());
  vertex(-ms, +ms, +ms);
  endShape(CLOSE);

  beginShape();
  fill(getColor());
  vertex(+ms, -ms, -ms);
  fill(getColor());
  vertex(+ms, +ms, -ms);
  fill(getColor());
  vertex(+ms, +ms, +ms);
  fill(getColor());
  vertex(+ms, -ms, +ms);
  endShape(CLOSE);

  beginShape();
  fill(getColor());
  vertex(-ms, -ms, -ms);
  fill(getColor());
  vertex(-ms, +ms, -ms);
  fill(getColor());
  vertex(-ms, +ms, +ms);
  fill(getColor());
  vertex(-ms, -ms, +ms);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
//int colors[] = {#FFCE3B, #3D2C71};
int colors[] = {#ADFE03, #FDFEFA, #FC4627, #070708};
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