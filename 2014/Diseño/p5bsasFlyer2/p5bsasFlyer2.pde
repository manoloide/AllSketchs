int paleta[] = {
  #86579E, 
  #F04DE5, 
  #FFFFF5, 
  #D6FFE2, 
  #43FAE2
};

ArrayList<Particula> particulas;
PFont helve;
PGraphics gra, ui, mask;
PShader bloom, blur, glow, vignette;
PShape logo;

void setup() {
  size(800, 1000, P2D);
  frameRate(30);

  logo = loadShape("logoODDCG.svg");

  bloom = loadShader("bloom.glsl");
  blur = loadShader("blur.glsl"); 
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
  vignette = loadShader("vignette.glsl");
  vignette.set("resolution", float(width), float(height)); 
  //shader.set("time", 0.0);
  gra = createGraphics(width, height, P2D);
  ui = createGraphics(width, height, P2D);
  particulas = new ArrayList<Particula>();
}

void draw() {
  for (int i = 0; i < frameCount%20; i++) {
    particulas.add(new Particula(random(width), random(height)));
  }
  blur.set("time", (float)millis() / 2000.0);  
  glow.set("iGlobalTime", frameCount/6.);
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
    gra.stroke(rcol());
    gra.strokeWeight(random(1, 5));
    gra.noFill();
    poly(gra, random(width), random(height), random(10, 80), int(random(3, 10)), random(TWO_PI));
  }
  //gra.filter(glow);
  gra.endDraw();
  shader(glow);
  image(gra, 0, 0);
  fill(250);
  rect(0, height-200, width, 200);
  shape(logo, 20, height-120);
  filter(vignette);
  /*
  if(frameCount >= 300) exit();
   saveFrame("video/####.png");
   */
}

void keyPressed() {
  if (key == 's') saveImage();
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

int rcol() {
  return paleta[int(random(paleta.length))];
}
