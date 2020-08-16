import peasy.PeasyCam;

int seed = int(random(9999999));
Ligths ligths;
Ligth l1, l2, l3;
PeasyCam cam;

void setup() {
  size(960, 540, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
  generate();
}

void draw() {

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);
  background(0);

  noStroke();
  float r = width*random(0.4);
  float a1 = noise(time*random(0.1))*TAU*2;
  float a2 = noise(time*random(0.1))*TAU*2;
  l1.position = new PVector(cos(a1)*cos(a2)*r, cos(a1)*sin(a2)*r, sin(a1)*r);
  r = width*random(0.4);
  a1 = noise(time*random(0.1))*TAU*2;
  a2 = noise(time*random(0.1))*TAU*2;
  l2.position = new PVector(cos(a1)*cos(a2)*r, cos(a1)*sin(a2)*r, sin(a1)*r);
  r = width*random(0.4);
  a1 = noise(time*random(0.1))*TAU*2;
  a2 = noise(time*random(0.1))*TAU*2;
  l3.position = new PVector(cos(a1)*cos(a2)*r, cos(a1)*sin(a2)*r, sin(a1)*r);

  l1.show();
  l2.show();
  l3.show();

  for (int i = 0; i < 2000; i++) {
    float amp = random(10, 50);
    float x = random(-400, 400);
    float y = random(-400, 400);
    float z = random(-400, 400);
    PVector p1 = new PVector(x+random(-amp, amp), y+random(-amp, amp), z+random(-amp, amp));
    PVector p2 = new PVector(x+random(-amp, amp), y+random(-amp, amp), z+random(-amp, amp));
    PVector p3 = new PVector(x+random(-amp, amp), y+random(-amp, amp), z+random(-amp, amp));
    beginShape();
    fill(ligths.getColor(p1));
    vertex(p1.x, p1.y, p1.z);
    fill(ligths.getColor(p2));
    vertex(p2.x, p2.y, p2.z);
    fill(ligths.getColor(p3));
    vertex(p3.x, p3.y, p3.z);
    endShape(CLOSE);
  }
}

void keyPressed() {
  seed = int(random(9999999));
  generate();
}

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  ligths = new Ligths();
  l1 = new PointLigth(new PVector(), 200, color(random(255), random(255), random(255)));  
  l2 = new PointLigth(new PVector(), 180, color(random(255), random(255), random(255)));
  l3 = new PointLigth(new PVector(), 180, color(random(255), random(255), random(255)));
  ligths.add(l1);
  ligths.add(l2);
  ligths.add(l3);
}

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
