import peasy.PeasyCam;

PeasyCam cam;

int seed = int(random(999999));


int form = 0;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'c') {
    //cam.lookAt(0, 0, 0) ;
    cam.setRotations(random(360), random(360), random(360));
  }
  else {
    seed = int(random(999999));
    generate();
  }
}

class Sphere {
  float x, y, z, s;
  Sphere(float x, float y, float z, float s) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.s = s;
  }

  boolean collide(Sphere other) {
    float dist = dist(x, y, z, other.x, other.y, other.z);
    return (dist < (s+other.s)*1);
  }
}

void generate() { 
  
  float time = millis()*0.001;

  randomSeed(seed);

  background(lerpColor(color(240), rcol(), 0.2));


  ArrayList<Sphere> spheres = new ArrayList<Sphere>();
  for (int i = 0; i < 800; i++) {
    float x = width*random(-1, 1);
    float y = width*random(-1, 1);
    float z = width*random(-1, 1); 
    float s = width*random(0.8)*random(1);
    Sphere newSphere = new Sphere(x, y, z, s);
    boolean add = true;
    for (int j = 0; j < spheres.size(); j++) {
      Sphere other = spheres.get(j);
      if (newSphere.collide(other)) {
        add = false;
        break;
      }
    }
    if (add) spheres.add(newSphere);
  }

  pushMatrix();
  //translate(width*0.5, height*0.5);

  for (int i = 0; i < spheres.size(); i++) {
    Sphere s = spheres.get(i);
    float vd = cos(time*random(-0.8, 0.8)*random(1));
    float ss = s.s*vd;
    pushMatrix();
    translate(s.x, s.y, s.z);
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    noStroke();
    fill(rcol());
    if(form == 0) ellipse(0, 0, ss, ss);
    if(form == 1) sphere(ss);
    if(form == 2) box(ss);
    popMatrix();
  }

  popMatrix();
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

int colors[] = {#000000, #ffffff, #807DDB, #ED829D, #E8D84E, #F23E35, #4B13C4, #6D915F};
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