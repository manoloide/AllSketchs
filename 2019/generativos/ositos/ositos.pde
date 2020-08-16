int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(240);
  noStroke();
  for (int i = 0; i < 9; i++) {
    float x = random(width+40);
    float y = random(height+40);
    float s = random(width*1.6)*random(0.5, 1);

    x -= x%40;
    y -= y%40;

    fill(rcol());
    ellipse(x, y, s, s);
    
    arc2(x, y, s*1.0, s*1.4, 0, TAU, color(255), 20, 0);
  }

  noStroke();
  for (int i = 0; i < 500; i++) {
    float x = random(width+40);
    float y = random(height+40);

    x -= x%40;
    y -= y%40;

    float s = width*random(0.04, 0.05)*0.2*(int(random(0, 3))+0.5)*random(0.8, 1)*0.4;
    fill(rcol());
    ellipse(x, y, s, s);
    fill(rcol());
    ellipse(x, y, s*0.5, s*0.5);
    noFill();
    stroke(rcol());
    ellipse(x, y, s*0.55, s*0.55);
    noStroke();
    fill(rcol());
    ellipse(x, y, s*0.02, s*0.02);
  }


  for (int i = 0; i < 20; i++) {
    float x = random(width+40);
    float y = random(height+40);
    float s = random(width*0.4)*random(0.5, 1);

    s -= s%40;

    x -= x%40;
    y -= y%40;
    
    float rot = (random(1) < 0.5)? 0 : PI;

    fill(rcol());
    arc(x, y, s, s, 0+rot, PI+rot);
    fill(rcol());
    arc(x, y, s*0.5, s*0.5, PI+rot, TAU+rot);
    
    arc2(x, y, s*0.2, s*0.8, PI+rot, TAU+rot, rcol(), 80, 0);
    
    arc2(x, y, s*1.0, s*0.6, PI+rot, TAU+rot, rcol(), 14, 0);
    
    arc2(x, y, s*1.0, s*1.4, 0+rot, TAU+rot, color(0), 12, 0);
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.1, 2));

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#333A95, #F6C806, #F789CA, #188C61, #1E9BF3};
int colors[] = {#FFF2E1, #EBDDD0, #F1C98E, #E0B183, #C2B588, #472F18, #0F080F};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
