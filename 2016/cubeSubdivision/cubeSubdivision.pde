ArrayList<Cube> cubes;

void setup() {
  size(960, 960, P3D);

  cubes = new ArrayList<Cube>();
  cubes.add(new Cube(0, 0, 0, width));

  generate();
}

void draw() {
  lights();
  background(0);

  translate(width/2, height/2, -300);
  float vr = 0.1;
  rotateX(frameCount*0.03*vr);
  rotateY(frameCount*0.017*vr);
  rotateZ(frameCount*0.009*vr);

  fill(180);
  stroke(0, 20);
  for (int i = 0; i < cubes.size(); i++) {
    Cube c = cubes.get(i);
    pushMatrix();
    fill(c.col);
    translate(c.x, c.y, c.z);
    box(c.s);
    popMatrix();
  }
}

void keyPressed() {
  generate();
  /*
  if (key == 'r') generate();
   else subdivice();
   */
}

void generate() {
  cubes = new ArrayList<Cube>();
  cubes.add(new Cube(0, 0, 0, width));
  subdivice();
}

void subdivice() {
  float prob = 0.6;
  for (int i = 0; i < 500; i++) {
    int ind = int(random(cubes.size()));
    Cube c = cubes.get(ind);
    float ss = c.s*0.25;
    if (ss < 5) continue;
    if (random(1) < prob) cubes.add(new Cube(c.x-ss, c.y-ss, c.z-ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x-ss, c.y+ss, c.z-ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x-ss, c.y-ss, c.z+ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x-ss, c.y+ss, c.z+ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x+ss, c.y-ss, c.z-ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x+ss, c.y+ss, c.z-ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x+ss, c.y-ss, c.z+ss, c.s*0.5));
    if (random(1) < prob) cubes.add(new Cube(c.x+ss, c.y+ss, c.z+ss, c.s*0.5));
    cubes.remove(ind);
  }
}

class Cube {
  color col;
  float x, y, z, s;
  Cube(float x, float y, float z, float s) {
    this.x = x; 
    this.y = y; 
    this.z = z;
    this.s = s;
    col = lerpColor(color(255, 0, 0), color(0, 0, 255), random(1));
  }
}