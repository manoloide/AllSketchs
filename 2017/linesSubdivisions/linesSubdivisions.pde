ArrayList<Line> linesVer, linesHor;
boolean invert; 
boolean animation = true;
float speedSmooth = 0.1;

void setup() {
  size(960, 960, P3D);
  pixelDensity(2);
  reset();
  generate();
}


void draw() {
  if (animation) {
    background(250);

    for (int i = 0; i < linesVer.size(); i++) {
      Line l = linesVer.get(i);
      l.update();
      //l.show();
    }
    for (int i = 0; i < linesHor.size(); i++) {
      Line l = linesHor.get(i);
      l.update();
      //l.show();
    }


    rectMode(CORNERS);
    noStroke();
    for (int j = 0; j < linesVer.size()-1; j++) {
      Line lv1 = linesVer.get(j);
      Line lv2 = linesVer.get(j+1);
      for (int i = 0; i < linesHor.size()-1; i++) {
        Line lh1 = linesHor.get(i);
        Line lh2 = linesHor.get(i+1);
        if ((i+j)%2 == 0) fill(0);
        else fill(255);
        rect(lv1.p, lh1.p, lv2.p, lh2.p);
      }
    }
  }
}

void mousePressed() {
  invert = !invert;
  if (invert) {
    linesVer.add(new Line(linesVer, mouseX, true));
    linesVer.add(new Line(linesVer, mouseX, true));
    orderLines(linesVer);
  } else {
    linesHor.add(new Line(linesHor, mouseY, false));
    linesHor.add(new Line(linesHor, mouseY, false));
    orderLines(linesHor);
  }
}

void keyPressed() {
  if (key == 'r') {
    reset();
  }
  if (key == 'g') {
    generate();
  }
  if (key == 'c') {
    //reset();
    int cc = int(random(40));
    for (int i = 0; i < cc; i++) {
      invert = !invert;
      if (invert) {
        float p = width/2;
        linesVer.add(new Line(linesVer, p, true));
        linesVer.add(new Line(linesVer, p, true));
        orderLines(linesVer);
      } else {
        float p = height/2;
        linesHor.add(new Line(linesHor, p, false));
        linesHor.add(new Line(linesHor, p, false));
        orderLines(linesHor);
      }
    }
  }
  if (key == 's') saveImage();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  reset();
  randomLines(int(random(5, 100)));
  background(250);
  speedSmooth = random(0.2);
  for (int j = 0; j < 20; j++) {
    for (int i = 0; i < linesVer.size(); i++) {
      Line l = linesVer.get(i);
      l.update();
      l.show();
    }
    for (int i = 0; i < linesHor.size(); i++) {
      Line l = linesHor.get(i);
      l.update();
      l.show();
    }
  }


  rectMode(CORNERS);
  noStroke();
  for (int j = 0; j < linesVer.size()-1; j++) {
    Line lv1 = linesVer.get(j);
    Line lv2 = linesVer.get(j+1);
    for (int i = 0; i < linesHor.size()-1; i++) {
      Line lh1 = linesHor.get(i);
      Line lh2 = linesHor.get(i+1);
      if ((i+j)%2 == 0) fill(0);
      else fill(255);
      rect(lv1.p, lh1.p, lv2.p, lh2.p);
    }
  }

  int cc = int(random(30));
  lights();
  for (int i = 0; i < cc; i++) {
    fill(0);
    if (random(1) > 0.5) fill(255);
    float ss = (random(0.2)*width);
    ellipse(random(width), random(height), ss, ss);
  }

  rectMode(CORNERS);
  noStroke();
  for (int j = 0; j < linesVer.size()-1; j++) {
    Line lv1 = linesVer.get(j);
    Line lv2 = linesVer.get(j+1);
    for (int i = 0; i < linesHor.size()-1; i++) {
      Line lh1 = linesHor.get(i);
      Line lh2 = linesHor.get(i+1);
      if ((i+j)%2 == 0) fill(0);
      else fill(255);
      if (random(1) < 0.8 && (i+j)%2 == 0) rect(lv1.p, lh1.p, lv2.p, lh2.p);
    }
  }
}

void reset() {
  linesVer = new ArrayList<Line>();
  linesVer.add(new Line(linesVer, 0, true));
  linesVer.add(new Line(linesVer, width, true));
  linesHor = new ArrayList<Line>();
  linesHor.add(new Line(linesHor, 0, false));
  linesHor.add(new Line(linesHor, height, false));
}

void randomLines(float ml) {
  int cc = int(random(ml));
  for (int i = 0; i < cc; i++) {
    invert = !invert;
    if (invert) {
      float p = random(width);
      linesVer.add(new Line(linesVer, p, true));
      linesVer.add(new Line(linesVer, p, true));
      orderLines(linesVer);
    } else {
      float p = random(height);
      linesHor.add(new Line(linesHor, p, false));
      linesHor.add(new Line(linesHor, p, false));
      orderLines(linesHor);
    }
  }
}

class Line {
  ArrayList<Line> list;
  boolean invert;
  int ind;
  float p;
  Line( ArrayList<Line> list, float p, boolean invert) {
    this.list = list;
    this.p = p;
    this.invert = invert;
  }
  void update() {
    if (ind > 0 && ind < list.size()-1) {
      float d1 = list.get(ind-1).p-p;
      float d2 = list.get(ind+1).p-p;
      float d = (d1+d2)*speedSmooth;
      p += d;
    }
  }
  void show() {
    if (invert) {
      line(p, 0, p, height);
    } else {
      line(0, p, width, p);
    }
  }
}

void orderLines(ArrayList<Line> list) {
  for (int j = 0; j < list.size(); j++) {
    Line min = list.get(j);
    for (int i = j+1; i < list.size(); i++) {
      Line l = list.get(i);
      if (l.p < min.p) {
        float a = l.p;
        l.p = min.p;
        min.p = a;
      }
    }
  }
  for (int i = 0; i < list.size(); i++) {
    Line l = list.get(i);
    l.ind = i;
  }
}