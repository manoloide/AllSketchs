int seed = int(random(999999));

void setup() {
  size(600, 600);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(getColor(random(back.length), back));

  palta(width*0.5, height*0.5, width*0.6);
}

void palta(float x, float y, float s) {
  float w = s*random(0.6, 0.8);
  float h = s;

  rectMode(CENTER);
  noFill();
  stroke(0, 200);
  rect(x, y, w, h);
  ellipse(x, y, w, h);

  float ms = random(0.22, 0.4);

  float xx = x;
  float yy = y-h*0.5+h*ms*0.5;
  float ww = w*random(0.3, 0.5);
  float hh = h*ms;
  rect(xx, yy, ww, hh);
  ellipse(xx, yy, ww, hh);
  ms = 1-ms;
  yy = y+h*0.5-h*ms*0.5;
  ww = w;
  hh = h*ms;
  rect(xx, yy, w, hh);
  ellipse(xx, yy, ww, hh);


  float cs = w*random(0.3, 0.38);
  fill(120, 80, 10);
  ellipse(x, yy, cs, cs*random(1, 1.2));
}

int back[] = {#3D8AFF, #FFD335, #FFBAE6, #FEE8FF};

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#0795D0, #019C54, #F5230D, #DF5A48, #F1BF16, #F0C016, #F4850C, #E13E33, #746891, #623E86, #00A2C6, #EBD417, #EADBC6
};
int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(float v, int colors[]) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}