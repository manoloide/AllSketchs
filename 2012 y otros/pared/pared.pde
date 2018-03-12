ArrayList bombas,disparos;
PImage pared;
int vx,vy;

void setup() {
  size(400, 400);
  background(100);
  smooth();
  frameRate(60);
  bombas = new ArrayList();
  disparos = new ArrayList();
  pared = createImage(width, height, ARGB);
  cargarImagen(pared);
  image(pared, 0, 0);
  circulo(pared,width/2, height/2,10);
}

void draw() {
  background(100);
  image(pared, 0, 0);
  actDis();
  actBom();
}

void mousePressed(){
  disparos.add(new Disparo(width/2, height/2, mouseX, mouseY));
  bombas.add(new Bomba(mouseX, -100));
  //vx = mouseX;
  //vy = mouseY;
}

void mouseReleased() {
  //circulo(pared,vx,vy,int(dist(vx,vy,mouseX,mouseY)));
 // punto(pared, mouseX, mouseY);
}

