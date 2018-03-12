float dim, rad, y, vely, diry, x, velx, dirx;
void setup() {
  size(400, 480);
  smooth();
  background(0);
  dim = 200;
  rad = dim/2;
  y = 200;
  x = width/2;
  dirx= -1;
  velx = 1;
  diry= -1;
  vely = 1;
}

void draw() {
  background(0);
  x += velx * dirx;
  y += vely * diry;
  ellipse(x, y, dim, dim);
  if (x > width-rad || x < rad) {
    print("perdiste");
  }
  if (y > width-rad || y < rad) {
    print("perdiste");
  }
  //dibujar botones
  noStroke();
  fill(40);
  rect(0, 400, width, 80);
  fill(200);
  rect(170, 430, 20, 20);
  rect(210, 430, 20, 20);
  rect(190, 410, 20, 20);
  rect(190, 450, 20, 20);
  fill(255);
}

void mousePressed() {
  if (mouseX > 170 && mouseX < 190 && mouseY > 430 && mouseY < 450) {
    dirx= -1;
  }
  if (mouseX > 210 && mouseX < 230 && mouseY > 430 && mouseY < 450) {
    dirx= 1;
  }
  if (mouseX > 190 && mouseX < 210 && mouseY > 410 && mouseY < 430) {
    diry= -1;
  }
  if (mouseX > 190 && mouseX < 210 && mouseY > 450 && mouseY < 470) {
    diry= 1;
  }
}

