int paleta[] = {
  #7DA110, 
  #F61529, 
  #85725D, 
  #101B29, 
  #E2E5EE
};

ArrayList<Particula> particulas;

void setup() {
  size(600, 600);
  generar();
  particulas = new ArrayList<Particula>();
  for (int i = 0; i < 20; i++) {
    particulas.add(new Particula(width/2, height/2));
  }
}

void draw() {
  /*
  background(20);
   for (int i = 0; i < particulas.size (); i++) {
   Particula p = particulas.get(i);
   p.moved(mouseX, mouseY);
   p.update();
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  particulas = new ArrayList<Particula>();
  int cant = int(random(3, 300));
  for (int i = 0; i < cant; i++) {
    particulas.add(new Particula(cos(0)*width*0.4, sin(0)*height*0.4));
  }
  background(20);
  float cv = random(1, 10);
  float av = random(TWO_PI);
  float amplitud = random(0.2, 0.4);
  int cc = 1200;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < particulas.size (); i++) {
      Particula p = particulas.get(i);
      float aa = TWO_PI*(1./cc)*j;
      float amp = width*(amplitud-cos(TWO_PI*(j*1./cc)*cv)/20);
      float xx = width/2+cos(aa+av)*amp;
      float yy = height/2+sin(aa+av)*amp;
      p.moved(xx, yy);
      p.update();
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length+1;
  saveFrame(nf(n, 4)+".png");
}
class Particula {
  color col;
  float x, y, t, cx, cy, ang, da, vel, des;
  Particula(float x, float y) {
    this.x = x; 
    this.y = y;
    col = rcol();//color(random(80, 256));
    da = random(0.5);
    vel = random(0.2, 1);
    des = random(0.2, 1.8);
    t = random(2, 12);
  }
  void update() {
    ang = atan2(cy-y, cx-x);
    float av = vel*dist(x, y, cx, cy)*0.4;
    x += cos(ang)*av+cos(da*frameRate)*av*(des+0.3);
    y += sin(ang)*av+sin(da*frameRate)*av*(des+0.3);
    show();
  }
  void show() {
    stroke(col, 30);
    fill(col, 20);
    ellipse(x, y, t, t);
  }
  void moved(float cx, float cy) {
    this.cx = cx; 
    this.cy = cy;
  }
}

int rcol() {
  return paleta[int(random(paleta.length))];
}
