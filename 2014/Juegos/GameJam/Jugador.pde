class Jugador {
  boolean salto;
  int frame;
  float x, y, velx, vely, tam, energia;
  Jugador(float x, float y) {
    this.x = x; 
    this.y = y;
    velx = 4; 
    vely = 0;
    tam = 30;
    salto = false;
  } 
  void act() {
    /*
    vida += 0.02;
     if (vida > 20) vida = 20;
     if (tiempoInmunidad > 0) tiempoInmunidad--;
     else inmune = false;
     */
    if(frameCount%2 == 0)frame++;
    frame %= 8;
    float antx = x; 
    float anty = y;
    if (input.IZQUIERDA.press) {
      x -= velx;
    }
    if (input.DERECHA.press) {
      x += velx;
    }
    if (nivel.colisiona(this)) {
      y--; 
      if (nivel.colisiona(this)) {
        x = antx;
        y = anty;
      } 
      anty = y;
    }
    if (input.SALTAR.click && !salto) {
      salto = true;
      vely = -18;
    }
    vely += 1; 
    y += vely;
    if (nivel.colisiona(this)) {
      y = anty;
      salto = false;
      vely = 0;
    }
    dibujar();
  }
  void dibujar() {
    fill(255);
    ellipse(x, y, tam, tam);
    float tam = spritesPersonaje[frame].width/2;
    //image(spritesPersonaje[frame], x-tam/2, y-tam/2, tam, tam);
  }
}
