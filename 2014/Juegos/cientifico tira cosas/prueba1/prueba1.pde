int amouseX, amouseY;

ArrayList<Pelota> pelotas;
Camara camara;
PImage img[];

void setup() {
  size(800, 600);
  pelotas = new ArrayList<Pelota>();
  camara = new Camara(0, 0);
  img = new PImage[3];
  for (int i = 0; i < 3; i++) {
    img[i] = loadImage("img/fondo"+i+".png");
  }
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("FPS:"+frameRate);
  background(255);
  camara.act();
  for (int i = 2; i >= 0; i--) {
    image(img[i], int(camara.x/(i+1)-width), int(camara.y/(i+1)-height));
  }
  for (int i = 0; i < pelotas.size(); i++) {
    Pelota aux = pelotas.get(i);
    aux.act();
    if (aux.eliminar) pelotas.remove(i--);
  }
}


void mousePressed() {
  amouseX = mouseX;
  amouseY = mouseY;
}

void mouseReleased() {
  float ang = atan2(amouseY-mouseY, amouseX-mouseX);
  float dis = dist(mouseX, mouseY, amouseX, amouseY);
  pelotas.add(new Pelota(amouseX, amouseY, ang, dis));
}

class Camara {
  float x, y;
  Camara(float x, float y) {
    this.x = x;
    this.y = y;
  }
  void act() {
    x += (mouseX-x)/4;
    y += (mouseY-y)/4;
  }
}

class Pelota {
  boolean eliminar;
  float x, y, x0, y0, ang, vel, velx, vely;
  float g = 9.8/5;
  float time;
  Pelota(float x, float y, float ang, float vel) {
    this.x = x0 = x ; 
    this.y = y0 = y;
    this.ang = ang;
    this.vel = vel = vel/5;
    velx = vel * cos(ang);
    vely = vel * sin(ang);
    time = -1;
    eliminar = false;
  }
  void act() {
    time += 0.5;
    x = x0 + velx * time;
    y = y0 + vely * time + 0.5 * g * (time*time);
    dibujar();
  }

  void dibujar() {
    noStroke();
    fill(255, 14, 6);
    ellipse(x, y, 10, 10);
  }
}

