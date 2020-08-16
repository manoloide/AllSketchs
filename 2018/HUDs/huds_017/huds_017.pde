int seed = int(random(999999));
PFont chivo;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  blendMode(ADD);
  clear();
  background(0);
  chivo = createFont("Chivo-Light", 96, true);
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
  //background(5);

  background(#1C1528);
  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(1000)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    PVector r = rects.get(ind);
    float md = r.z*0.5;
    if (md < 60) continue;
    rects.add(new PVector(r.x, r.y, md));
    rects.add(new PVector(r.x+md, r.y, md));
    rects.add(new PVector(r.x, r.y+md, md));
    rects.add(new PVector(r.x+md, r.y+md, md));
    rects.remove(ind);
  }

  stroke(rcol(), 40);
  int cc = int(width*1./10);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      point(i*10, j*10);
    }
  }
  stroke(rcol(), 30);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      point(i*10+5, j*10+5);
    }
  }


  PGraphics gra;
  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    int w = int(r.z)-2;
    int h = int(r.z)-2;
    gra = createGraphics(w, h, P3D);
    gra.beginDraw();

    float fov = PI/random(1.4, 3);
    float cameraZ = (h/2.0) / tan(fov/2.0);
    gra.perspective(fov, float(w)/float(h), cameraZ/10.0, cameraZ*10.0);

    gra.translate(w*0.5, h*0.5);
    gra.rotateX(random(TWO_PI));
    gra.rotateY(random(TWO_PI));
    gra.rotateZ(random(TWO_PI));

    float ss = min(w, h)*random(0.5, 0.8);

    int dw = int(ss/random(4, 10));
    for (int j = 0; j < dw; j++) {
      float rr = ss*random(0.2, 1)*random(0.5, 0.8);
      float a = random(TWO_PI);
      float rnd = random(2);
      int col = rcol();
      gra.pushMatrix();
      gra.translate(0, 0, map(j, 0, dw-1, -ss*0.5, ss*0.5));
      gra.stroke(col, random(180, 255));
      gra.noFill();
      if (rnd < 1) {
        int div = int(random(8, random(22, 80)));
        float da = TWO_PI/div;
        for (int k = 0; k < div; k++) {
          gra.point(cos(a+da*k)*rr, sin(a+da*k)*rr);
        }
      } else if (rnd < 1.4) {
        gra.ellipse(0, 0, rr*2, rr*2);
      } 
      gra.popMatrix();
    }

    gra.endDraw();

    image(gra, r.x+1, r.y+1);

    stroke(rcol(), 30);
    fill(rcol(), 2);
    rect(r.x+1, r.y+1, r.z-3, r.z-3);

    noFill();
    for (int j = 0; j < random(10); j++) {
      float ww = int(random(1, r.z/10))*10;
      float hh = int(random(1, r.z/10))*10;
      float cx = r.x+r.z*0.5;
      float cy = r.y+r.z*0.5;
      stroke(rcol(), random(20));
      int rnd = int(random(4));
      if (rnd == 0) ellipse(cx, cy, ww, hh);
      if (rnd == 1) rect(cx-ww*0.5, cy-hh*0.5, ww, hh);
      if (rnd == 2) {
        line(cx-ww*0.5, cy-hh*0.5, cx+ww*0.5, cy+hh*0.5);
        line(cx+ww*0.5, cy-hh*0.5, cx-ww*0.5, cy+hh*0.5);
      }
      if (rnd == 3) {
        float mw = ww*0.5;
        float mh = hh*0.5;
        float bb = 5;
        line(cx-mw+bb, cy-mh, cx-mw, cy-mh);
        line(cx-mw, cy-mh, cx-mw, cy-mh+bb);


        line(cx+mw-bb, cy-mh, cx+mw, cy-mh);
        line(cx+mw, cy-mh, cx+mw, cy-mh+bb);


        line(cx+mw-bb, cy+mh, cx+mw, cy+mh);
        line(cx+mw, cy+mh, cx+mw, cy+mh-bb);


        line(cx-mw+bb, cy+mh, cx-mw, cy+mh);
        line(cx-mw, cy+mh, cx-mw, cy+mh-bb);
      }
    }



    textAlign(RIGHT, DOWN);
    textFont(chivo);
    textSize(int(r.z*0.15));
    fill(rcol(), 200);
    str(int(random(10)));
    text(str(i), r.x+(r.z-2)*0.97, r.y+(r.z-2)*0.96);

    /*
    String data[] = {"null", "error", "data", "danger", "love", "lost", "", "", "", "", "", "", "", "", "", ""};
     textSize(r.z*0.1);
     fill(rcol(), 60);
     textAlign(CENTER, CENTER);
     text(data[int(random(data.length))], r.x+r.z*0.5, r.y+r.z*0.05);
     */

    int c = int(random(0, 8));
    noStroke();
    for (int j = 0; j < c; j++) {
      fill(rcol(), random(180));
      rect(r.x+5+j*5, r.y+5, 4, 4, 0, 0, 3, 0);
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF5949, #FFC956, #1CEA64, #53EFF4};
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