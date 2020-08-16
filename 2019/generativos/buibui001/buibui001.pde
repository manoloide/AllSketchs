int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  //hint(DISABLE_DEPTH_TEST);
  ambientLight(200, 190, 180);
  // directionalLight(255, 255, 255, 0, -1, -1);
  directionalLight(50, 60, 70, 0.3, 0, -1);

  float fov = PI/random(1.3, 1.4);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  float mr = random(0.3);
  translate(width*0.5, height*0.5, 380);
  rotateX(random(-mr, mr));
  rotateY(random(-mr, mr));
  rotateZ(random(TAU));

  scale(1.3);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width*2.8, height*2.8));
  for (int i = 0; i < 800; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.remove(ind);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  strokeWeight(0.8);

  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 50);
    //noStroke();
    //noFill();
    pushMatrix();
    translate(r.x, r.y);
    //rect(0, 0, r.w, r.h);
    //rect(0, 0, r.w*0.1, r.h*0.1);
    float aw = 0.4+int(random(2))*0.6;
    float ah = 0.4+int(random(2))*0.6;
    float d = min(min(r.w, r.h), 200);
    noFill();
    box(r.w, r.h, d);
    fill(getColor());
    piras(r.w, r.h, d, aw, ah);
    box(r.w*random(0.01, 0.02), r.h*0.98, d*0.98);
    box(r.w*0.98, r.h*random(0.01, 0.02), d*0.98);

    translate(0, 0, d+d*0.02);
    box(r.w*aw*0.9, r.h*ah*0.9, d*0.04);

    translate(0, 0, d*0.12);
    box(d*0.04, d*0.04, d*0.2);

    popMatrix();
  }


  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float d = min(min(r.w, r.h), 200);
    pushMatrix();
    translate(r.x, r.y, d*1.14);
    grid(d*0.3, d*0.3, 10);
    line(0, 0, 0, 0, 0, 40);
    
    translate(0, 0, 40);
    fill(0);
    box(1);

    line(-4, 0, 4, 0);
    line(0, -4, 0, 4);

    float mm = min(min(r.w, r.h)*0.5, 8);
    noFill();
    rect(0, 0, mm, mm);
    rect(0, 0, mm*1.8, mm*1.8);

    translate(0, 0, 0);

    popMatrix();
  }
}

void grid(float w, float h, int cc){
   for(int i = 0; i <= cc; i++){
      float v = (i*1.)/cc-0.5;
      line(-w*0.5, h*v, w*0.5, h*v);
      line(w*v, -h*0.5, w*v, h*0.5);
   }
}

void piras(float w, float h, float d, float aw, float ah) {
  float mw = w*0.5;
  float mh = w*0.5;
  beginShape();
  vertex(-mw, -mh, 0);
  vertex(+mw, -mh, 0);
  vertex(+mw, +mh, 0);
  vertex(-mw, +mh, 0);
  endShape(CLOSE);


  beginShape();
  vertex(-mw, -mh, 0);
  vertex(+mw, -mh, 0);
  vertex(+mw*aw, -mh*ah, d);
  vertex(-mw*aw, -mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(+mw, -mh, 0);
  vertex(+mw, +mh, 0);
  vertex(+mw*aw, +mh*ah, d);
  vertex(+mw*aw, -mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(+mw, +mh, 0);
  vertex(-mw, +mh, 0);
  vertex(-mw*aw, +mh*ah, d);
  vertex(+mw*aw, +mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(-mw, +mh, 0);
  vertex(-mw, -mh, 0);
  vertex(-mw*aw, -mh*ah, d);
  vertex(-mw*aw, +mh*ah, d);
  endShape(CLOSE);

  beginShape();
  vertex(-mw*aw, -mh*ah, d);
  vertex(+mw*aw, -mh*ah, d);
  vertex(+mw*aw, +mh*ah, d);
  vertex(-mw*aw, +mh*ah, d);
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#43748e, #ffc301, #FFE6D8, #F399AB};
//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
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
