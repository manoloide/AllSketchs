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

  float ss = random(10, random(60, 240));
  float hh = sqrt(ss*ss*0.75);
  int cc = int(height/hh);

  translate(width*0.5, height*0.5);

  float des = random(100000);
  float det = random(0.005);
  float amp = random(0.4, 0.9);
  for (int j = 0; j < cc; j++) {
    float dy = (j%2)*0.5;
    for (int i = 0; i < cc; i++) {
      float xx = (i-cc*0.5+dy)*ss; 
      float yy = (j-cc*0.5)*hh;

      noStroke();
      int col = rcol();
      int col2 = rcol();
      while (col == col2) col2 = rcol();
      fill(col, 80);
      ellipse(xx, yy, ss, ss);
      fill(col);
      ellipse(xx, yy, ss*amp, ss*amp);
      arc2(xx, yy, ss*amp, ss, 0, TAU, col, 50, 0);

      float a1 = noise(des+xx*det, des+yy*det)*TAU;
      float a2 = a1+PI*random(0.05);
      fill(col2, 180);
      arc(xx, yy, ss, ss, a1, a2);
      arc2(xx, yy, ss, ss, a1, a2, color(0), 200, 0);

      stroke(0);
      fill(255);
      ellipse(xx, yy, 2, 2);
    }
  }

  int ccc = int(cc*cc*random(4)*0.1);
  for (int j = 0; j < ccc; j++) {
    int x = int(random(cc));
    int y = int(random(cc));
    float dy = (y%2)*0.5;
    float x1 = (x-cc*0.5+dy)*ss; 
    float y1 = (y-cc*0.5)*hh;
    float ang = radians(int(random(3))*120+30);
    float ddd = int(random(1, cc/3))*2;
    float x2 = x1+cos(ang)*hh*ddd;
    float y2 = y1+sin(ang)*hh*ddd;

    ArrayList<Line> lines = new ArrayList<Line>();
    lines.add(new Line(x1, y1, x2, y2));
    int sub = int(random(20));
    for (int i = 0; i < sub; i++) {
      Line l = lines.get(lines.size()-1);//int(random(lines.size())));
      lines.add(l.getLine());
    }

    noFill();
    noStroke();
    int acol = rcol();
    for (int i = 0; i < lines.size(); i++) {
      //for (int i = lines.size()-1; i >= 0; i--) {
      Line l = lines.get(i);
      int col = rcol();
      while (col == acol) col = rcol();
      noStroke();
      fill(col);
      l.drawRhombus();
      acol = col;
      stroke(rcol());
      //l.drawLine();
    }
  }

  for (int j = 0; j < ccc; j++) {
    int x = int(random(cc));
    int y = int(random(cc));
    float dy = (y%2)*0.5;
    float x1 = (x-cc*0.5+dy)*ss; 
    float y1 = (y-cc*0.5)*hh;
    float ang = radians(int(random(3))*120+30);
    float ddd = int(random(1, cc/3))*2;
    float x2 = x1+cos(ang)*hh*ddd;
    float y2 = y1+sin(ang)*hh*ddd;

    ArrayList<Line> lines = new ArrayList<Line>();
    lines.add(new Line(x1, y1, x2, y2));
    int sub = 0;//int(random(20));
    for (int i = 0; i < sub; i++) {
      Line l = lines.get(lines.size()-1);//int(random(lines.size())));
      lines.add(l.getLine());
    }

    for (int i = 0; i < lines.size(); i++) {
      Line l = lines.get(i);
      stroke(rcol(), 120);
      l.drawLine();
    }
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

    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float h = dist(x1, y1, x2, y2)*0.5;
    float ang = atan2(y2-y1, x2-x1);
    float des = sqrt(h*h*(4./3))*0.5;

    line(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des, cx+cos(ang-HALF_PI)*(des), cy+sin(ang-HALF_PI)*(des));
  }

  void drawRhombus() {
    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float h = dist(x1, y1, x2, y2)*0.5;
    float ang = atan2(y2-y1, x2-x1);
    float des = sqrt(h*h*(4./3))*0.5;//sqrt(4./5);
    //float des = h*0.894427191;//sqrt(4./5);

    float shw = h*0.8;
    int col = g.fillColor;
    int col2 = rcol();
    while (col == col2) col2 = rcol();
    col2 = lerpColor(col2, col, 0.6);
    float alp = 10;

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
    fill(col);
    vertex(x1, y1);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    fill(col2);
    vertex(cx, cy);
    endShape(CLOSE);

    beginShape();
    fill(col);
    vertex(x2, y2);
    vertex(cx+cos(ang-HALF_PI)*des, cy+sin(ang-HALF_PI)*des);
    fill(col2);
    vertex(cx, cy);
    endShape(CLOSE);



    beginShape();
    fill(col);
    vertex(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des);
    vertex(x1, y1);
    fill(col2);
    vertex(cx, cy);
    endShape(CLOSE);

    fill(col);
    beginShape();
    fill(col);
    vertex(cx+cos(ang+HALF_PI)*des, cy+sin(ang+HALF_PI)*des);
    vertex(x2, y2);
    fill(col2);
    vertex(cx, cy);
    endShape(CLOSE);
  }

  Line getLine() {
    float cx = (x1+x2)*0.5;
    float cy = (y1+y2)*0.5;
    float h = dist(x1, y1, x2, y2)*0.5;
    float ang = atan2(y2-y1, x2-x1);
    float des = sqrt(h*h*(4./3))*0.5;
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

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
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