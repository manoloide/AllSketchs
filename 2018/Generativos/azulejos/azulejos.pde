int seed = int(random(999999));

PFont font;

void setup() {
  size(6500, 6500, P2D);
  //smooth(8);
  //pixelDensity(2);

  //font = createFont("Chivo", 10, true);

  generate();
  saveImage();
  exit();
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
  background(rcol());

  rectMode(CENTER);
  int sc1 = rcol();
  int sc2 = rcol();
  int sc3 = rcol();
  float ss = width/24;
  int cc = int(width*1./ss);

  noStroke();
  fill(rcol(), 30);
  for (int j = 0; j <= cc*2; j++) {
    for (int i = 0; i <= cc*2; i++) {
      float xx = (i)*ss*0.5;
      float yy = (j)*ss*0.5;

      rect(xx, yy, 3, 3);
      rect(xx, yy, 1, 1);
      rect(xx+ss*0.25, yy+ss*0.25, 1, 1);
    }
  }

  for (int j = 0; j < cc-1; j++) {
    for (int i = 0; i < cc-1; i++) {
      float xx = (i+1)*ss;
      float yy = (j+1)*ss;
      noFill();
      stroke(sc1, 30);
      rect(xx, yy, ss, ss); 
      stroke(sc2, 30);
      rect(xx, yy, ss*0.9, ss*0.9);
      noStroke();
      fill(sc3, 200);
      //rect(xx, yy, ss*0.05, ss*0.05);

      /*
      fill(sc3, 80);
       textFont(font);
       textAlign(CENTER, CENTER);
       text(str(i)+"x"+str(j), int(xx), int(yy-1));
       */
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(ss*0.5, ss*0.5, width-ss+1, height-ss+1));

  int subh = int(random(1, 50));
  for (int i = 0; i < subh; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);

    float nh = int(random(1, r.h/ss))*ss;

    if (r.h-nh > ss) {
      rects.add(new Rect(r.x, r.y, r.w, nh));     
      rects.add(new Rect(r.x, r.y+nh, r.w, r.h-nh));
      rects.remove(ind);
    }
  }

  int subw = int(random(1, 100));
  for (int j = 0; j < subw; j++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float nw = int(random(1, r.w/ss))*ss;

    if (r.w-nw > ss ) {
      rects.add(new Rect(r.x, r.y, nw, r.h));     
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, r.h));
      rects.remove(ind);
    }
  }


  for (int k = 0; k < rects.size(); k++) {
    Rect r = rects.get(k);
    float w = r.w;
    float h = r.h;
    float x = r.x;
    float y = r.y;
    fill(rcol(), 180);
    rectMode(CORNER);
    int s = 1;
    rect(x, y, w, s);
    rect(x, y+s, s, h-s);
    rect(x+w-s, y+s, s, h-s);
    rect(x+s, y+h-s, w-s*2, s);

    int rnd = 0;//int(random(2));
    rectMode(CENTER);
    if (rnd == 0) {
      int sca = int(pow(2, int(random(0, 4))));
      int cw = int(w*sca/ss);
      int ch= int(h*sca/ss);
      float sss = ss/sca;
      for (int j = 0; j < ch; j++) { 
        for (int i = 0; i < cw; i++) {
          fill(getColor());
          float xx = x+(i+0.5)*sss;
          float yy = y+(j+0.5)*sss;
          rect(xx, yy, sss*0.8, sss*0.8);
          if (random(1) < 0.2) {
            float amp = random(0.5);
            fill(getColor());
            float cor = 0.5;
            if (sss < 10) cor = 0.0;
            rect(xx-cor, yy-cor, sss*0.8*amp, sss*0.8*amp);
          }
        }
      }
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#EE3425, #000000, #D3D3D3, #FEFEFE};
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