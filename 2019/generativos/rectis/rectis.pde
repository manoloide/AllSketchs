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

  background(0);

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

  background(#CBC6B8);

  translate(width*0.5, height*0.5);

  ArrayList<Rect> rects = new ArrayList<Rect>();

  rects.add(new Rect(0, 0, width-20, height-20));

  int sub = int(random(90, 120)*3);
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float nw = r.w*0.5;
    float nh = r.h*0.5;
    if (nw < 5 || nh < 5) continue;
    rects.add(new Rect(r.x-nw*0.5, r.y-nh*0.5, nw, nh));
    rects.add(new Rect(r.x+nw*0.5, r.y-nh*0.5, nw, nh));
    rects.add(new Rect(r.x+nw*0.5, r.y+nh*0.5, nw, nh));
    rects.add(new Rect(r.x-nw*0.5, r.y+nh*0.5, nw, nh));
    rects.remove(ind);
  }

  int div = 50;
  float bb = 10;

  float ss = (width-bb*2)/div;

  float des = random(1000);
  float det = random(0.008, 0.014)*0.4;

  float desCol = random(1000);
  float detCol = random(0.004, 0.008)*0.26;


  float desH = random(1000);
  float detH = random(0.004, 0.008)*0.6;

  //lights();


  noStroke();

  rectMode(CENTER);
  fill(rcol());
  for (int j = 0; j < rects.size(); j++) {
    if (random(1) < 0.5) continue;
    Rect r = rects.get(j);
    rect(r.x, r.y, r.w, r.h);
    
    fill(rcol());
    ellipse(r.x, r.y, r.w*0.5, r.h*0.5);
  }


  //stroke(0);
  for (int j = 0; j < rects.size(); j++) {
    Rect r = rects.get(j);
    float x = r.x;
    float y = r.y;
    float z = 0;//noise(desH+x*detH, desH+y*detH)*240*random(1)*random(1)*random(1)*random(1);
    float ww  = r.w;
    float hh  = r.h;

    float d = noise(des+x*det, des+y*det)-0.5;//random(-0.3, 0.3)*random(1);//random(0.4, 0.6);
    if(d < 0) d = d;
    else continue;//d = 0;


    float col = noise(desCol+x*detCol, desCol+y*detCol)*colors.length*3;
    float dc = noise(desH+x*detH, desH+y*detH)*10;


    for (int i = 0; i < 1; i++) {

      beginShape(QUADS);

      fill(getColor(col+i*dc));
      vertex(x-ww*d, y-hh*0.5, z);
      vertex(x+ww*0.5, y-hh*d, z);
      vertex(x+ww*d, y+hh*0.5, z);
      vertex(x-ww*0.5, y+hh*d, z);

      endShape();

      ww *= 0.5;
      hh *= 0.5;

      fill(getColor(col+i*dc+1));
      ellipse(x, y, ww, hh);


      fill(getColor(col+i*dc+2));
      ellipse(x, y, ww*0.2, hh*0.2);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#43748e, #ffc301, #FFE6D8, #F399AB};
//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
//int colors[] = {#F3F1F4, #ECB827, #C94849, #038079, #383970, #1E1E20};
//int colors[] = {#2B3D8F, #E23B15, #080907, #E8DBE2};
//int colors[] = {#F74CCF, #00D369, #F1D302, #F73A2B, #11171F, #F1E5ED};
int colors[] = {#CBC6B8, #F74E00, #00905A, #173F8D, #121012};
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
  return lerpColor(c1, c2, pow(v%1, 6));
}
