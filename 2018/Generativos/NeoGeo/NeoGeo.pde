int seed = int(random(999999));

PShape logo;

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);

  logo = loadShape("NEOGEO.svg");

  //for(int i = 0; i < 10; i++){
    generate();
    saveImage();
  //}
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
  background(250);

  int sep = 128;

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  int sub = int(random(400)*random(1));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    //if (sep <= r.w || sep <= r.h) continue;
    /*
    float nw = int(random(1, r.w/sep))*sep;
    float nh = int(random(1, r.h/sep))*sep;
    */
    float nw = r.w*random(0.4, 0.6);
    float nh = r.h*random(0.4, 0.6);
    rects.add(new Rect(r.x, r.y, nw, nh));
    rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
    rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
    rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
    rects.remove(ind);
  }

  noStroke();
  stroke(0, 10);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(0);
    rect(r.x, r.y, r.w, r.h);

    float freq = random(random(5), 20);
    boolean hor = random(1) < 0.5;
    fill(255);
    beginShape();
    if (hor) {
      for (int j = 0; j < r.w; j++) {
        float yy = (cos(freq*j)*0.5+0.5)*r.h;
        vertex(r.x+j, r.y+yy);
      }
    } else {
      for (int j = 0; j < r.h; j++) {
        float xx = (cos(freq*j)*0.5+0.5)*r.w;
        vertex(r.x+xx, r.y+j);
      }
    }
    endShape(CLOSE);

    logo.setFill(color(int(random(1.1))*255));
    float amp = random(0.7, 0.9);
    shape(logo, r.x+r.w*0.5, r.y+r.h*0.5, r.w*amp, r.h*amp);
  }
} 

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
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