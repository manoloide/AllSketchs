int seed = int(random(999999));
float det, des;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  hint(DISABLE_OPTIMIZED_STROKE);
  hint(ENABLE_DEPTH_SORT);

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
  background(0);

  //ortho();

  //blendMode(ADD);
  lights();

  translate(width*0.5, height*0.5, -200);
  rotateX(PI*random(0.0, 0.3));
  rotateZ(PI*random(0.2, 0.4));
  //rotateY(random(TAU));

  ArrayList<Rect> rects = new ArrayList<Rect>();

  rects.add(new Rect(0, 0, width*3, height*3));

  int sub = int(random(4, 800000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(0.6, 1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    float w1 = r.w*random(0.4, 0.6);
    float w2 = r.w-w1;
    float h1 = r.h*random(0.4, 0.6);
    float h2 = r.h-h1;
    rects.add(new Rect(r.x-r.w*0.5+w1*0.5, r.y-r.h*0.5+h1*0.5, w1, h1));
    rects.add(new Rect(r.x+r.w*0.5-w2*0.5, r.y-r.h*0.5+h1*0.5, w2, h1));
    rects.add(new Rect(r.x+r.w*0.5-w2*0.5, r.y+r.h*0.5-h2*0.5, w2, h2));
    rects.add(new Rect(r.x-r.w*0.5+w1*0.5, r.y+r.h*0.5-h2*0.5, w1, h2));
    rects.remove(ind);
  }

  //noStroke();
  float det = random(0.01);
  float des = random(1000);
  stroke(0, 180);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float w = r.w-2;
    float h = r.h-2;
    float hh = min(r.w, r.h)*pow(noise(des+r.x*det, des+r.y*det), 1.4)*10;
    float cc = (hh/20);
    float dh = hh*1./cc;
    rectMode(CENTER);
    pushMatrix();
    noFill();
    stroke(255, 240);
    noStroke();
    fill(lerpColor(getColor(), color(0), random(1)));
    translate(r.x, r.y, 0);
    rect(0, 0, r.w-2, r.h-2);
    //line(0, 0, 0, 0, 0, hh);
    translate(0, 0, hh*0.5);
    //fill(30);
    //box(2, 2, hh);
    stroke(255);
    noStroke();
    /*
    if (random(1) < 0.4) fill(random(180, 240));
     else fill(random(60));
     box(w, h, hh);
     
     boolean b1 = random(1) < 0.3;
     boolean b2 = random(1) < 0.3;
     boolean b3 = random(1) < 0.3;
     boolean b4 = random(1) < 0.3;
     float bb = min(w, h)*0.05;
     
     if (random(1) < 0.1) {
     beginShape();
     fill(rcol());
     vertex(+w*0.5, -h*0.5, -hh*0.5);
     vertex(+w*0.5, -h*0.5, +hh*0.5);
     fill(rcol());
     vertex(+w*0.5, +h*0.5, +hh*0.5);
     vertex(+w*0.5, +h*0.5, -hh*0.5);
     endShape();
     }
     
     float bw = ((b1)? 1 : 0 )+((b2)? 1 : 0)-0.1;
     float bh = ((b3)? 1 : 0 )+((b4)? 1 : 0)-0.1;
     if (bw > 0 || bh > 0) {
     if (random(1) < 0.4) fill(rcol());
     for (int j = 0; j <= cc; j++) {
     pushMatrix();
     translate(0, 0, dh*(j-cc*0.5));
     //fill(rcol());
     box(w+bw, h+bh, 3);
     //rect(r.x, r.y, r.w, r.h);
     popMatrix();
     }
     }
     */
    popMatrix();
  }




  /*
  post = loadShader("post.glsl");
   filter(post);
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


int colors[] = {#ED0494, #F651C6, #0602CB, #028900, #FCC20C, #FD0706, #B40317, #B4A217, #171F22};
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