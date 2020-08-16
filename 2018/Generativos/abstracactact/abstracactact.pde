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

void generate() {
  background(0);

  int cc = int(random(7, random(8, 160)));
  float ss = width*1./cc;

  /*
  noStroke();
   fill(210);
   rectMode(CENTER);
   for (int j = 0; j < cc; j++) {
   for (int i = 0; i < cc; i++) {
   rect(i*ss, j*ss, 3, 3);
   }
   }
   */


  stroke(30);
  noStroke();


  int dx = int(random(-5, 5));
  int dy = int(random(-5, 5));
  for (int k = 0; k < 100; k++) {
    int lar = int(random(8, random(8, 50)));

    int ax = int(random(-4, cc+4));
    int ay = int(random(-4, cc+4));
    ArrayList<PVector> points = new ArrayList<PVector>();
    for (int i = 0; i < lar; i++) {
      points.add(new PVector(ax, ay));
      ax += int(random(-5, 5));
      ay += int(random(-5, 5));
    }


    int sub = int(random(1, 50));
    int shw = 40;
    for (int j = 0; j < sub; j++) {
      beginShape();
      int col = ((j%2)== 0)? 0 : (255-shw);
      fill(col);
      float d1 = map(j, 0, sub, 0, 1);
      float d2 = map(j+1, 0, sub, 0, 1);
      for (int i = 0; i < points.size(); i++) {
        PVector p1 = points.get(i);
        stroke(255-(col+(((i%2)== 0)? shw : 0)));
        fill(col+(((i%2)== 0)? shw : 0));
        vertex((p1.x+dx*d1)*ss, (p1.y+dy*d1)*ss);
      }
      for (int i = points.size()-1; i >=0; i--) {
        PVector p1 = points.get(i);
        stroke(255-(col+((((i+1)%2)== 0)? shw : 0)));
        fill(col+((((i+1)%2)== 0)? shw : 0));
        vertex((p1.x+dx*d2)*ss, (p1.y+dy*d2)*ss);
      }
      endShape(CLOSE);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#155263, #FF6F3C, #FF9A3C, #FFC93C};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}