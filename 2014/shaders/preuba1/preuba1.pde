ArrayList<Particula> particulas;
PFont helve;
PGraphics gra, mask;
PShader blur;

void setup() {
  size(720, 480, P2D);
  blur = loadShader("blur.glsl"); 
  helve = createFont("Helvetica Neue Bold", 80, true);
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.textAlign(CENTER, CENTER);
  mask.textFont(helve);
  mask.fill(255);
  mask.text("Te Amo", width/2, height/2);
  mask.endDraw();
  gra = createGraphics(width, height, P2D);
  particulas = new ArrayList<Particula>();
}

void draw() {
  background(0);
  gra.beginDraw();
  for (int i = 0; i < particulas.size (); i++) {
    Particula p = particulas.get(i);
    if (p.eliminar) particulas.remove(i--);
    p.update();
  }
  gra.endDraw();
  gra.filter(blur);
  image(gra, 0, 0);
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    particulas = new ArrayList<Particula>();

    for (int i = 0; i < 200000; i++) {
      float x = random(width);
      float y = random(height);
      if (brightness(mask.get(int(x), int(y))) > 200)
        particulas.add(new Particula(x, y));
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath+"/export")).listFiles().length+1;
  saveFrame("export/"+nf(n, 4)+".png");
}

class Particula {
  boolean eliminar = false;
  color col; 
  float x, y, t, ang, vel;
  Particula(float x, float y) {
    this.x = x; 
    this.y = y;
    col = color(random(240, 256), random(240, 256), random(240, 256));
    t = random(4);
    vel = random(0.05,0.1);
    ang = random(TWO_PI);
  }
  void update() {
    ang += random(-0.04, 0.04);
    vel *= 1+random(0.1);
    t -= random(0.08);
    if (t < 0) eliminar = true;
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
  }
  void show() {

    gra.noStroke();
    gra.fill(col);
    gra.ellipse(x, y, t, t);
  }
}
