ArrayList<Parti> partis;

LutFilter lut;

void setup() {
  size(800, 800);
  lut = new LutFilter("LUTs/Brannan.cube"); 
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  background(20);
  partis = new ArrayList<Parti>();
  for (int i = 0; i < 80; i++) {
    float x = width/2;
    float y = height/2;
    partis.add(new Parti(x, y));
  }

  int frames = 400*40;
  for (int j = 0; j < frames; j++) {
    for (int i = 0; i < partis.size (); i++) {
      Parti p = partis.get(i);
      p.update();
      if (p.remove) partis.remove(i--);
    }
  }
  IPnoise(0.05);
  //IPdisplace(random(-1, 2)*random(0.5, 1), random(-1, 2)*random(0.5, 1), random(-1, 2)*random(0.5, 1));
  IPvignette(0.6);

  File folderLut = new File(sketchPath("LUTs"));
  File[] luts = folderLut.listFiles();
  lut.load(luts[int(random(luts.length))].toString());
  lut.apply(0.6);
  println(lut.src);
}

class Parti {
  boolean remove;
  color col;
  float x, y, ang, vel;
  float lfo1, lfo2;
  Parti(float x, float y) {
    this.x = x; 
    this.y = y;
    ang = random(TWO_PI);
    vel = random(2);
    float cc = random(random(100), random(255));
    col = color(cc, cc, cc+random(2)+random(1), random(100)*random(random(0.8, 2)));
    lfo1 = random(0.002);
    lfo2 = random(0.5);
  }
  void update() {
    ang += random(-0.1, 0.1)+cos(lfo1)*sin(lfo2)*0.01;
    x += cos(ang)*vel; 
    y += sin(ang)*vel;
    show();
    if (x < 0 || x > width || y < 0 || y > height) {
      remove = true;
    }
  }
  void show() {
    float d = (random(1) < 0.003/partis.size())? random(10, 40)*random(2) : random(1, 2); 
    if (d > 3) {
      partis.add(new Parti(x, y));
      partis.add(new Parti(x, y));
    }
    noStroke(); 
    fill(col);
    ellipse(x, y, d, d);
    if (d > 4) {
      float ran = random(1);
      if (ran < 0.4) {
        int c = int(random(3, 10));
        float a = random(TWO_PI);
        float t = random(2, 8);
        d /= 2;
        for (int i = 0; i < d; i++) {
          if (i%2 == 0) fill(red(col));
          else fill(255-red(col));
          poly(x, y, t*d-i*t, c, a);
        }
      } else if (ran > 0.9) {
        d = pow(d, 1.3); 
        fill(0);
        ellipse(x, y, d, d);
        fill(255);
        ellipse(x-d*.2, y-d*0.18, d*0.18, d*0.18);
        ellipse(x+d*.2, y-d*0.18, d*0.18, d*0.18);
        arc(x, y-d*0.01, d*0.78, d*0.78, PI*0.05, PI*0.95, OPEN);
      } else {
        while (d > 4) {
          d--;
          ellipse(x, y, d, d);
        }
      }
    }
  }
}  

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-2;
  saveFrame(nf(n, 3)+".png");
}


void poly(float x, float y, float d, int c, float a) {
  float r = d*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    float xx = x + cos(da*i+a) * r;
    float yy = y + sin(da*i+a) * r; 
    vertex(xx, yy);
  }
  endShape(CLOSE);
}

