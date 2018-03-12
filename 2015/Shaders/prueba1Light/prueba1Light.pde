ArrayList<Particle> particles;
PShader shader;
void setup() {
  size(800, 600, P3D);
  smooth(8);
  colorMode(HSB, 256, 256, 256);
  shader = loadShader("frag.glsl", "vert.glsl");
  //shader.set("fraction", 1.0);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < 80; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  shader(shader);
  background(10);
  noStroke();
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  pointLight(255, 255, 255, width/2, height, 200);

  translate(width/2, height/2, -200);
  rotateX(frameCount*0.01);
  rotateY(frameCount*0.007);
  for (int i = 0; i < particles.size (); i++) {
    Particle p = particles.get(i);
    p.update();
    if (p.remove) particles.remove(i--);
  }
}

class Particle {
  boolean remove;
  float x, y, z;
  float tt, ang1, ang2;
  Particle() {
    tt = random(2, 40);
    ang2 = random(TWO_PI);
    ang1 = random(TWO_PI);
  }
  void update() {
    ang1 += random(-0.1, 0.1);
    ang2 += random(-0.1, 0.1);
    x += sin(ang1)*sin(ang2);
    y += cos(ang1)*sin(ang2);
    z += cos(ang2);
    show();
  }
  void show() {
   // fill(frameCount%256, 200, 200);
    pushMatrix();
    translate(x, y, z);
    sphere(tt);
    popMatrix();
  }
}
