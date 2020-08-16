int seed = int(random(999999));
void setup() {
  size(640, 640, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
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

  hint(DISABLE_DEPTH_TEST);
  float skyMix = random(1);
  beginShape();
  fill(lerpColor(#0E2857, #016DAB, random(1)));
  vertex(0, 0);
  vertex(width, 0);
  fill(lerpColor(#24A2C9, #1DAEE2, random(1)));
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);


  float hor = height*random(0.8, 0.9);

  for (int i = 0; i < 10; i++) {
    noStroke();
    fill(255, 2);
    airplane(random(width), random(hor), height*random(0.2, 0.3), random(TAU));
  }

  noStroke();
  fill(0, 40);
  montains(hor, 80, random(0.1));
  montains(hor, 40, random(0.01));

  int cc = int(random(120));
  for (int i = 0; i < cc; i++) {
    cloud(hor, random(0.003, 0.008));
  }
  
  fill(0, 100);
  //TODO hacer montañas de fondo
  //montainsBack(hor, 120, random(0.1));

  formSky();

  noStroke();
  int suelo[] = {#205AAF, #E3CEB5, #6E9ADB, #F5BBB9, #A7E8DE};
  fill(suelo[int(random(suelo.length))]);
  rect(0, hor, width, height*0.2);

  int cols[] = {#EFB9B7, #67A5C2, #0F9A5E};
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02)*0.1;
    fill(cols[int(random(cols.length))], random(200));
    ellipse(x, y, s, s);
  }

  int cityCount = int(random(1, 4));
  for(int i = 0; i < cityCount; i++){
  city(random(width), hor);
  }

  float det = 0.01;//random(0.001);
  float des = random(10000);
  for (int i = 0; i < 1000; i++) {
    stroke(255*int(random(2)));
    float vy = random(1);
    float hh = height*(random(0.5, 0.6)-(1-vy)*0.4)*0.02;
    float xx = random(width);
    float yy = lerp(hor, height, vy);
    if (noise(des+xx*det, des+yy*det) < 0.5) {
      if(random(1) > 0.05) continue;
      tree(xx, yy, hh*16);
    } else {
      person(xx, yy, hh);
    }
  }

  flowers(height);
}

void tree(float x, float y, float s) {
  float ang = PI*random(1.48, 1.52);
  float nx = x+cos(ang)*s;
  float ny = y+sin(ang)*s;
  
  noStroke();
  fill(0);
  //ellipse(x, y, s*0.08, s*0.014);
  // line(x, y, nx, ny);
  float ss = s*0.02;
  limb(x, y, nx, ny, ss);
}

void limb(float x1, float y1, float x2, float y2, float ss){
  float r = ss*0.5;
  float a = atan2(y2-y1, x2-x1);
  beginShape();
  vertex(x1+cos(a-HALF_PI)*r, y1+sin(a-HALF_PI)*r);
  vertex(x1+cos(a+HALF_PI)*r, y1+sin(a+HALF_PI)*r);
  vertex(x2, y2);
  endShape(CLOSE);
}


void palm(float x, float y, float s) {
  float ang = PI*random(1.43, 1.57);
  float nx = x+cos(ang)*s;
  float ny = y+sin(ang)*s;
  
  noStroke();
  fill(0);
  ellipse(x, y, s*0.08, s*0.014);
  // line(x, y, nx, ny);
  float dis = dist(x, y, nx, ny);
  float ss = s*0.06;
  int col = color(0);
  noStroke();
  while (dis > 1) {
    dis = dist(x, y, nx, ny);
    x = lerp(x, nx, 0.03);
    y = lerp(y, ny, 0.03);
    pushMatrix();
    translate(x, y);
    rotate(ang);
    rect(-ss*0.5, -ss*0.1, ss, ss*0.2);
    popMatrix();
    //ellipse(x, y, ss, ss);
    col = lerpColor(col, color(#7A3134), random(1));
    ss *= 0.98;
  }
}

void person(float x, float y, float s) {
  float ang = PI*random(1.49, 1.51);
  float nx = x+cos(ang)*s;
  float ny = y+sin(ang)*s;

  noStroke();
  fill(0);
  //ellipse(x, y, s*0.1, s*0.014);
  // line(x, y, nx, ny);
  float dis = dist(x, y, nx, ny);
  float totalDis = dis;
  float ss = s*0.06;
  int col = color(0);
  int ncol = color(#7A3134);
  noStroke();
  float ampAng = random(0.05, 1.4);
  float pwr = random(1, 4);
  if (random(1) < 0.5) pwr = 1./random(1, 4);
  float ic = random(colors.length);
  float dc = random(colors.length)*random(0.001);
  while (dis > 1) {
    dis = dist(x, y, nx, ny);
    x = lerp(x, nx, 0.01);
    y = lerp(y, ny, 0.01);
    stroke(col);
    float md = pow(sin(map(dis, 0, totalDis, 0, PI)), pwr);
    float d = s*0.3*md;
    line(x, y, x+cos(ang-ampAng)*d, y+sin(ang-ampAng)*d);
    line(x, y, x+cos(ang+ampAng)*d, y+sin(ang+ampAng)*d);
    noStroke();
    fill(col);
    pushMatrix();
    translate(x, y);
    rotate(ang);
    rect(-ss*0.5, -ss*0.1, ss, ss*0.2);
    popMatrix();
    //ellipse(x, y, ss, ss);
    ic += dc;
    col = lerpColor(col, getColor(ic), 0.2);
    ss *= 0.98;
  }

  fill(getColor());
  ellipse(nx, ny, s*0.3, s*0.3);
}

void airplane(float x, float y, float s, float a) {
  float nx = x+cos(a)*s;
  float ny = y+sin(a)*s;
  line(x, y, nx, ny);
  float dis = dist(x, y, nx, ny);
  float ss = s*0.05;
  while (dis > 1) {
    dis = dist(x, y, nx, ny);
    x = lerp(x, nx, 0.03);
    y = lerp(y, ny, 0.03);
    ellipse(x, y, ss, ss);
    ss *= 0.99;
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
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
