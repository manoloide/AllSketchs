import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  hint(ENABLE_STROKE_PERSPECTIVE);

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
  noiseSeed(seed);
  background(255);

  translate(width*0.5, height*0.55, -100);
  rotateX(random(-0.1, 0.1));
  rotateY(random(-0.1, 0.1));
  rotateZ(random(-0.1, 0.1));


  ArrayList<PVector> points = new ArrayList<PVector>();

  float r = width*random(0.5, 0.7)*0.7;
  for (int i = 0; i < 200; i++) {
    float a1 = random(PI);
    float a2 = random(PI);
    float xx = cos(a1)*cos(a2)*r;
    float yy = cos(a1)*sin(a2)*r;
    float zz = sin(a1)*r; 

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if(dist(xx, yy, zz, o.x, o.y, o.z) < 30){
         add = false;
         break;
      }
    } 
    if (add) {
      points.add(new PVector(xx, yy, zz));
      stroke(rcol(), 240);
      strokeWeight(4*random(0.2, 4));
      point(xx, yy, zz);

      pushMatrix();
      translate(xx, yy, zz);
      noFill();
      strokeWeight(0.8);
      ellipse(0, 0, 12, 12);
      popMatrix();
    }
  }
  strokeWeight(0.8);

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
  }


  ArrayList triangles = Triangulate.triangulate(points);


  //sphere(width*0.6);

  // draw the mesh of triangles
  stroke(0, 20);
  fill(255, 40);
  beginShape(TRIANGLES);

  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(rcol(), random(30));
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), random(30));
    vertex(t.p2.x, t.p2.y);
    fill(rcol(), random(30));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    if (random(1) < 0.9) continue;
    noStroke();
    fill(rcol(), random(20)*random(1));
    //fill(0, 20);
    vertex(t.p1.x, t.p1.y, t.p1.z*0.9);
    vertex(t.p2.x, t.p2.y, t.p2.z*0.9);
    vertex(t.p3.x, t.p3.y, t.p3.z*0.9);
  }
  endShape();


  stroke(0, 4);

  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    //fill(0, 20);
    line(t.p1.x, t.p1.y, t.p1.z, t.p1.x, t.p1.y, 0);
    line(t.p2.x, t.p2.y, t.p2.z, t.p2.x, t.p2.y, 0);
    line(t.p3.x, t.p3.y, t.p3.z, t.p3.x, t.p3.y, 0);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EFF1F4, #81C7EF, #2DC3BA, #BCEBD2, #F9F77A, #F8BDD3, #272928};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
