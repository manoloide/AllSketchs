int seed = int(random(999999));
float time;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  noiseDetail(1);

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

  time = millis()*0.001;

  background(20);
  randomSeed(seed);

  ArrayList<Form> forms = new ArrayList<Form>();
  Form f = new Form();
  f.addPoint(new PVector(0, 0));
  f.addPoint(new PVector(width, 0));
  f.addPoint(new PVector(width, height));
  f.addPoint(new PVector(0, height));
  forms.add(f);

  int sub1 = int(random(10));
  for (int i = 0; i < sub1; i++) {
    int ind = int(random(forms.size()*random(0.5)));
    forms.addAll(forms.get(ind).subRect());
    forms.remove(ind);
  }

  int sub2 = int(random(random(200)));
  for (int i = 0; i < sub2; i++) {
    int ind = int(random(forms.size()*random(0.5)));
    forms.addAll(forms.get(ind).sub());
    forms.remove(ind);
  }


  stroke(80, 5);
  for (int i = 0; i < forms.size(); i++) {
    f = forms.get(i); 
    f.show();
  }
}

class Form {
  ArrayList<PVector> points;
  PVector center;
  Form() {
    points = new ArrayList<PVector>();
  }
  void show() {
    beginShape();
    fill(rcol());
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    beginShape();
    fill(rcol());
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      float ang = (atan2(p.y-center.y, p.x-center.x)+TWO_PI)%TWO_PI;
      float val = map(cos(ang*10+time*2), -1, 1, 0, 60);
      fill(0, val);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  void calculateCenter() {
    center = new PVector();
    for (int i = 0; i < points.size(); i++) {
      center.add(points.get(i));
    }
    center.div(points.size());
  }

  void addPoint(PVector p) {
    points.add(p);
    calculateCenter();
  }
  void setPoints(ArrayList<PVector> np) {
    points = new ArrayList<PVector>();
    for (int i = 0; i < np.size(); i++) {
      points.add(np.get(i).copy());
    }

    calculateCenter();
  }

  PVector randCenter() {
    float ind = random(points.size());
    float mix = ind%1;
    int i1 = int(ind);
    int i2 = (i1+1)%points.size();
    float nx = noise(i1, i2, time*random(2));
    float ny = noise(i2, i1, time*random(2));
    PVector p1 = points.get(i1);
    PVector p2 = points.get(i2); 
    float m1 = nx*random(0.5, 1);
    float m2 = ny*random(0.5, 1);
    p1 = new PVector(lerp(center.x, p1.x, m1), lerp(center.y, p1.y, m1));
    p2 = new PVector(lerp(center.x, p2.x, m2), lerp(center.y, p2.y, m2));
    return new PVector(lerp(p1.x, p2.x, mix), lerp(p1.y, p2.y, mix));
  }

  ArrayList<Form> sub() {
    ArrayList<Form> aux = new ArrayList<Form>();
    PVector np = randCenter();

    for (int i = 0; i < points.size(); i++) {
      Form f = new Form();
      f.addPoint(np);
      f.addPoint(points.get(i));
      f.addPoint(points.get((i+1)%points.size()));
      aux.add(f);
    }

    return aux;
  }

  ArrayList<Form> subRect() {
    ArrayList<Form> aux = new ArrayList<Form>();
    PVector np = randCenter();

    ArrayList<PVector> auxPoints = new ArrayList<PVector>();
    for (int i = 0; i < points.size(); i++) {
      PVector p1 = points.get(i); 
      PVector p2 = points.get((i+1)%points.size()); 

      float mix = random(0.4, 0.6);

      auxPoints.add(p1);
      auxPoints.add(new PVector(lerp(p1.x, p2.x, mix), lerp(p1.y, p2.y, mix)));
    }

    for (int i = 0; i < auxPoints.size(); i+=2) {
      Form f = new Form();
      f.addPoint(np);
      f.addPoint(auxPoints.get((i-1+auxPoints.size())%auxPoints.size()));
      f.addPoint(auxPoints.get(i));
      f.addPoint(auxPoints.get((i+1)%auxPoints.size()));
      aux.add(f);
    }

    return aux;
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#121435, #FAF9F0, #EDEBCA, #FF5722};
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