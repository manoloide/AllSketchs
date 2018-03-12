PFont font;

void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
  font = createFont("Zilap.ttf", 100, true);
  textFont(font);
  generate();
}


void draw() {
  //if (frameCount%30 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(#111011);

  ArrayList<Quad> quads = new ArrayList<Quad>();
  quads.add(new Quad(0, 0, width, height));

  int c = int(random(3, 200));
  int maxSub = int(random(1, random(6, 20)));
  for (int k = 0; k < c; k++) {
    int ind = int(random(quads.size()));
    Quad q = quads.get(ind); 
    if (min(q.w, q.h) < 8) continue;
    int sw = int(random(2, maxSub));
    int sh = int(random(2, maxSub));

    float dw = q.w/sw;
    float dh = q.h/sh;

    for (int j = 0; j < sh; j++) {
      for (int i = 0; i < sw; i++) {
        quads.add(new Quad(q.x+dw*i, q.y+dh*j, dw, dh));
      }
    }

    quads.remove(ind);
  }

  noStroke();
  float ss = 4;
  for (int k = 0; k < quads.size(); k++) {
    Quad q = quads.get(k);
    //float ss = min(q.w, q.h)*random(0.2);
    if (random(1) < 0.6) {
      int col = rcol();
      float alp = random(100, 256);
      fill(col, alp);
      //stroke(col, alp*random(1, 1.2));
      rect(q.x+q.w/2, q.y+q.h/2, q.w-ss, q.h-ss);
      if (random(1) < 0.8) {
        int sw = 1;
        int sh = 1;
        if (q.w > q.h) sw = int(q.w/q.h); 
        else sh = int(q.h/q.w);
        float dw = q.w/sw;
        float dh = q.h/sh;
        float s = min(dw, dh)*0.8;
        for (int j = 0; j < sh; j++) {
          for (int i = 0; i < sw; i++) {
            if (random(1) < 0.8) {
              blendMode(ADD); 
              fill(col, alp*0.6);
            } else {
              blendMode(BLEND); 
              fill(0, alp*0.4);
            }
            float x = q.x+dw*(i+0.5);
            float y = q.y+dh*(j+0.5);
            icon(x, y, s);
          }
        }
        blendMode(BLEND);
      }
    } else {
      blendMode(ADD);
      int sw = 1;
      int sh = 1;
      if (q.w > q.h) sw = int(q.w/q.h); 
      else sh = int(q.h/q.w);
      int sub = int(random(1, 5));
      sw *= sub;
      sh *= sub;
      float dw = q.w/sw;
      float dh = q.h/sh;
      int form = int(random(2));
      float bor = min(q.w, q.h)*random(0.1);
      int col = rcol();
      float alp = random(50, 256);
      fill(col, random(40));
      rect(q.x+q.w/2, q.y+q.h/2, q.w-bor/2, q.h-bor/2);
      fill(col, alp);
      float s = min(dw, dh)-bor;
      boolean nois = random(1) < 0.6;
      float det = random(0.1);
      for (int j = 0; j < sh; j++) {
        for (int i = 0; i < sw; i++) {
          float x = q.x+dw*(i+0.5);
          float y = q.y+dh*(j+0.5);
          if (nois) fill(col, alp*noise(x*det, y*det));
          if (form == 0) ellipse(x, y, s, s);
          else rect(x, y, dw-bor, dh-bor);
        }
      }
      blendMode(BLEND);
    }
  }
}

void icon(float x, float y, float s) {
  int f = int(random(5));
  if (f == 0) ellipse(x, y, s, s);
  else if (f == 1) {
    s *= 0.7;
    pushMatrix();
    translate(x, y);
    rotate(PI/4);
    rect(0, 0, s, s);
    popMatrix();
  } else if (f == 2) {
    s = s*0.71;
    float a = PI/4;
    int sub = int(random(2, 4));
    float ms = s/sub;
    float g = ms*random(0.3, 0.5);
    float b = ms*random(0.1);
    float prob = random(1);
    for (int i = 2; i <= sub; i++) {
      float ss = ms*i; 
      if (random(1) < prob) marc(x, y, ss, b, g, a+0);
      if (random(1) < prob) marc(x, y, ss, b, g, a+HALF_PI);
      if (random(1) < prob) marc(x, y, ss, b, g, a+PI);
      if (random(1) < prob) marc(x, y, ss, b, g, a+PI*1.5);
    }
  } else if (f == 3) {
    float a = 0;
    if (random(1) < 0.5) {
      a += PI/4;
    } else {
      s *= 0.71;
    }
    cross(x, y, s, random(0.02, 0.2), a);
  } else if (f == 4) {
    textAlign(CENTER, TOP);
    String chrs = "abcdefghijklmnopqrtsuvwxyz";
    String str = str(chrs.charAt(int(random(chrs.length()))));
    textSize(s);
    text(str, x, y-(textAscent()-textDescent())*0.75);
    println(textDescent(), textAscent());
  }
}

void marc(float x, float y, float s, float b, float g, float a) {
  float r = s*0.5;
  pushMatrix();
  translate(x, y);
  rotate(a);
  beginShape();
  vertex(r, r-b);
  vertex(r, -r+b);
  vertex(r-g, -r+g+b);
  vertex(r-g, r-g-b);
  endShape(CLOSE);
  popMatrix();
}

void cross(float x, float y, float s, float g, float a) {
  s *= 0.5;
  float da = TWO_PI/4;
  float dd = s*g; 
  float diag = dist(dd, 0, 0, dd);
  beginShape();
  for (int i = 0; i < 4; i++) {
    float aa = a+da*i;
    float xx = x+cos(aa)*s; 
    float yy = y+sin(aa)*s;
    float dx = cos(aa+HALF_PI)*dd;
    float dy = sin(aa+HALF_PI)*dd;
    vertex(xx-dx, yy-dy);
    vertex(xx+dx, yy+dy);
    vertex(x+cos(aa+da/2)*diag, y+sin(aa+da/2)*diag);
  }
  endShape(CLOSE);
}

class Quad {
  float x, y, w, h;
  Quad(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

int colors[] = {#fe435b, #19b596, #9061bf, #e0dc3f};
int rcol() {
  return colors[int(random(colors.length))];
};