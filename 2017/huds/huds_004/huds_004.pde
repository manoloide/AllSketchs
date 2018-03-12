void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
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

  blendMode(ADD);

  float ss = random(60, 320);

  float dx = ss * 2 * (3./4);
  float dy = (sqrt(3)*ss)/4;
  int cw = int(width/dx)+2;
  int ch = int(height/dy)+2;
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = ((j%2==0)? i : i+0.5)*dx;
      float y = j*dy;
      int col = rcol();
      strokeWeight(1);
      stroke(255, 10);
      noFill();
      hex(x, y, ss);
      hexTri(x, y, ss);

      strokeWeight(ss*0.025);
      noFill();
      stroke(col, 40);
      hex(x, y, ss*0.93);
      hex(x, y, ss*0.83);
      noStroke();
      if (random(1) < 0.5) {
        fill(col, 180);
        hex(x, y, ss*0.72);
      } else {
        fill(col, 180);
        if (random(1) < 0.5) {
          rect(x, y, ss*0.5, ss*0.14, ss*0.01);
        } else {
          pico(x, y, ss*0.55, 0.4);
        }
      }


      noStroke();
      fill(rcol(), 50);
      if (random(1) < 0.95) hex(x, y, ss*0.9);
      if (random(1) < 0.95) hex(x, y, ss*random(0.6));

      ellipse(x, y, ss*0.75, ss*0.75);




      ArrayList<Tri> tris = new ArrayList<Tri>();
      float da = TWO_PI/6;
      for (int k = 0; k < 6; k++) {
        float ang = da*k-PI/6;
        float rr = ss*0.25;
        tris.add(new Tri(x+cos(ang)*rr, y+sin(ang)*rr, ss*0.5, da*(k+0.5)));
      }

      int cc = 20;
      for (int k = 0; k < cc; k++) {
        int ind = int(random(tris.size()));
        ArrayList<Tri> aux = tris.get(ind).sub();
        for (int l = 0; l < aux.size(); l++) {
          tris.add(aux.get(l));
        }
        tris.remove(ind);
      }


      for (int k = 0; k < tris.size(); k++) {
        fill(rcol());
        tris.get(k).show(0.9);
      }
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

int colors[] = {color(255, 8, 20), color(0, 255, 80), color(255, 120, 0)};//{#A633E5, #33E5A2, #F2DABC};

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
    beginShape();
    vertex(x, y);
    vertex(x+cos(ang)*r, y+sin(ang)*r);
    vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    endShape(CLOSE);
  }
}