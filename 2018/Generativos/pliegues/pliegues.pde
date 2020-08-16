int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
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

class Rect{
   float x, y, w, h;
   Rect(float x, float y, float w, float h){
      this.x = x; 
      this.y = y; 
      this.w = w; 
      this.h = h;
   }
}

void generate() {
  randomSeed(seed);
  background(#B2B2B2);
  
  float ss = random(10, 24);
  strokeWeight(1.2);
  stroke(lerpColor(color(255), color(#B2B2B2), random(0.4, 0.6)));
  for(float i = -ss*0.5; i < width+ss; i+=ss){
     line(i+random(-1, 1), 0, i+random(-1, 1), height); 
     line(0, i+random(-1, 1), width, i+random(-1, 1)); 
  }
  
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(ss, ss, width-ss*2, height-ss*2));
  
  int sub = int(random(4, 37));
  for(int i = 0; i < sub; i++){
     int ind = int(random(rects.size()));
     Rect r = rects.get(ind);
     float nw = r.w*random(0.35, 0.65);
     float nh = r.h*random(0.35, 0.65);
     rects.add(new Rect(r.x, r.y, nw, nh));
     rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
     rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
     rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
     rects.remove(ind);
  }
  
  noStroke();
  for(int i = 0; i < rects.size(); i++){
     Rect r = rects.get(i);
     int col = rcol();
     fill(col);
     rect(r.x+1, r.y+1, r.w-2, r.h-2);
     float cx = r.x+random(r.w);
     float cy = r.y+random(r.h);
     fill(255);
     ellipse(cx, cy, 4, 4);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#2B2827, #959CD3, #4EB9AF, #DBC9D5};
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
