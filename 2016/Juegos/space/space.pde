ArrayList<Particle> partis;
ArrayList<Icon> icons;

int pallet[] = {
  #F2521D, 
  #F4DF24, 
  #513AFF, 
  #FFADD7, 
  #2D0044, 
  #32A55F
};
PShader post;
PVector mouse, cam;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  float fov = PI/2;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/300.0, cameraZ*300.0);

  mouse = new PVector();
  cam = new PVector();

  partis = new ArrayList<Particle>();
  for (int i = 0; i < 200; i++) {
    partis.add(new PartiLine());
  }

  icons = new ArrayList<Icon>();

  post = loadShader("data/post.glsl");
  post.set("resolution", (float)width, (float)height);
}


void draw() {  
  post.set("time", millis()/1000.);
  PVector aux = new PVector(mouseX*-1./width+0.5, mouseY*-1./height+0.5);
  aux.sub(mouse);
  aux.mult(0.05);
  mouse.add(aux);
  cam = mouse.copy().mult(width*2);

  pushMatrix();
  translate(width/2, height/2, 0);
  translate(cam.x, cam.y, 0);
  rotateX(PI/6*mouse.x);
  rotateY(PI/6*mouse.y);
  int cc = 5;
  float da = TWO_PI/cc;
  float r = width*1.8;
  noStroke();
  float time = frameCount*0.005;
  for (int i = 0; i < cc; i++) {
    float d1 = noise(5+time*0.2, i);
    float d2 = noise(5+time*0.2, (i+1)%cc);
    float a1 = time+da*(i-d1);
    float a2 = time+da*(i+1-d2);
    fill(pallet[i%pallet.length]);
    beginShape();
    vertex(cos(a1)*r, sin(a1)*r, 800);
    vertex(cos(a2)*r, sin(a2)*r, 800);
    vertex(0, 0, -8000);
    endShape();
  }

  for (int i = 0; i < partis.size(); i++) {
    Particle p = partis.get(i);
    p.update();
    if (p.remove) partis.remove(i--);
  }

  if (frameCount%20 == 0) {
    partis.add(new Food());
  }

  if (frameCount%20 == 0) {
    if (icons.size() < 6) {
      icons.add(new Icon());
    }
  }

  //filter(post);
  popMatrix();

  hint(DISABLE_DEPTH_TEST);
  stroke(255, 80);
  int bb = 80;
  float ss = 40;
  for (int i = 0; i < icons.size(); i++) {
    float x = width*1.35-bb;
    float y = height*1.35-bb - ss*3.0*i;
    fill(icons.get(i).col);
    beginShape();
    vertex(x-ss, y);
    vertex(x, y-ss);
    vertex(x+ss, y);
    vertex(x, y+ss);
    endShape(CLOSE);
  }
  hint(ENABLE_DEPTH_TEST);
}

void mousePressed() {
  partis.add(new Food());
}

class Particle {
  boolean remove;
  void update() {
  }
  void show() {
  }
}

class PartiLine extends Particle {
  color col;
  PVector pos, dir; 
  PartiLine() {
    col = color(255);
    dir = new PVector(0, 0, random(12));
    randPos();
    pos.z = random(-5000, 0);
  }

  void update() {
    dir.x += random(-0.6, 0.6);
    dir.y += random(-0.6, 0.6);
    dir.x *= 0.94;
    dir.y *= 0.94;
    pos.add(dir);
    show();
    if (pos.z > 800) {
      randPos();
    }
  }

  void randPos() {
    float ang = random(TWO_PI);
    float r = width*1.2*random(1);
    pos = new PVector(cos(ang)*r, sin(ang)*r, -5000);
  }

  void show() {
    PVector cola = dir.copy().mult(6);
    PVector p2 = pos.copy().sub(cola);
    stroke(col);
    line(pos.x, pos.y, pos.z, p2.x, p2.y, p2.z);
  }
}

class Food extends Particle {
  color col;
  PVector pos, dir; 
  Food() {
    col = rcol();
    dir = new PVector(0, 0, 20);
    randPos();
  }

  void update() {
    pos.add(dir);
    show();
    if (pos.z > 500) {
      float dist =  dist(pos.x, pos.y, -cam.x, -cam.y);
      if (dist < 80) {
        if (icons.size() > 0 && col == icons.get(0).col) {
          icons.remove(0);
        }
        remove = true;
      }
    }
    if (pos.z > 600) {
      remove = true;
    }
  }

  void randPos() {
    float ang = random(TWO_PI);
    float r = width*0.8*random(1);
    pos = new PVector(cos(ang)*r, sin(ang)*r, -5000);
  }

  void show() {
    noStroke();
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    box(100);
    popMatrix();
  }
}

class Icon {
  color col;
  Icon() {
    col = rcol();
  }
}

int rcol() {
  return pallet[int(random(pallet.length))];
}