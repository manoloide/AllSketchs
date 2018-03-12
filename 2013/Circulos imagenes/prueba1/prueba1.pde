boolean dibujar;
color c1, c2;
int ax, ay, px, py, cant;
float dist;
PImage ori;


void setup() {
  size(1280, 716);
  ori = loadImage("..//vilma.jpg");
  dibujar = false;
  background(255);
}

void draw() {
  //image(ori, 0, 0);
  if (dibujar) {
    for (int i = 0; i < 100; i++) {
      coso(px, py, (dist/3)*2, random(1), cant, dist/3, dist(mouseX, mouseY, px, py)/30, lerpColor(c1, c2, random(1)));
    }
  }
}

void mousePressed() {
  dibujar = false;
  px = mouseX;
  py = mouseY;
}
void mouseReleased() {
  ax = mouseX;
  ay = mouseY;
  dist = dist(px, py, ax, ay);
  cant = int(random(5, 92));
  c1 = ori.get(px, py);
  c2 = ori.get(ax, ay);
  if (dist > 2) {
    dibujar = true;
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("circulo_"+hour()+"_"+minute()+"_"+second()+".png");
  }
}
void coso(float cx, float cy, float anc, float pos, int cant, float anc2, float tam, color col) {
  float ang = pos*TWO_PI;
  float nang = map(pos, 0, 1, 0, TWO_PI*cant);
  float x = cx+cos(ang)*anc+cos(nang)*anc2;
  float y = cy+sin(ang)*anc+sin(nang)*anc2;
  float dis = dist(x, y, cx, cy);
  noStroke();
  //fill(0+cos(ang)*80+sin(ang)*20, map(dis, 40, 280, 180, 255), map(dis, 40, 280, 200, 80));
  if (x >= 0 && x < width && y >= 0 && y < height) {
    fill(lerpColor(col,ori.get(int(x), int(y)),0.7));
    ellipse(x, y, tam, tam);
  }
}

