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
  else generate();
}

void generate() {
  background(rcol());

  seed = int(random(9999999));
  randomSeed(seed);

  ArrayList<PVector> vertex = new ArrayList<PVector>();
  vertex.add(new PVector(0, 0));
  vertex.add(new PVector(width, 0));
  vertex.add(new PVector(width, height));
  vertex.add(new PVector(0, height));

  ArrayList<Form> forms = new ArrayList<Form>();
  forms.add(new Form(vertex));

  for (int i = 0; i < 1000; i++) {
    Form f = forms.get(int(random(forms.size())));
    forms.add(f.sub());
  }


  for (int i = 0; i < forms.size(); i++) {
    forms.get(i).show();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

class Form {
  ArrayList<PVector> vertex;
  Form(ArrayList<PVector> vertex) {
    this.vertex = vertex;
  }
  PVector getCenter() {
    PVector p = new PVector();
    for (int i = 0; i < vertex.size(); i++) {
      p.add(vertex.get(i));
    }
    p.div(vertex.size());
    return p;
  }
  float getSize() {
    PVector cen = getCenter();
    float s = 0;
    for (int i = 0; i < vertex.size(); i++) {
      s += dist(vertex.get(i).x, vertex.get(i).y, cen.x, cen.y);
    }
    s /= vertex.size()*0.5;
    return s;
  }
  void show() {

    int sel = int(random(vertex.size())); 
    noStroke();
    fill(0, 16);
    beginShape();
    float s = getSize();
    for (int i = 0; i < vertex.size(); i++) {
      PVector p = vertex.get(i);
      if (i == sel) {
        PVector cen = getCenter();
        float dd = random(s)*random(0.1)*random(1);
        float ang = atan2(p.y-cen.y, p.x-cen.x);
        vertex(p.x+cos(ang)*dd, p.y+sin(ang)*dd);
      } else {
        vertex(p.x, p.y);
      }
    }
    endShape(CLOSE);
    int col = getColor(random(colors.length));
    stroke(0, 220);
    beginShape();
    for (int i = 0; i < vertex.size(); i++) {
      PVector p = vertex.get(i);
      fill(col);
      if (i == sel) fill(lerpColor(col, color(0), 0.08));
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }
  Form sub() {
    ArrayList<PVector> v1 = new ArrayList<PVector>();
    ArrayList<PVector> v2 = new ArrayList<PVector>();
    boolean one = random(1) < 0.5;
    if (one) {
      float nx1 = lerp(vertex.get(0).x, vertex.get(1).x, random(0.1, 0.9));
      float ny1 = lerp(vertex.get(0).y, vertex.get(1).y, random(0.1, 0.9));
      float nx2 = lerp(vertex.get(2).x, vertex.get(3).x, random(0.1, 0.9));
      float ny2 = lerp(vertex.get(2).y, vertex.get(3).y, random(0.1, 0.9));
      v1.add(vertex.get(0));
      v1.add(new PVector(nx1, ny1));
      v1.add(new PVector(nx2, ny2));
      v1.add(vertex.get(3));
      v2.add(vertex.get(1));
      v2.add(new PVector(nx1, ny1));
      v2.add(new PVector(nx2, ny2));
      v2.add(vertex.get(2));
    } else {
      float nx1 = lerp(vertex.get(1).x, vertex.get(2).x, random(0.1, 0.9));
      float ny1 = lerp(vertex.get(1).y, vertex.get(2).y, random(0.1, 0.9));
      float nx2 = lerp(vertex.get(3).x, vertex.get(0).x, random(0.1, 0.9));
      float ny2 = lerp(vertex.get(3).y, vertex.get(0).y, random(0.1, 0.9));
      v1.add(vertex.get(1));
      v1.add(new PVector(nx1, ny1));
      v1.add(new PVector(nx2, ny2));
      v1.add(vertex.get(0));
      v2.add(vertex.get(2));
      v2.add(new PVector(nx1, ny1));
      v2.add(new PVector(nx2, ny2));
      v2.add(vertex.get(3));
    }
    Form f = new Form(v1);
    vertex = v2;
    return f;
  }
}

PVector linesIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float dx1 = x2-x1;
  float dy1 = y2-y1;
  float dx2 = x4-x3;
  float dy2 = y4-y3;
  float v1 = dx1*y1-dy1*x1;
  float v2 = dx2*y3-dy2*x3;
  if ((((dx1*y3-dy1*x3)<v1)^((dx1*y4-dy1*x4) < v1)) &&
    (((dx2*y1-dy2*x1)<v2)^((dx2*y2-dy2*x2) < v2 ))) {
    float det = 1./((dx1*dy2)-(dy1*dx2));
    float ix = -((dx1*v2)-(v1*dx2))*det;
    float iy = -((dy1*v2)-(v1*dy2))*det;
    return new PVector(ix, iy);
  }
  return null;
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#f2f2e8, #ffe41c, #ef3434, #ed0076, #3f9afc};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}