import org.processing.wiki.triangulate.*; 

int seed = int(random(999999));
Tipitos tipitos;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  tipitos = new Tipitos();
  generate();
}

void draw() {
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

  seed = int(random(999999));


  ArrayList<PVector> points;
  ArrayList<Triangle> tris;

  points = new ArrayList<PVector>();

  float bb = 200;
  int cc = int(random(280, 2200*random(1))*random(1));
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(random(-bb, width+bb), random(40, random(0.1, 1.4)*random(0.1, 1)*height+bb)));
  }

  tris = Triangulate.triangulate(points);


  background(0);

  randomSeed(seed);

  noStroke();
  if (tris != null) {
    PVector p1, p2, p3;
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;


      noFill();
      stroke(255, 10);
      fill(rcol());
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      endShape();

      float d1 = dist(p1.x, p1.y, p2.x, p2.y);
      float d2 = dist(p2.x, p2.y, p3.x, p3.y);
      float d3 = dist(p3.x, p3.y, p1.x, p1.y);
      float area = sqrt((d1+d2+d3)*(-d1+d2+d3)*(d1-d2+d3)*(d1+d2-d3))/4;

      float r1, r2, s1, x, y;
      for (int j = 0; j < area*2.1; j++) {
        r1 = random(0.1, 1)*random(1)*random(0.5, 1);
        float dd = int(random(0, 2));
        r2 = random(dd*0.8, 1)*random(0.4, 1);
        stroke(int(r1*2)*255, 40);
        r1 = random(1);
        s1 = sqrt(r1);
        x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1;
        y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1;
        point(x, y);
      }


      float det = random(0.01);
      float des = random(1000);
      int col = rcol();
      noFill();
      stroke(255, 10);
      beginShape();
      fill(col, noise(des+p1.x*det, des+p1.x*det)*255);
      vertex(p1.x, p1.y);
      fill(col, noise(des+p2.x*det, des+p2.x*det)*255);
      vertex(p2.x, p2.y);
      fill(col, noise(des+p3.x*det, des+p3.x*det)*255);
      vertex(p3.x, p3.y);
      endShape();

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

  float x, y, sca, ss, dv;
  PImage img;
  int forestCol = rcol();
  float det = random(0.01);
  float des = random(100);

  for (int i = 0; i < 200; i++) {
    x = random(width);
    y = 44+random(height)*random(0.4, 1)*random(1);
    sca = pow(map(y, 0, height, 0.1, 1), 1.1)*0.22;
    ss = random(20)*sca*12;
    dv = map(y, 0, height, 0, 1);
    rcol();
    noStroke();//
    fill(rcol(), random(140, 255));
    triangle(x-ss*0.1, y, x+ss*random(-0.08, 0.08), y-ss, x+ss*0.1, y);
  }

  float det2 = random(0.06);
  float des2 = random(10000);
  for (int i = 0; i < 80000; i++) {
    x = random(width);
    y = random(height);
    float dc = noise(des2+x*det2, des2+y*det2)*colors.length*2;
    y = 80+y*random(0.4, 1)*random(1);
    if (noise(det+x*det, det+y*det) < 0.6) continue;
    sca = pow(map(y, 0, height, 0.1, 1), 1.1)*0.22;
    ss = random(20)*sca*random(12);
    dv = map(y, 0, height, 0, 1);
    noStroke();
    //fill(lerpColor(rcol(), color(40), pow(1-dv, 2)*0.2), random(240, 255));
    fill(lerpColor(getColor(), getColor(dc), pow(1-dv, 2)*0.2));
    triangle(x-ss*0.1, y, x+ss*random(-0.08, 0.08), y-ss, x+ss*0.1, y);
  }


  for (int i = 0; i < random(8); i++) {
    x = random(width);
    y = 50+random(height)*random(0.4, 1)*random(0.2, 1);
    sca = pow(map(y, 0, height, 0.1, 1), 1.1)*0.22;
    ss = random(12, 20)*sca*8;
    dv = map(y, 0, height, 0, 1);
    rcol();
    noStroke();

    fill(lerpColor(rcol(), color(0), pow(max(0.2, 0.4-dv*0.4), 2)), (1+dv*0.2)*255);
    rect(x-ss, y-ss, ss*2, ss);

    fill(rcol());
    beginShape();
    vertex(x-ss*1.1, y-ss*0.9);
    vertex(x-ss*1.1, y-ss*1);
    vertex(x, y-ss*1.2);
    vertex(x+ss*1.1, y-ss*1);
    vertex(x+ss*1.1, y-ss*0.9);
    endShape(CLOSE);

    fill(rcol());
    rect(x-ss*0.15, y-ss*0.6, ss*0.3, ss*0.6);
    fill(rcol());
    rect(x-ss*0.25, y-ss*0.2, ss*0.1, ss*0.2);
    rect(x+ss*0.15, y-ss*0.2, ss*0.1, ss*0.2);
  }

  imageMode(CENTER);
  for (int i = 0; i < 18; i++) {
    x = random(width);
    y = random(40, height)*random(0.4, 1);
    sca = pow(map(y, 0, height, 0.1, 1), 1.2)*0.22;
    img = tipitos.getRnd();
    tint(rcol());
    image(img, x, y, img.width*sca, img.height*sca);
  }

  if (tris != null) {
    PVector p1, p2, p3;
    float pro = random(0.3);
    for (int i = 0; i < tris.size()*pro; i++) {
      Triangle t = tris.get(int(random(tris.size())));
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;

      blendMode(BLEND);
      noFill();
      stroke(255, 10);
      fill(rcol());
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      endShape();

      blendMode(ADD);
      beginShape();
      fill(rcol(), random(230, 255));
      vertex(p1.x, p1.y);
      fill(rcol(), random(230, 255));
      vertex(p2.x, p2.y);
      fill(rcol(), random(230, 255));
      vertex(p3.x, p3.y);
      endShape();
    }
    blendMode(BLEND);
    float det3 = random(0.01);
    float des3 = random(1000);
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;
      PVector cen = p1.copy().add(p2).add(p3).div(3);
      float alp = 255*constrain(noise(des3+cen.x*des3, des3+cen.y*des3)-0.1, 0, 0.6);
      blendMode(BLEND);
      noFill();
      stroke(255, 10);
      fill(255, alp);
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      endShape();
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


int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}