ArrayList misiles;
PImage suelo;
float px, py;

void setup() {
  size(600, 600);
  frameRate(60);
  noStroke();

  suelo = createImage(width, height, ARGB);
  rectImg(suelo, 0, 100, width, height);

  misiles = new ArrayList();
  //misiles.add(new Misil(10, 400, 200, 300));
}

void draw() {
  //fondo
  background(0);
  //dibujar suelo
  image(suelo, 0, 0);
  //dibujar misiles
  fill(255);
  actMis();
}


void mousePressed() {
  px = mouseX;
  py = mouseY;
}

void mouseReleased() {
  float vx, vy, dis, ang;

  dis = dist(mouseX, mouseY, px, py);
  ang = atan2(mouseY-py, mouseX-px);
  if (mouseY > py) {
    vx = px - cos(ang)*dis;
    vy = py - sin(ang)*dis;
  } else{
    vx = mouseX;
    vy = mouseY;
  }
  misiles.add(new Misil(px, py, vx, vy));
}

