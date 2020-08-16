import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  //hint(ENABLE_STROKE_PERSPECTIVE);

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  
  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);
  background(5);

  translate(width*0.5, height*0.5, -100);
  rotateX(random(-0.1, 0.1)+time*random(-1, 1));
  rotateY(random(-0.1, 0.1)+time*random(-1, 1));
  rotateZ(random(-0.1, 0.1)+time*random(-1, 1));


  ArrayList<PVector> points = new ArrayList<PVector>();

  float r = width*random(0.5, 0.7)*0.4;
  for (int i = 0; i < 8000; i++) {
    float a1 = random(PI);
    float a2 = random(PI);
    float xx = cos(a1)*cos(a2)*r;
    float yy = cos(a1)*sin(a2)*r;
    float zz = sin(a1)*r; 

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(xx, yy, zz, o.x, o.y, o.z) < 2) {
        add = false;
        break;
      }
    } 
    if (add) {
      PVector p = new PVector(xx, yy, zz);
      points.add(p);
      pushMatrix();

      //rotateVector(p);
      
      translate(xx, yy, zz);
      
      rotate(p.heading());
      //rotateX(p.
      
      stroke(255, 0, 0, 60);
      
      line(0, 0, 0, 100, 0, 0);

      int cc = int(random(10, 28));
      float da = TAU/cc;
      for (int k = 0; k < cc; k++) {
        float ang = k*da;
        float rr = 60;
        //line(cos(ang)*rr*0.8, sin(ang)*rr*0.8, cos(ang)*rr, sin(ang)*rr);
      }
      popMatrix();
    }
  }
}

void rotateVector(PVector d) {
  float rx = asin(-d.y);
  float ry = atan2(d.x, d.z);
  rotateY(ry);
  rotateX(rx);
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
