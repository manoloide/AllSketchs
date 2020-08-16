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
  else generate();
}

void mousePressed() {
  addPoint(mouseX, mouseY);
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

void addPoint(float nx, float ny) {
}

void generate() {

  seed = int(random(999999));


  ArrayList<PVector> points;
  ArrayList<Triangle> tris;

  points = new ArrayList<PVector>();

  float bb = 200;
  int cc = int(random(80, 1200*random(1))*random(1));
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(random(-bb, width+bb), random(-bb, height+bb)));
  }

  tris = Triangulate.triangulate(points);


  background(250);

  randomSeed(seed);

  noStroke();
  if (tris != null) {
    PVector p1, p2, p3, c1, c2, c3, i1, i2, i3, cen;
    float amp1 = random(1)*random(0.06, 0.1);
    float amp2 = amp1*random(0.25);//0.01;
    for (int i = 0; i < tris.size(); i++) {
      //if(random(1) < 0.2) continue;
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;
      cen = p1.copy().add(p2).add(p3).div(3);
      i1 = PVector.lerp(p1, cen, amp1);
      i2 = PVector.lerp(p2, cen, amp1);
      i3 = PVector.lerp(p3, cen, amp1);
      c1 = p1.copy().add(p2).div(2).lerp(cen, amp2);
      c2 = p2.copy().add(p3).div(2).lerp(cen, amp2);
      c3 = p3.copy().add(p1).div(2).lerp(cen, amp2);

      /*
      beginShape();
       fill(random(200, 255));
       vertex(p1.x, p1.y);
       fill(255);
       vertex(p2.x, p2.y);
       vertex(p3.x, p3.y);
       endShape();
       */

      /*
      noStroke();
       fill(0);
       beginShape();
       vertex(p1.x, p1.y);
       vertex(p2.x, p2.y);
       vertex(p3.x, p3.y);
       vertex(p1.x, p1.y);
       vertex(c3.x, c3.y);
       vertex(i3.x, i3.y);
       vertex(c2.x, c2.y);
       vertex(i2.x, i2.y);
       vertex(c1.x, c1.y);
       vertex(i1.x, i1.y);
       vertex(c3.x, c3.y);
       vertex(p1.x, p1.y);
       vertex(c3.x, c3.y);
       endShape(CLOSE);
       */

      float d1 = dist(p1.x, p1.y, p2.x, p2.y);
      float d2 = dist(p2.x, p2.y, p3.x, p3.y);
      float d3 = dist(p3.x, p3.y, p1.x, p1.y);
      float area = sqrt((d1+d2+d3)*(-d1+d2+d3)*(d1-d2+d3)*(d1+d2-d3))/4;

      float r1, r2, s1, x, y;
      stroke(rcol(), 90);
      for (int j = 0; j < area*1.1; j++) {
        r1 = random(1)*random(1);
        r2 = random(1);
        s1 = sqrt(r1);
        x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1;
        y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1;
        point(x, y);
      }
      
      /*
      ArrayList<PVector> aux = new ArrayList<PVector>();
      aux.add(p1);
      aux.add(p2);
      aux.add(p3);
      for (int j = 0; j < 2; j++) {
        aux.add(randInTri(p1, p2, p3));
      }

      ArrayList<Triangle> tris2 = Triangulate.triangulate(aux);
      noFill();
      stroke(rcol());
      for (int j = 1; j < tris2.size(); j++) {
        Triangle t2 = tris2.get(j); 
        triangle(t2.p1.x, t2.p1.y, t2.p2.x, t2.p2.y, t2.p3.x, t2.p3.y);
      }
      */
    }
  }
}

PVector randInTri(PVector p1, PVector p2, PVector p3) {
  float r1 = random(1); 
  float r2 = random(1); 
  float s1 = sqrt(r1); 
  float x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1; 
  float y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1; 
  return new PVector(x, y);
}


int colors[] = {#FF3E6D, #2C50FE, #F9FF60, #D036E9, #23778A}; 
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}