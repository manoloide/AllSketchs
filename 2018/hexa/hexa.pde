void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  //noLoop();
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  background(#1E211C);
  translate(width/2, height/2);
  //rotate(random(-0.4, 0.4));

  //blendMode(ADD);

  float ss = random(60, 320);

  float dx = ss * 2 * (3./4);
  float dy = (sqrt(3)*ss)/4;
  int cw = int(width/dx)+2;
  int ch = int(height/dy)+2;
  noStroke();
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = ((j%2==0)? i : i+0.5)*dx;
      float y = j*dy;
      int col = rcol();
      noFill();

      float s = ss*random(0.6);
      for (int k = 0; k < 100; k++) {
        fill(rcol());
        hex(x-dx*0.5, y-dy, s);
        s *= random(random(0.95, 1));
      }

      s = ss;
      for (int k = 0; k < 100; k++) {
        fill(rcol());
        hex(x, y, s);
        s *= random(random(0.95, 1));
      }
      hexTri(x, y, ss);
    }
  }
}

void pico(float x, float y, float s, float a) {
  float r = s*0.5; 
  y += r*0.25;
  beginShape();
  vertex(x-r, y);
  vertex(x, y-r);
  vertex(x+r, y);
  vertex(x+r*a, y);
  vertex(x, y-r*a);
  vertex(x-r*a, y);
  endShape(CLOSE);
}



class Tri {
  float x, y, s, r, a;
  Tri(float x, float y, float s, float a) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.a = a;
    r = s*0.5;
  }

  void show() {
    show(1);
  }

  void show(float rr) {
    float da = TWO_PI/3; 
    beginShape();
    for (int i = 0; i < 3; i++) {
      float ang = da*i+a;
      vertex(x+cos(ang)*r*rr, y+sin(ang)*r*rr);
    }
    endShape(CLOSE);
  }

  ArrayList<Tri> sub() {
    ArrayList<Tri> aux = new ArrayList<Tri>();
    aux.add(new Tri(x, y, s*0.5, a+PI));
    float da = TWO_PI/3;
    for (int i = 0; i < 3; i++) {
      float ang = da*i+a;
      aux.add(new Tri(x+cos(ang)*r*0.5, y+sin(ang)*r*0.5, r, a));
    }

    return aux;
  }
}

int colors[] = {#4100DB, #EFC6D0, #FFA305, #FF2D2D, #E56299};
int rcol() {
  return colors[int(random(colors.length))];
}


void hex(float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  beginShape();
  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

void hexTri(float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    float ang2 = da*(i+1);  
    float mm = 120;
    beginShape();
    fill(0, random(mm));
    vertex(x, y);
    fill(0, random(mm));
    vertex(x+cos(ang)*r, y+sin(ang)*r);
    fill(0, random(mm));
    vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    endShape(CLOSE);
  }
}