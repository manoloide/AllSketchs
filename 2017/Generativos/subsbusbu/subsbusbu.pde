int seed = int(random(999999));

void setup() {
  size(720, 720, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(#0217B2);
  seed = int(random(999999));

  ArrayList<Form> forms = new ArrayList<Form>();

  int div = 64; 
  float ss = width*1./div;
  fill(255, 20);
  noStroke();
  for (int j = 0; j <= div; j++) {
    for (int i = 0; i <= div; i++) {
      romb(i*ss, j*ss, 4);
    }
  }

  translate(width/2, height/2);
  float diag = dist(0, 0, width/2, height/2);
  float dd = sqrt(diag*diag+diag*diag);
  ArrayList<PVector> ps = new ArrayList<PVector>();
  ps.add(new PVector(cos(PI*0.0)*dd, sin(PI*0.0)*dd));
  ps.add(new PVector(cos(PI*0.5)*dd, sin(PI*0.5)*dd));
  ps.add(new PVector(cos(PI*1.0)*dd, sin(PI*1.0)*dd));
  ps.add(new PVector(cos(PI*1.5)*dd, sin(PI*1.5)*dd));

  forms.add(new Form(ps));

  int sub = int(random(3000)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(forms.size()*random(1)));
    forms.addAll(forms.get(ind).sub());
    forms.remove(ind);
  }

  for (int i = 0; i < forms.size(); i++) {
    forms.get(i).show();
  }
}

void romb(float x, float y, float s) {
  float r = s*0.5;
  beginShape();
  vertex(x-r, y);
  vertex(x, y-r);
  vertex(x+r, y);
  vertex(x, y+r);
  endShape(CLOSE);
}

class Form {
  ArrayList<PVector> points;
  Form(ArrayList<PVector> points) {
    this.points = points;
  }

  void show() {
    stroke(255, 20);
    noFill();
    //noStroke();
    fill(getColor(random(colors.length)), 80);
    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      fill(getColor(random(colors.length)));
      vertex(p.x, p.y);
    }
    endShape(CLOSE);

    beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      fill(0, random(10));
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  ArrayList<Form> sub() {
    ArrayList<Form> aux = new ArrayList<Form>();

    if (points.size() == 4) {
      int des = int(random(2));
      ArrayList<PVector> p1 = new ArrayList<PVector>();
      p1.add(new PVector(points.get(0+des).x, points.get(0+des).y));
      p1.add(new PVector(points.get(1+des).x, points.get(1+des).y));
      p1.add(new PVector(points.get(2+des).x, points.get(2+des).y));
      aux.add(new Form(p1)); 
      ArrayList<PVector> p2 = new ArrayList<PVector>();
      p2.add(new PVector(points.get(0+des).x, points.get(0+des).y));
      p2.add(new PVector(points.get((3+des)%4).x, points.get((3+des)%4).y));
      p2.add(new PVector(points.get(2+des).x, points.get(2+des).y));
      aux.add(new Form(p2));
    }

    if (points.size() == 3) {

      int ind1 = 0; 
      int ind2 = 1;
      int ind3 = 2;

      float d1 = points.get(0).dist(points.get(1));
      float d2 = points.get(1).dist(points.get(2));
      float d3 = points.get(2).dist(points.get(1));

      if (d2 >= d1 && d1 >= d3) {
        ind3 = 1;
        ind1 = 2;
        ind2 = 0;
      } else if (d3 >= d1 && d3 >= d2) {
        ind2 = 2;
        ind3 = 0;
        ind1 = 1;
      }

      PVector cen = points.get(ind1).copy().add(points.get(ind2)).mult(0.5);
      if (random(1) < 0.0) {  
        ArrayList<PVector> p1 = new ArrayList<PVector>();
        p1.add(points.get(ind1).copy());
        p1.add(points.get(ind3).copy());
        p1.add(cen.copy());
        aux.add(new Form(p1)); 

        ArrayList<PVector> p2 = new ArrayList<PVector>();
        p2.add(points.get(ind2).copy());
        p2.add(points.get(ind3).copy());
        p2.add(cen.copy());
        aux.add(new Form(p2));
      } else {
        PVector c1 = points.get(ind1).copy().add(points.get(ind3)).mult(0.5);
        PVector c2 = points.get(ind3).copy().add(points.get(ind2)).mult(0.5);

        ArrayList<PVector> p1 = new ArrayList<PVector>();
        p1.add(c1.copy());
        p1.add(c2.copy());
        p1.add(points.get(ind2).copy());
        p1.add(cen.copy());
        aux.add(new Form(p1)); 

        ArrayList<PVector> p2 = new ArrayList<PVector>();
        p2.add(c1.copy());
        p2.add(c2.copy());
        p2.add(points.get(ind3).copy());
        aux.add(new Form(p2));

        ArrayList<PVector> p3 = new ArrayList<PVector>();
        p3.add(c1.copy());
        p3.add(cen.copy());
        p3.add(points.get(ind1).copy());
        aux.add(new Form(p3));
      }
    }
    return aux;
  }
}

int colors[] = {#FBD2DB, #FBA1B3, #F46680, #F95270, #F92C52, #000000, #0000FF, #FF0000, #FFFF00};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}