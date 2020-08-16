import peasy.PeasyCam;

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

  stroke(0, 60);
  for (int i = 0; i < 100000; i++) {
    float x = random(200)*random(1)-100;
    float y = random(200)*random(1)-100;
    float z = random(200)*random(1)-100;
    x -= (x%40)*0.5;
    y -= (y%40)*0.5;
    z -= (z%40)*0.5;
    point(x, y, z);
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
