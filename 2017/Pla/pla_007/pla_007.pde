int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  newPallet();
  background(rcol());



  seed = int(random(999999));
  background(0);


  float cx = width*0.5; 
  float cy = height*0.5;
  float ss = width*1.41;
  float ang = random(TWO_PI);
  float dd = random(0.2);
  float redux = random(0.7, 0.96);

  int sub = int(random(8, 100));

  noStroke();
  float da = random(-0.4, 0.4);
  float mda = random(0.9, 1.1);
  for (int i = 0; i < sub; i++) {
    float dx = cos(ang)*dd;
    float dy = sin(ang)*dd;
    float c1 = random(colors.length*3);
    float c2 = random(colors.length*3);
    float c3 = random(colors.length);
    poly(cx, cy, ss, dx, dy, int(random(80, 220)), c1, c2, c3, random(0.5, 0.8));

    cx += dx*ss*0.5;
    cy += dy*ss*0.5;

    ss *= redux;
    da *= mda;
    ang += da;
  }
}

void poly(float x, float y, float s, float dx, float dy, int res, float c1, float c2, float c3, float amp) {
  float r = s*0.5; 
  PVector cen = new PVector(x+dx*r, y+dy*r); 
  float da = TWO_PI/res; 
  PVector ant, act, nex; 
  for (int i = 0; i < res; i++) {
    ant = new PVector(x+cos(da*i)*r, y+sin(da*i)*r); 
    act = new PVector(x+cos(da*i+da*amp)*r, y+sin(da*i+da*amp)*r); 
    nex = new PVector(x+cos(da*i+da)*r, y+sin(da*i+da)*r); 
    float col1 = lerp(c1, c2, cos(map(i, 0, res, -PI, PI))*0.5+0.5); 
    float col2 = lerp(c1, c2, cos(map(i+1, 0, res, -PI, PI))*0.5+0.5); 
    beginShape(); 
    fill(getColor(col1)); 
    vertex(ant.x, ant.y); 
    fill(getColor(col2));
    vertex(act.x, act.y); 
    fill(getColor(c3)); 
    vertex(cen.x, cen.y); 
    endShape();

    beginShape(); 
    fill(0, 0); 
    vertex(nex.x, nex.y); 
    vertex(act.x, act.y); 
    fill(0); 
    vertex(cen.x, cen.y); 
    endShape();
  }
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
//int colors[] = {#EFF2EF, #9BCDD5, #65C0CB, #308AA5, #308AA5, #85A33C, #F4E300, #E8DBD1, #CE5367, #202219}; 
//int colors[] = {#181A99, #5D93CC, #84ACD6, #454593, #E05328, #E28976};
int original[] = {#48272A, #0D8DBA, #6DC6D2, #4F3541, #A43409, #BA622A};
int colors[];

void newPallet() {
  colors = new int[original.length]; 
  colorMode(HSB, 360, 100, 100);
  float mod = random(360);
  for (int i = 0; i < original.length; i++) {
    colors[i] = color((hue(original[i])+mod)%360, saturation(original[i]), brightness(original[i]));
  }
  colorMode(RGB, 256, 256, 256);
}

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}