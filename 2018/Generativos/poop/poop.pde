int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  generate();

  saveImage();
  exit();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
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
  seed = int(random(999999));
  randomSeed(seed);
  background(0);

  int sep = 20;
  int cw = width/sep;
  int ch = height/sep;
  noStroke();
  fill(220, 40);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      rect(i*sep-1, j*sep-1, 2, 2);
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(1, 1, cw-2, ch-2));
  int sub = int(random(400));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    boolean hor = random(1) < 0.5;
    /*if (r.w > r.h) hor = true;
     else hor = false;
     */
    if (hor && r.w >= 2) {
      int nw = int(random(1, r.w-1));
      rects.add(new Rect(r.x, r.y, nw, r.h));
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, r.h));
      rects.remove(ind);
    } 
    if (!hor && r.h >= 2) {
      int nh = int(random(1, r.h-1));
      rects.add(new Rect(r.x, r.y, r.w, nh));
      rects.add(new Rect(r.x, r.y+nh, r.w, r.h-nh));
      rects.remove(ind);
    }
  }

  noFill();
  stroke(0);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    //rect(r.x*sep, r.y*sep, r.w*sep, r.h*sep);
    int col = rcol();
    int ss = 3;
    noStroke();
    for (int j = 0; j < (min(r.w, r.h)*sep*0.5+1)/ss; j++) {
      if (j%2 == 0) fill(0);
      else fill(col);
      rect(r.x*sep+ss*j, r.y*sep+ss*j, r.w*sep-ss*2*j, r.h*sep-ss*2*j);
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};
int colors[] = {#AECDEC, #D098F9, #3A3569, #FFC300, #FD3537};
//int colors[] = {#F97EB2, #EFDB01, #018FD8, #6EB201, #F92F23, #F9F6FA, #783391};
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