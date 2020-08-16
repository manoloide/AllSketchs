void setup() {

  size(960, 960);
  smooth(8);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'g') generate();
}

void generate() {
  background(240);
  textureGrid();
  //simpleGrid2();
}

void textureGrid() {
  float cx = width*0.5;
  float cy = height*0.5;
  float diag = dist(0, 0, width, height);
  float sep = random(3, 30);
  float ang = random(TWO_PI);
  float len = random(5, 30);
  float ls = len*random(0.2, 0.4);

  stroke(0);

  strokeWeight(1);
  float sx = cos(ang+HALF_PI);
  float sy = sin(ang+HALF_PI);
  float dx = cos(ang)*diag;
  float dy = sin(ang)*diag;
  int cnt = 0;
  for (float i = -diag/2.; i < diag/2; i+=sep) {
    float ix = cx-dx-sx*i;
    float iy = cy-dy-sy*i;
    float dx1 = cos(ang)*(len+ls);
    float dy1 = sin(ang)*(len+ls);
    float dx2 = cos(ang)*(len);
    float dy2 = sin(ang)*(len);
    float x1 = ix;
    float y1 = iy;

    cnt++;
    if (cnt%2== 0) {
      x1 += dx1*0.5;
      y1 += dy1*0.5;
    }

    for (int j = 0; j < (diag*2)/(len+ls); j++) {
      x1 += dx1;
      y1 += dy1;
      float x2 = x1 + dx2;
      float y2 = y1 + dy2;
      Line line = lineIntersectionRect(new PVector(x1, y1), new PVector(x2, y2), new PVector(50, 50), new PVector(width-100, height-100));
      if (line != null) {
        //stroke(random(256), random(256), random(256));
        strokeWeight(map(abs(i), 0, diag/2, 0.5, sep*0.3));
        //line(line.p1.x, line.p1.y, line.p2.x, line.p2.y);
        line(x1, y1, x2, y2);
      }
    }
  }
  noFill();
  strokeWeight(sep*0.5);
  rect(50, 50, width-100, height-100);
}

void simpleGrid2() {    
  float cx = width*0.5;
  float cy = height*0.5;
  float diag = dist(0, 0, width, height);
  float sep = random(3, random(30));
  float ia = random(TWO_PI);
  int cc = int(random(1, 7));
  float da = TWO_PI/cc;

  for (int j = 0; j < cc; j++) {
    float ang = ia+da*j;
    stroke(0);
    float sx = cos(ang+HALF_PI);
    float sy = sin(ang+HALF_PI);
    float dx = cos(ang)*diag;
    float dy = sin(ang)*diag;
    for (float i = -diag/2.; i < diag/2; i+=sep) {
      float x1 = cx-dx-sx*i;
      float y1 = cy-dy-sy*i;
      float x2 = cx+dx-sx*i;
      float y2 = cy+dy-sy*i;
      Line line = lineIntersectionRect(new PVector(x1, y1), new PVector(x2, y2), new PVector(50, 50), new PVector(width-100, height-100));
      if (line != null) {
        strokeWeight(map(abs(i), 0, diag/2, 0, sep*0.5));
        line(line.p1.x, line.p1.y, line.p2.x, line.p2.y);
      }
    }
  }


  noFill();
  strokeWeight(sep*0.5);
  rect(50, 50, width-100, height-100);
}

void simpleGrid() {
  float cx = width*0.5;
  float cy = height*0.5;

  float diag = dist(0, 0, width, height);

  float sep = random(4, random(20));
  float ang = random(TWO_PI);

  ArrayList<Line> lines = new ArrayList<Line>(); 

  int rnd = int(random(200));
  for (int i = 0; i < rnd; i++) {
    Line l = new Line(random(width), random(height), random(width), random(height));
    lines.add(l);
  }

  {
    stroke(0);
    float sx = cos(ang+HALF_PI);
    float sy = sin(ang+HALF_PI);
    float dx = cos(ang)*diag;
    float dy = sin(ang)*diag;



    for (float i = -diag/2.; i < diag/2; i+=sep) {
      float x1 = cx-dx-sx*i;
      float y1 = cy-dy-sy*i;
      float x2 = cx+dx-sx*i;
      float y2 = cy+dy-sy*i;
    }
  }

  {
    ang += HALF_PI;
    float sx = cos(ang+HALF_PI);
    float sy = sin(ang+HALF_PI);
    float dx = cos(ang)*diag;
    float dy = sin(ang)*diag;
    for (float i = -diag/2.; i < diag/2; i+=sep) {
      float x1 = cx-dx-sx*i;
      float y1 = cy-dy-sy*i;
      float x2 = cx+dx-sx*i;
      float y2 = cy+dy-sy*i;
      //lines.add(new Line(x1, y1, x2, y2));
    }
  }



  ArrayList<Line> aux = new ArrayList<Line>();
  for (int i = 0; i < lines.size(); i++) {
    Line line = lineIntersectionRect(lines.get(i).p1, lines.get(i).p2, new PVector(50, 50), new PVector(width-100, height-100));
    if (line != null) {
      aux.add(line);
    }
  }
  lines = aux;

  /*
  stroke(0, random(50, 200));
   for (int i = 0; i < lines.size(); i++) {
   Line l = lines.get(i);
   line(l.p1.x, l.p1.y, l.p2.x, l.p2.y);
   } 
   */

  noFill();
  stroke(0, 80);
  for (int j = 0; j < lines.size(); j++) {
    Line act = lines.get(j);
    for (int i = j+1; i < lines.size(); i++) {
      Line a = lines.get(i);
      PVector po = segmetnsIntersection(act.p1, act.p2, a.p1, a.p2);
      if (po != null) ellipse(po.x, po.y, 3, 3);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}