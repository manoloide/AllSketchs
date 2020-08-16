ArrayList<Particula> particulas;
PFont helve;
PGraphics gra, mask;
PShader bloom, blur, glow, vignette;

void setup() {
  size(720, 480, P2D);
  frameRate(30);
  bloom = loadShader("bloom.glsl");
  blur = loadShader("blur.glsl"); 
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
  vignette = loadShader("vignette.glsl");
  vignette.set("resolution", float(width), float(height)); 
  //shader.set("time", 0.0);
  gra = createGraphics(width, height, P2D);
  particulas = new ArrayList<Particula>();
}

void draw() {
  particulas.add(new Particula(random(width), random(height)));
  blur.set("time", (float)millis() / 2000.0);  
  glow.set("iGlobalTime", frameRate/6.);
  helve = createFont("Helvetica Neue Bold", 80, true);
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.textAlign(CENTER, CENTER);
  mask.textFont(helve);
  mask.fill(255);
  mask.text("Shaderrs", width/2, height/2);
  mask.endDraw();
  background(0);
  gra.beginDraw();
  gra.filter(blur);
  for (int i = 0; i < particulas.size (); i++) {
    Particula p = particulas.get(i);
    p.update();
    if (p.eliminar) particulas.remove(i--);
  }
  for (int i = 0; i < 2; i++) {
    gra.stroke(random(256), random(256), random(256), random(200,256));
    gra.strokeWeight(random(1, 5));
    gra.noFill();
    poly(gra, random(width), random(height), random(10, 80), int(random(3, 10)), random(TWO_PI));
  }
  //gra.filter(glow);
  gra.endDraw();
  shader(glow);
  image(gra, 0, 0);
  filter(vignette);
  /*
  if(frameCount >= 300) exit();
  saveFrame("video/####.png");
  */
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    //particulas = new ArrayList<Particula>();
      float dx = random(width/2)-width/4;
      float dy = random(height/2)-height/4;
    for (int i = 0; i < 200000; i++) {
      float x = random(width);
      float y = random(height);
      if (brightness(mask.get(int(x+dx), int(y+dy))) > 200 || random(100) < 0.4)
        particulas.add(new Particula(x, y));
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath+"/export")).listFiles().length+1;
  saveFrame("export/"+nf(n, 4)+".png");
}

void poly(PGraphics gra, float x, float y, float d, int cant, float ang) {
  float r = d/2; 
  float da = TWO_PI/cant;
  gra.beginShape();
  for (int i = 0; i < cant; i++) {
    gra.vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  gra.endShape(CLOSE);
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
    vel = random(0.05, 0.1);
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
