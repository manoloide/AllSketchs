class Hueso {
  float lar;
  Punto p1, p2;
  //genera hueso vertial centrado en el punto con dos puntos
  Hueso(float nx, float ny, float nl) {
    lar = nl;
    p1 = new Punto(nx, ny-nl/2);
    p2 = new Punto(nx, ny+nl/2);
  }
  //actualiza el dibujo, y los dos "botones" o puntos
  void act() {
    background(80);
    draw();
    //mover puntos
    if (p1.press) {
      float ang = atan2(p2.y-mouseY, p2.x-mouseX);
      p1.x = p2.x - cos(ang)*lar;
      p1.y = p2.y - sin(ang)*lar;
    }
    if (p2.press) {
      float ang = atan2(p1.y-mouseY, p1.x-mouseX);
      p2.x = p1.x - cos(ang)*lar;
      p2.y = p1.y - sin(ang)*lar;
    }  
    //actualizar los puntos.
    p1.act();
    p2.act();
  }
  //dibuja el hueso
  void draw() {
    stroke(0);
    strokeWeight(10);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

class Punto {
  float x, y;
  boolean press = false;
  Punto(float nx, float ny) {
    x = nx;
    y = ny;
  }
  void act() {
    click();
    draw();
  }
  //click del mouse para sobre el puntos, cambia la variable press
  void click() {
    if (!press && mousePressed && dist(mouseX, mouseY, x, y) < 10) {
      press = true;
    }
    else {
      if (!mousePressed) {
        press = false;
      }
    }
  }
  //dibuja el punto y cambia el interior dependiendo de 
  void draw() {
    noStroke();
    fill(0);
    ellipse(x, y, 20, 20);
    if (press) {
      fill(0, 255, 0);
    }
    else {
      fill(250);
    }
    ellipse(x, y, 10, 10);
  }
}

