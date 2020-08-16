int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();

  saveImage();
  exit();
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
  randomSeed(seed);

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(100));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind); 
    float ss = r.z/3;
    if (ss <= width/(91*3)) continue;
    for (int yy = 0; yy < 3; yy++) {
      for (int xx = 0; xx < 3; xx++) {
        rects.add(new PVector(r.x+xx*ss, r.y+yy*ss, ss));
      }
    }
    rects.remove(ind);
  }

  noStroke();
  fill(240);
  rectMode(CENTER);
  imageMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float cx = r.x+r.z*0.5;
    float cy = r.y+r.z*0.5;
    float ss = r.z;


    fill(lerpColor(rcol(), color(255), 0.9));
    rect(cx, cy, r.z-1, r.z-1, 1);

    PGraphics gra = createGraphics(int(ss*0.8), int(ss*0.8), P3D);

    gra.beginDraw();
    gra.smooth(8);
    float fov = PI/random(1.4, 3.6);
    float cameraZ = (height/2.0) / tan(fov/2.0);
    gra.perspective(fov, float(width)/float(height), 
      cameraZ/100.0, cameraZ*100.0);
    gra.background(lerpColor(rcol(), color(255), random(1)));
    gra.translate(ss*0.5, ss*0.5);
    gra.rotateX(random(PI));
    gra.rotateY(random(PI));
    gra.rotateZ(random(PI));
    gra.rectMode(CENTER);
    gra.noStroke();
    gra.fill(rcol());
    gra.rect(0, 0, ss, ss);
    float s = ss*random(0.6);
    gra.stroke(rcol());
    gra.fill(rcol());
    gra.translate(0, 0, 1);
    gra.ellipse(0, 0, s, s);
    gra.line(-s*0.2, 0, s*0.2, 0);
    gra.line(0, -s*0.2, 0, s*0.2);
    gra.endDraw();

    image(gra, cx, cy);

    /*
    int c1 = rcol();
     int c2 = rcol();
     while (c1 == c2) c2 = rcol();
     fill(lerpColor(rcol(), color(255), 0.9));
     rect(cx, cy, ss*0.8-1, ss*0.8-1, 3);
     fill(rcol());
     if (random(1) < 0.5)
     trap(cx, cy, ss*0.8, ss*0.8, random(0.2, 1), random(0.2, 1), 1, 1);// random(1), random(1));
     else 
     trap(cx, cy, ss*0.8, ss*0.8, 1, 1, random(0.2, 1), random(0.2, 1));// random(1), random(1));
     */


    float sss = ss*0.1;
    fill(0, 30);
    arc(cx, cy, sss, sss, 0, HALF_PI);
    arc(cx, cy, sss, sss, PI, PI*1.5);
    fill(255, 30);
    arc(cx, cy, sss, sss, HALF_PI, PI);
    arc(cx, cy, sss, sss, PI*1.5, TAU);


    sss = ss*0.06;
    fill(0, 30);
    arc(cx, cy, sss, sss, 0, HALF_PI);
    arc(cx, cy, sss, sss, PI, PI*1.5);
    fill(255, 30);
    arc(cx, cy, sss, sss, HALF_PI, PI);
    arc(cx, cy, sss, sss, PI*1.5, TAU);
  }
}

void trap(float x, float y, float w, float h, float aw1, float aw2, float ah1, float ah2) {
  float mw = w*0.5;
  float mh = h*0.5;
  beginShape();
  vertex(x-mw*aw1, y-mh*ah2);
  vertex(x+mw*aw1, y-mh*ah1);
  vertex(x+mw*aw2, y+mh*ah1);
  vertex(x-mw*aw2, y+mh*ah2);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#0F101E, #11142B, #28398B, #323E78, #4254A3};
int colors[] = {#92C8FA, #0321A1, #07AE28, #F94D21, #FFFFFF};
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