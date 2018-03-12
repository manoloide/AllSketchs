int pallet[] = {
  #B062EA, 
  #F392F2, 
  #FED08F, 
  #F6F39F
};

ArrayList<Parti> partis;
char letra;
PImage imgs[];
PFont font;
PGraphics mask;

void setup() {
  size(960, 960, P3D);
  textureMode(NORMAL);
  mask = createGraphics(width, height);
  font = createFont("Helvetica Neue Black", 120, true);
  letra =  (char) int(random(33, 127));
  partis = new ArrayList<Parti>();
  createTexture();
  generate();
}

void draw() {
  translate(width/2, height/2, 0);
  float a1 = map(cos(frameCount*0.007), -1, 1, -PI*0.08, PI*0.08);
  float a2 = map(cos(frameCount*0.013), -1, 1, -PI*0.14, PI*0.14);
  rotateX(a1);
  rotateY(a2);
  background(240);
  for (int i = 0; i < partis.size(); i++) {
    Parti p = partis.get(i);
    p.update();
    p.show();
  }
}

void keyPressed() {
  generate();
}

void createTexture() {
  int cc = 16; 
  imgs = new PImage[cc];
  PGraphics aux = createGraphics(32, 32);
  float sep = random(5, 20);
  float ss = sep*random(0.3);
  for (int i = 0; i < cc; i++) {
    aux.beginDraw();
    aux.background(rcol());
    aux.strokeWeight(ss);
    aux.stroke(rcol());
    for (float j = -random(sep); j < 64; j+=sep) {
      aux.line(-1, j, j, -1);
    }
    aux.endDraw();
    imgs[i] = aux.get();
  }
}

void generate() {
  letra = key;

  mask.beginDraw();
  mask.background(0);
  mask.textFont(font);
  mask.textSize(900);
  mask.textAlign(CENTER, CENTER);
  mask.fill(255);
  mask.text(str(key), width/2, height/3);
  mask.endDraw();

  for (int i = 0; i < 2000; i++) {
    float x = 0;
    float y = 0;
    float z = random(-40, 40);
    color col = color(0); 
    int count = 0;
    while (brightness(col) < 20 && count < 200) {
      x = random(width);
      y = random(height);
      col = mask.get(int(x), int(y));
      count++;
    }
    if (count < 200) {
      x -= width/2;
      y -= height/2;
      if (i > partis.size()-1) {
        partis.add(new Parti(new PVector(x, y, z)));
      } else {
        partis.get(i).setTo(new PVector(x, y, z));
      }
    }
  }
}


class Parti {
  color col;
  float vel, elastic;
  float size;
  int texture;
  PVector position, target;
  PVector velocity, force;
  Parti(PVector pos) {
    position = pos;
    target = pos;
    velocity = new PVector();
    force = new PVector();
    vel = random(0.6, 0.82);
    elastic = random(0.01, 0.012);
    size = random(2, 12);
    col = color(rcol());
    texture = int(random(imgs.length));
  }
  void update() {
    PVector aux = new PVector(target.x-position.x, target.y-position.y, target.z-position.z);
    velocity.add(aux);
    velocity.mult(vel);
    position.add(velocity);
  }

  void show() {
    noStroke();
    fill(col);
    pushMatrix();
    translate(position.x, position.y, position.z);
    scale(size);
    //box(1);
    cube(imgs[texture]);
    popMatrix();
  }

  void setTo(PVector np) {
    target = np;
  }
}

void cube(PImage tex) {
  beginShape(QUADS);
  texture(tex);

  vertex(-1, -1, 1, 0, 0);
  vertex( 1, -1, 1, 1, 0);
  vertex( 1, 1, 1, 1, 1);
  vertex(-1, 1, 1, 0, 1);

  // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1, 1, -1, 1, 1);
  vertex( 1, 1, -1, 0, 1);

  // +Y "bottom" face
  vertex(-1, 1, 1, 0, 0);
  vertex( 1, 1, 1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1, 1, 1, 1);
  vertex(-1, -1, 1, 0, 1);

  // +X "right" face
  vertex( 1, -1, 1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, 1, -1, 1, 1);
  vertex( 1, 1, 1, 0, 1);

  // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1, 1, 1, 0);
  vertex(-1, 1, 1, 1, 1);
  vertex(-1, 1, -1, 0, 1);

  endShape();
}

int rcol() {
  return pallet[int(random(pallet.length))];
}