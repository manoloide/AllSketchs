int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  background(0);


  float fov = PI/random(1.1, 1.3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);

  translate(width/2, height/2, 0);
  rotateX(random(TWO_PI));
  rotateY(random(TWO_PI));
  rotateZ(random(TWO_PI));


  rectMode(CENTER);
  float size = width*random(2, 10);
  translate(size*random(-0.2, 0.2), size*random(-0.2, 0.2), size*random(-0.2, 0.2));
  noFill();
  //stroke(255);
  boxes(size);
}

void boxes(float s) {
  float ms = s*0.5;
  pushMatrix();
  translate(0, 0, -ms);
  plane(s);
  translate(0, 0, s);
  plane(s);
  popMatrix();
  pushMatrix(); 
  rotateX(HALF_PI);
  translate(0, 0, -ms);
  plane(s);
  translate(0, 0, s);
  plane(s);
  popMatrix();
  pushMatrix(); 
  rotateY(HALF_PI);
  translate(0, 0, -ms);
  plane(s);
  translate(0, 0, s);
  plane(s);
  popMatrix();
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

void plane(float s) {
  float ms = s*0.5;
  /*
  noFill();
   stroke(255);
   rect(0, 0, s, s);
   line(-ms, -ms, ms, ms);
   line(-ms, ms, ms, -ms);
   noStroke();
   fill(255);
   rect(0, 0, s*0.1, s*0.1);
   */

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, s, s));

  int sub = int(random(10, 20000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float mw = r.w*0.5;
    float mh = r.h*0.5;
    float dw = r.w*0.25;
    float dh = r.h*0.25;
    if (random(1) < 0.5) { 
      rects.add(new Rect(r.x-dw, r.y, mw, r.h));
      rects.add(new Rect(r.x+dw, r.y, mw, r.h));
    } else {
      rects.add(new Rect(r.x, r.y-dh, r.w, mh));
      rects.add(new Rect(r.x, r.y+dh, r.w, mh));
    }
    /*
    rects.add(new Rect(r.x-dw, r.y-dh, mw, mh));
     rects.add(new Rect(r.x+dw, r.y-dh, mw, mh));
     rects.add(new Rect(r.x+dw, r.y+dh, mw, mh));
     rects.add(new Rect(r.x-dw, r.y+dh, mw, mh));
     */
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float mw = r.w*0.5;
    float mh = r.h*0.5;
    /*
    if (random(1) < 0.5) {
     beginShape();
     vertex(r.x-mw, r.y-mh);
     vertex(r.x+mw, r.y-mh);
     vertex(r.x+mw, r.y+mh);
     vertex(r.x-mw, r.y+mh);
     endShape(CLOSE);
     } else {
     beginShape();
     vertex(r.x+mw, r.y-mh);
     vertex(r.x+mw, r.y+mh);
     vertex(r.x-mw, r.y+mh);
     vertex(r.x-mw, r.y-mh);
     endShape(CLOSE);
     }
     */
    fill(rcol());
    rect(r.x, r.y, r.w, r.h);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
//int colors[] = {#5C9FD3, #F19DA2, #FEED2D, #9DC82C, #33227E};
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