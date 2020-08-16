import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Noise       noise1;


int seed = int(random(999999));
int subdivisions = 0;

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {


  randomSeed(seed);
  background(0);


  stroke(255);
  noFill();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    r.show();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

ArrayList<Rect> rects = new  ArrayList<Rect>();
void generate() {

  randomSeed(seed);
  
  if(minim != null) minim.stop();
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, 512);

  for(int i = 0; i < rects.size(); i++){
     rects.get(i).remove(); 
  }
  rects.clear();
  rects.add(new Rect(0, 0, width, height));
  subdivisions = int(max(1, random(20)*random(0.1, 1)));
  float max = 20;
  for (int i = 0; i < subdivisions; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    float mw = int(r.w*0.5);//random(0.3, 0.7));
    float mh = int(r.h*0.5);//random(0.3, 0.7));
    if (mw < max || mh < max || r.w-mw < max || r.h-mh < max) continue;
    rects.add(new NoiseRect(r.x, r.y, mw, mh));
    rects.add(new NoiseRect(r.x+mw, r.y, r.w-mw, mh));
    rects.add(new NoiseRect(r.x+mw, r.y+mh, r.w-mw, r.h-mh));
    rects.add(new NoiseRect(r.x, r.y+mh, mw, r.h-mh));
    rects.remove(ind);
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

int colors[] = {#303a52, #574b90, #9e579d, #fc85ae};
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
