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

  randomSeed(seed);

  background(rcol());
  for (int j = 0; j < 100; j++) {
    float s = random(0.5);
    //rotate(time*2.0);
    ArrayList<Line> lines = new ArrayList<Line>();
    lines.add(new Line(-s, 0, s, 0));
    int sub = 10;//int(random(1, 10));
    for (int i = 0; i < sub; i++) {
      Line l = lines.get(lines.size()-1);//int(random(lines.size())));
      lines.add(l.getLine());
    }


    pushMatrix();
    translate(random(width), random(height));
    rotate(random(TAU));
    noFill();
    noStroke();
    int acol = rcol();
    for (int i = lines.size()-1; i >= 0; i--) {
      Line l = lines.get(i);
      int col = rcol();
      while (acol == col) col = rcol();
      fill(col);
      l.drawRhombus();
      acol = col;
    }
    popMatrix();
  }
}

class Line {
  float x1, y1, x2, y2;
  Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1; 
    this.y1 = y1; 
    this.x2 = x2; 
    this.y2 = y2;
  }

  void drawLine() {
    line(x1, y1, x2, y2);
  }

  void drawRhombus() {
    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float h = dist(x1, y1, x2, y2);
    float ang = atan2(y2-y1, x2-x1);
    float des = h*sqrt(4./5);

    float shw = h*0.8;
    int col = g.fillColor;
    float alp = 100;

    beginShape();
    fill(0, alp);
    vertex(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des);
    vertex(x1, y1);
    fill(0, 0);
    vertex(x1-cos(ang)*shw, y1-sin(ang)*shw);
    vertex(cx+cos(ang+HALF_PI)*(des+shw), cy+sin(ang+HALF_PI)*(des+shw));
    endShape(CLOSE);

    beginShape();
    fill(0, alp);
    vertex(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des);
    vertex(x2, y2);
    fill(0, 0);
    vertex(x2+cos(ang)*shw, y2+sin(ang)*shw);
    vertex(cx+cos(ang+HALF_PI)*(des+shw), cy+sin(ang+HALF_PI)*(des+shw));
    endShape(CLOSE);

    beginShape();
    fill(0, alp);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    vertex(x1, y1);
    fill(0, 0);
    vertex(x1-cos(ang)*shw, y1-sin(ang)*shw);
    vertex(cx+cos(ang-HALF_PI)*(des+shw), cy+sin(ang-HALF_PI)*(des+shw));
    endShape(CLOSE);

    beginShape();
    fill(0, alp);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    vertex(x2, y2);
    fill(0, 0);
    vertex(x2+cos(ang)*shw, y2+sin(ang)*shw);
    vertex(cx+cos(ang-HALF_PI)*(des+shw), cy+sin(ang-HALF_PI)*(des+shw));
    endShape(CLOSE);

    beginShape();
    vertex(x2, y2);
    vertex(x1, y1);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    endShape(CLOSE);


    fill(col);
    beginShape();
    vertex(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des);
    vertex(x2, y2);
    vertex(x1, y1);
    endShape(CLOSE);

    beginShape();
    vertex(x2, y2);
    vertex(x1, y1);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    endShape(CLOSE);
  }

  Line getLine() {
    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float h = dist(x1, y1, x2, y2);
    float ang = atan2(y2-y1, x2-x1);
    float des = h*sqrt(4./5);
    return new Line(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des, cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
  }

  float getLength() {
    return dist(x1, y1, x2, y2);
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FFFFFF, #FFC7E3, #FFCC01, #48BD04, #003398};
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