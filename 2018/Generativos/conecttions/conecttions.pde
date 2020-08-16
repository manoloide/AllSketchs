import org.processing.wiki.triangulate.*;

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
  background(0);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 2; i++) {
    points.add(new PVector(width*random(0.4, 0.6), height*random(0.4, 0.6)));
  }

  float mh = sqrt(3/4);
  stroke(255, 30);
  float cs = cos(PI/3);
  float sn = sin(PI/3);
  for (int i = 0; i < 1000; i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size()))); 
    while (p1 == p2) p2 = points.get(int(random(points.size()))); 

    PVector c = p1.copy().add(p2).mult(0.5);

    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;
    PVector p3 = new PVector(cs*dx-sn*dy+p1.x, sn*dx+cs*dy+p1.y);
    line(c.x, c.y, p3.x, p3.y);
    points.add(p3);
  }


  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);
    for (int j = i+1; j < points.size(); j++) {
      PVector p2 = points.get(j);
      if (p1.dist(p2) < 0.2) {
        points.remove(j--);
      }
    }
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);


  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    int col = color(random(255));
    float alp = random(200)*random(0.2, 1);
    fill(col, 0);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    fill(col, alp);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();


  noStroke();
  fill(255);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 3, 3);
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

//int colors[] = {#FF0000, #FF6C06, #EF9FE2, #0045D8, #152300};
//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#34302E, #72574C, #9A4F7D, #488753, #D9BE3A, #D9CF7C, #E2DFDA, #CF4F5C, #368886};
//int colors[] = {#FFFFFF, #000000, #FFFFFF, #000000};
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