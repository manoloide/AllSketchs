int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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

  ArrayList<Rect> rects = new  ArrayList<Rect>();
  rects.add(new Rect(-width*1.0, -height*1.0, width*2.0, height*2.0));
  int sub = int(random(300)*random(0.1, 1));
  float max = 20;
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float mw = int(r.w*random(0.3, 0.7));
    float mh = int(r.h*random(0.3, 0.7));
    mw -= mw%4;
    mh -= mh%4;
    if (mw < max || mh < max || r.w-mw < max || r.h-mh < max) continue;
    rects.add(new Rect(r.x, r.y, mw, mh));
    rects.add(new Rect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new Rect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new Rect(r.x, r.y+mh, mw, r.h-mh));
    rects.remove(ind);
  }

  ortho();
  translate(width*0.5, height*0.5, -1000);
  rotateX(-PI/6);
  rotateY(PI*0.2);
  lights();
  /*
  ambientLight(128, 128, 128);
   directionalLight(128, 128, 128, 0, 0.5, -1);
   lightFalloff(1, 0, 0);
   lightSpecular(0, 0, 0);
   */
  //rotateY(map(mouseX, 0, width, 0, 2*PI)); 
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(rcol());
    //rect(r.x, r.y, r.w, r.h);

    noStroke();
    int ss = 8;
    float h = min(r.w, r.h)*random(1, 8)*0.5;
    int cz = int(h/ss);
    int cy = int(r.h/ss);
    int cx = int(r.w/ss);
    float det = random(0.02);
    float des = random(1000);
    for (int z = 0; z < cz; z++) {
      for (int y = 0; y < cy; y++) {
        if (z != 0 &&  z != cz-1 && y != 0 && y != cy-1) continue; 
        for (int x = 0; x < cx; x++) {
          stroke(rcol(), 60);
          noFill();
          if (random(1) < 0.01) fill(rcol());
          float noi = noise(des+x*det, des+y*det, des+z*det)*30;
          pushMatrix();
          translate(r.x+ss*(x+0.5), r.y+ss*(y+0.5), ss*(z+0.5+noi));
          box(ss);
          popMatrix();
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#283149, #404b69, #f73859, #dbedf3};
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
