import peasy.PeasyCam;

ArrayList<PVector> points;
PeasyCam cam;
int seed = int(random(999999));
boolean render = true;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  cam = new PeasyCam(this, 400);
  generate();
}


void draw() {

  if (!render) background(255);

  for (int j = 0; j < points.size(); j++) {
    PVector p = points.get(j);
    pushMatrix();
    translate(p.x, p.y, p.z);
    stroke(rcol(), 60);
    float ss = map(j, 0, points.size(), 80, 300);
    for (int i = 0; i < 1000; i++) {
      float x = cos(random(TAU))*ss;
      float y = cos(random(TAU))*ss;
      float z = cos(random(TAU))*ss;
      point(x, y, z);
    }
    popMatrix();
  }
}

void keyPressed() {
  if (key == 'r') {
    render = !render;
  } else if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  seed = int(random(999999));
  
  randomSeed(seed);
  points = new ArrayList<PVector>();
  for(int i = 0; i < 5; i++){
     points.add(new PVector(random(-400, 400), random(-400, 400), random(-400, 400))); 
  }
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
