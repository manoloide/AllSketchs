import peasy.PeasyCam;


PeasyCam cam;

int seed = int(random(999999));

float size = 900;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  cam = new PeasyCam(this, 400);
  //saveImage();
  //exit();
}

void draw() {

  background(0);

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  //translate(width*0.5, height*0.5, 0);
  rotateX(random(TAU)+time*random(-0.01, 0.01));
  rotateY(random(TAU)+time*random(-0.01, 0.01));
  rotateZ(random(TAU)+time*random(-0.01, 0.01));
  
  
  ambientLight(80, 80, 80);
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  directionalLight(204, 204, 204, -dirX, -dirY, -1); 
  directionalLight(204, 204, 204, +dirX, +dirY, -1); 
  lightSpecular(1, 1, 1);
  directionalLight(0.8, 0.8, 0.8, 0, 0, -1);


  for (int i = 0; i < birds.size(); i++) {
    birds.get(i).update();
    birds.get(i).show();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

ArrayList<Birds> birds;
float det1, det2, des1, des2;
void generate() {
  float s = size;
  det1 = random(0.001);
  det2 = random(0.001);
  des1 = random(1000);
  des2 = random(1000);
  birds = new ArrayList<Birds> ();
  for (int i = 0; i < 2200; i++) {
    birds.add(new Birds(random(-s, s), random(-s, s), random(-s, s), random(4, 18)));
  }
}

class Birds {
  float x, y, z, s;
  Birds(float x, float y, float z, float s) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.s = s;
  }
  void update() {
    float a1 = noise(des1+x*det1, des1+y*det1, des1+z*det1)*TAU;
    float a2 = noise(des2+x*det2, des2+y*det2, des2+z*det2)*TAU; 

    float vel = 2;

    x += cos(a1)*sin(a2)*vel;
    y += sin(a1)*sin(a2)*vel;
    z += cos(a2)*vel;

    x = (x+size*3)%(size*2)-size;
    y = (y+size*3)%(size*2)-size;
    z = (z+size*3)%(size*2)-size;
  }
  void show() {
    float tt = millis()*random(0.02);
    float ang = map(cos(tt), -1, 1, PI*0.8, PI*1.2);
    fill(rcol());
    pushMatrix();
    translate(x, y, z);
    beginShape();
    vertex(0, 0, -s*0.5);
    vertex(0, 0, +s*0.5);
    vertex(cos(ang)*s, sin(ang)*s, 0);
    endShape(CLOSE);
    beginShape();
    vertex(0, 0, -s*0.5);
    vertex(0, 0, +s*0.5);
    vertex(-cos(ang)*s, sin(ang)*s, 0);
    endShape(CLOSE);
    popMatrix();
  }
}

float n(float x, float y, float z, float det, float des) {
  return noise(des+x*det, des+y*det, des+z*det);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#A8B4CE, #5C6697, #352B4D, #ED5A67, #F389A0};
int colors[] = {#17E5DB, #5442AE, #A64AC9, #FD6519, #FDCF00, #FFFFFF};
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
