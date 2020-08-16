int seed = int(random(999999));
float det, des;

void setup() {
  size(3250, 3250, P3D);
  smooth(2);
  pixelDensity(2);

  generate();
  
  saveImage();
  exit();
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

  ortho();

  //lights();

  translate(width*0.5, height*0.5, -2000);
  rotateX(PI*random(0.0, 0.4));
  rotateZ(PI*random(0.2, 0.4));
  //rotateY(random(TAU));

  ArrayList<Rect> rects = new ArrayList<Rect>();

  rects.add(new Rect(0, 0, width*3, height*3));

  int sub = int(random(4, 80000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    float w1 = r.w*random(0.2, 0.8);
    float w2 = r.w-w1;
    float h1 = r.h*random(0.2, 0.8);
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
  stroke(0, 80);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    float hh = min(r.w, r.h)*random(10)*pow(noise(des+r.x*det, des+r.y*det), 1.4);
    float cc = (hh/20);
    float dh = hh*1./cc;
    fill(rcol());
    for (int j = 0; j < cc; j++) {
      pushMatrix();
      translate(r.x, r.y, dh*j);
      //fill(rcol());
      box(r.w-2, r.h-2, 3);
      //rect(r.x, r.y, r.w, r.h);
      popMatrix();
    }
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


int colors[] = {#522E90, #17BED0, #ED1A3B, #009A5A, #FFCB06};
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