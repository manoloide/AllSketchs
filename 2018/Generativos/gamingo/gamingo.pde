int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  
}   

void keyPressed() {
  if (key == 's') saveImage();
  if (key == ' ') {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(getColor(random(200)));
}

void aro(float x, float y, float s, float b) {
  int seg = int(s*PI*0.5);
  float da = TWO_PI/seg;
  float r = s*0.5;
  beginShape();
  for (int i = 0; i <= seg; i++) {
    float a = da*i;
    vertex(x+cos(a)*r, y+sin(a)*r);
  }
  for (int i = seg; i >= 0; i--) {
    float a = da*i;
    vertex(x+cos(a)*(r-b), y+sin(a)*(r-b));
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FFFCF7, #FDDA02, #EE78AC, #3155A3, #028B88};
//int colors[] = {#01AFD8, #009A91, #E46952, #784391, #1B2D53};
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
