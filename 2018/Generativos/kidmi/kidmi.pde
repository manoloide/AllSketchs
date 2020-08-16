import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

  //blendMode(ADD);


  randomSeed(seed);
  noiseSeed(seed);
  background(#010101);

  //SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng)*TAU*30;


  stroke(0, 50);

  int cc = int(random(20, 40));
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = i*ss;
      float y = j*ss;
      fill(((random(1) < 0.2)? rcol() : #E6E7E9));
      rect(x, y, ss, ss);
      fill(rcol());
      rect(x+ss*0.45, y+ss*0.45, ss*0.1, ss*0.1);
    }
  }

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    float s = ss*int(random(1, 5));
    xx -= (xx%(s*0.5));
    yy -= (yy%(s*0.5));
    points.add(new PVector(xx, yy, s));
    fill(rcol());
    ellipse(xx, yy, s, s);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    for (int j = 0; j < rects.size(); j++) {
      Rect r = rects.get(j);
      if(p.x > r.x && r.x+r.w < p.x && p.y > r.y && r.y+r.h < p.y){
        float w1 = p.x-r.w;
        float w2 = r.w-w1;
        float h1 = p.y-r.h;
        float h2 = r.h-h1;
        
      }
    }
  }
  
  for(int i = 0; i < rects.size(); i++){
     Rect r = rects.get(i);
     int col = rcol();
     stroke(col);
     fill(col, 70);
     rect(r.x, r.y, r.w, r.h);
  }



  for (int k = 0; k < 10; k++) {
    float xx = random(width);
    float yy = random(height);
    xx -= (xx%ss);
    yy -= (yy%ss);
    float ww = int(random(1, 8))*ss;
    float hh = int(random(1, 8))*ss;
    int ccc = int(random(3, 28));
    for (int i = 0; i <= ccc; i++) {
      float nx = map(i, 0, ccc, xx, xx+ww);
      line(nx, yy, nx, yy+hh);
    }

    for (int j = 0; j <= ccc; j++) {
      float ny = map(j, 0, ccc, yy, yy+hh);
      line(xx, ny, xx+ww, ny);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
