import geomerative.*;

ArrayList<Letter> letters;
RShape grp;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  letters = new ArrayList<Letter>();

  RG.init(this);
  grp = RG.getText("AEIFGH", "font.ttf", 200, CENTER);
  int cc = grp.countChildren();
  for (int i = 0; i < cc; i++) {
    letters.add(new Letter(grp.children[i]));
  }

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

int back;
void generate() {
  back = rcol();
  background(back);

  //ortho();

  ambientLight(248, 248, 248);
  directionalLight(5, 5, 5, 0, 0, -1);
  //lightFalloff(1, 0, 0);
  lightSpecular(0, 0, 0);

  translate(width/2, height/2, 0);
  rotateX(random(-HALF_PI*0.1, HALF_PI*0.1));
  rotateY(random(-HALF_PI*0.1, HALF_PI*0.1));

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(-width/2, -height/2, width));

  int sub = int(random(10, 130));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float sm = r.z*0.5;
    rects.add(new PVector(r.x, r.y, sm));
    rects.add(new PVector(r.x+sm, r.y, sm));
    rects.add(new PVector(r.x+sm, r.y+sm, sm));
    rects.add(new PVector(r.x, r.y+sm, sm));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    float x = r.x;
    float y = r.y;
    float s = r.z;
    float ms = r.z*0.5;
    fill(rcol());
    //rect(x, y, s, s);
    fill(rcol());
    noStroke();
    letters.get(int(random(letters.size()))).draw(x+ms, y+ms, s);
  }
}


class Letter {
  ArrayList<PVector> vertex;
  Letter(RShape shape) {
    vertex = new ArrayList<PVector>();
    RPoint[] points = shape.getPoints();
    beginShape();
    for (int i = 0; i < points.length; i++) {
      RPoint p = points[i];
      vertex.add(new PVector(p.x, p.y));
    }

    PVector center = new PVector();
    for (int i = 0; i < points.length; i++) {
      center.add(vertex.get(i));
    }
    center.div(vertex.size());

    for (int i = 0; i < vertex.size(); i++) {
      vertex.get(i).sub(center);
    }
  }

  void draw(float x, float y, float s) {
    float sca = s/200;

    int c1 = rcol();
    while(c1 != back) c1 = rcol();
    int c2 = rcol();
    while (c1 == c2 || c2 == back) c2 = rcol();

    fill(c1);
    beginShape();
    for (int i = 0; i < vertex.size(); i++) {
      PVector v = vertex.get(i);
      vertex(x+v.x*sca, y+v.y*sca, 0);
    }
    endShape(CLOSE);

    for (int i = 0; i < vertex.size(); i++) {
      PVector v1 = vertex.get(i);
      PVector v2 = vertex.get((i+1)%vertex.size());
      beginShape();
      fill(c2);
      vertex(x+v1.x*sca, y+v1.y*sca, s);
      vertex(x+v2.x*sca, y+v2.y*sca, s);
      fill(c1);
      vertex(x+v2.x*sca, y+v2.y*sca, 0);
      vertex(x+v1.x*sca, y+v1.y*sca, 0);
      endShape(CLOSE);
    }

    fill(c2);
    beginShape();
    for (int i = 0; i < vertex.size(); i++) {
      PVector v = vertex.get(i);
      vertex(x+v.x*sca, y+v.y*sca, s);
    }
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#F8E75D, #1E4897};
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