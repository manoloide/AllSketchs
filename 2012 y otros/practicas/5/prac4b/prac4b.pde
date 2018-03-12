int contador, posX, posY;
float con2, con3;
boolean click = false;

void setup() {
  size(400, 400);
  noFill();
  contador = 0;
  con2 = 0;
  con3 = 0;
}

void draw() {
  background(200);
  if (click) {
    ellipse(posX, posY, contador, contador);
    ellipse(posX, posY, con2, con2);
    ellipse(posX, posY, con3, con3);
    float dis =2*dist(posX,0,width/2,0);
    if (posX > width/2) {
      ellipse(posX-dis, posY, contador, contador);
      ellipse(posX-dis, posY, con2, con2);
      ellipse(posX-dis, posY, con3, con3);
    }else{
      ellipse(posX+dis, posY, contador, contador);
      ellipse(posX+dis, posY, con2, con2);
      ellipse(posX+dis, posY, con3, con3);
    }
    contador++;
    con2 += random(0.1, 0.5);
    con3 += random(0.4, 1);
    if (contador > 100) {
      contador = 0;
      con2 = 0;
      con3 = 0;
      click = false;
    }
  }
}

void mousePressed() {
  if (!click) {
    click = true;
    posX = mouseX;
    posY = mouseY;
  }
}

