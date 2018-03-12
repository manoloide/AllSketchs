int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
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
  seed = int(random(999999));

  render();
}

void render() {

  background(0);
  translate(width/2, height/2);

  float r1 = width*random(0.6, 1.4); 
  float r2 = width*random(0.0, 0.3); 
  r1 = width*1.5;
  r2 = 0;
  float s = (r1-r2)*0.5; 
  float r =  (r1+r2)*0.5;

  noFill();

  int cc = int(3+pow(random(30), random(0.5, 2))); 
  int sub = 360; 
  float da = TWO_PI/cc; 
  int dc = int(random(1, random(1, 40*random(1))));
  float d = (sub*1./cc)*int(random(0, 30));
  float amp = 1;//-((random(1) < 0.5)? 0 : random(0.9));
  //strokeWeight(1.2);
  for (int i = 0; i < cc; i++) {
    float x = cos(da*i)*r*0.5; 
    float y = sin(da*i)*r*0.5; 
    float da2 = TWO_PI/sub; 
    for (int j = 0; j < sub; j++) {
      float a = da2*j;
      stroke(getColor(map((j+i*d)%sub, 0, sub, 0, colors.length*dc)), 240);
      arc(x, y, s, s, a, a+da2*amp);
    }
  }
}

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #412A50};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}