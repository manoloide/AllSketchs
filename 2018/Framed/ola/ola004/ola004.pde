import controlP5.*;

float contrast = 1.05; //0.94
float saturatio = 1.04;//1.2
float brightnes = 1.1; //1.11
float smoothEdge = 0.0;//0.0
float additive = 0.28; //0.46
boolean postShader = false;

int seed = int(random(999999));
PShader post;

ControlP5 cp5;
boolean drawGui = false;

void setup() {
  size(1080, 1920, P2D);
  smooth(8);
  //noCursor();
  //pixelDensity(2);
  frameRate(30);

  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  cp5.begin(10, 30);
  cp5.addSlider("contrast", 0.7, 1.6).linebreak();
  cp5.addSlider("saturatio", 0.7, 1.6).linebreak();
  cp5.addSlider("brightnes", 0.7, 1.6).linebreak();
  cp5.addSlider("smoothEdge", 0.0, 1).linebreak();
  cp5.addSlider("additive", 0.0, 2.0).linebreak();
  cp5.addToggle("postShader").linebreak();

  post = loadShader("post.glsl");

  generate();
}

void draw() {

  drawWaves();

  if (drawGui) drawGUI();
}


void drawGUI() {
  cp5.draw();

  fill(255);
  text(frameRate, width-120, 20);
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (keyCode == RIGHT) {
    seed--;
  } else if (keyCode == LEFT) {
    seed++;
  } else if (key == ' ') {
    generate();
  } else if (key=='h') drawGui = !drawGui;
}

void generate() {
  generateColors();
}

void drawWaves() {

  randomSeed(seed);
  noiseSeed(seed);
  noiseDetail(int(random(1, 8)));

  background(rcol());
  float time = millis()*0.00001;
  if (random(1) < 0.1) time *= random(100);
  if (random(1) < 0.001) time *= random(800)*random(1);
  float ani = time*random(0.04, 0.05);



  int cc = int(random(2, 22));
  float ts = height;
  float ss = ts*1./cc;
  cc += 1;

  float amplitud = random(3*random(0.25, 1));

  float res = random(1);

  float colorDivisor = random(1);

  int cor = 0;
  float det = random(0.01);
  ArrayList[] mountains = new ArrayList[cc+cor];
  for (int i = -cor/2; i < cc+cor/2; i++) {

    ArrayList<PVector> mountain = new ArrayList<PVector>();
    float lx = 0;
    float ly = (i)*ss;
    det *= random(0.99, 1.01);
    int iter = 0;
    while (iter < width*res) {//lx < width-bb) {
      mountain.add(new PVector(lx, ly));
      float ang = map(noise(lx*det, ly*det, ani), 0, 1, PI*1.5, PI*2.5);
      lx += cos(ang)*4;
      ly += sin(ang)*4;
      iter++;
    }

    PVector fp = mountain.get(0);
    PVector lp = mountain.get(mountain.size()-1);
    float dis = fp.dist(lp);
    float ang = atan2(lp.y-fp.y, lp.x-fp.x);
    for (int j = 0; j < mountain.size(); j++) {
      PVector ap = mountain.get(j).copy();
      ap.sub(fp);
      ap.rotate(-ang);
      ap.y *= amplitud;
      ap.mult(width/dis);
      ap.add(fp);
      mountain.get(j).set(ap);
    }

    mountains[i+cor/2] = mountain;
  }

  float alpMin = 0;//random(random(80, 160), 220)*random(1);
  float alpMax = 20;//random(random(80, 160), 220);

  for (int i = 0; i < mountains.length-1; i++) {
    ArrayList<PVector> mountain1 = mountains[i];
    ArrayList<PVector> mountain2 = mountains[i+1];

    float ic = random(colors.length)+time*random(2);
    float vc = random(1)*random(200)*random(0.5, 1)*random(1)*random(1)*pow(random(1), 9);
    vc *= colorDivisor;
    if (random(1) < 0.1) vc *= random(10);
    if (random(1) < 0.1) vc *= random(1000);

    stroke(0, 180);
    noStroke();
    beginShape(QUADS);
    for (int j = 0; j < mountain1.size()-1; j++) {
      PVector p1 = mountain1.get(j);
      PVector p2 = mountain1.get(j+1);
      PVector p3 = mountain2.get(j+1);
      PVector p4 = mountain2.get(j);
      float alp = random(alpMin, alpMax);
      int col1 = getColor(ic+vc*j);
      int col2 = getColor(ic+vc*j);
      fill(col1);
      vertex(p1.x, p1.y);
      fill(col1, alp);
      vertex(p2.x, p2.y);
      fill(col2, alp);
      vertex(p3.x, p3.y);
      fill(col2);
      vertex(p4.x, p4.y);
    }
    endShape();
  }

  post.set("contrast", contrast);
  post.set("saturation", saturatio);
  post.set("brightness", brightnes);
  post.set("smoothEdge", smoothEdge);
  post.set("additive", additive);
  filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generateColors() {
  colors = new int[original.length];
  for (int i = 0; i < original.length; i++) {
    colors[i] = original[i];
  }
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#ffffff, #000000, #ffffff, #ffffff, #000000, #000000};
int original[] = {#00171A, #003B4F, #FE766E, #FF4142, #FD072C, #FD7A42, #FEA1B1, #E70976, #001D37};
int colors[];
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
