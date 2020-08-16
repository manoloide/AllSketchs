int seed = int(random(999999));

void setup() {
  size(1080, 1920, P3D);
  smooth(4);
  //pixelDensity(2);

  generate();
}

float des = 0;
float vel = 0;

void draw() {
  
  background(0);
  
  updateCamera();
  generate();
}

void updateCamera() {
  if (keyPressed) {
    if (keyCode == UP) {
      vel += 6;
    } else if (keyCode == DOWN) {
      vel -= 6;
    }
  }

  vel *= 0.9;
  vel = constrain(vel, -60, 60);

  des += vel;
  /*
  if (des > -height*0.4) vel *= -1;
  if (des < height*3.4) vel *= -1;
  */

  translate(0, des);
}

void keyPressed() {
  if (key == 's') saveImage(); 
  else if (key == ' ') seed = int(random(999999));
  ;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}



void generate() {

  //background(255);//rcol());
  randomSeed(seed);
  
  noStroke();
  
  int cc = 100;
  float ss = (height*4)/cc;
  for(int i = 0; i < cc; i++){
     fill(getColor(map(i, 0, cc, 0, colors.length)));
     rect(0, ss*i, width, ss);
  }
  
  translate(0, 0, 1);

  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height*4);
    float s = random(height)*random(1)*random(1);
    pushMatrix();
    translate(0, 0, random(400));
    fill(rcol());
    ellipse(x, y, s, s);
    popMatrix();
  }
}

float getAreaTri(PVector p1, PVector p2, PVector p3) {
  float d1 = dist(p1.x, p1.y, p2.x, p2.y);
  float d2 = dist(p2.x, p2.y, p3.x, p3.y);
  float d3 = dist(p3.x, p3.y, p1.x, p1.y);
  return sqrt((d1+d2+d3)*(-d1+d2+d3)*(d1-d2+d3)*(d1+d2-d3))/4;
}

PVector randInTri(PVector p1, PVector p2, PVector p3) {
  float r1 = random(1); 
  float r2 = random(1); 
  float s1 = sqrt(r1); 
  float x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1; 
  float y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1; 
  return new PVector(x, y);
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#1371B8, #E00A1C, #F9C114, #096532};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
