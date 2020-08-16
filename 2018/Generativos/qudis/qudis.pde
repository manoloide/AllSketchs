int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  //strokeWeight(3);
  pixelDensity(2);

  //post = loadShader("post.glsl");

  generate();

  /*
  saveImage();
   exit();
   */
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
  background(#EDBFB7);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(200));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float nw = r.w*random(0.2, 0.8);
    float nh = r.h*random(0.2, 0.8);
    if (nw > 2 && nh > 2) {
      rects.add(new Rect(r.x, r.y, nw, nh));
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
      rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
      rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
      rects.remove(ind);
    }
  }

  for (int i = 0; i < rects.size(); i++) {
    noStroke();
    Rect r = rects.get(i);
    fill(rcol());
    rect(r.x+1, r.y+1, r.w-2, r.h-2);
    fill(rcol());
    rect(r.x+r.w*0.5-1, r.y+r.h*0.5-1, 2, 2);
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

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
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