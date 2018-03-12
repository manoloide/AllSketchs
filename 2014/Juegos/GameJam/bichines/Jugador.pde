class Jugador { //<>//
  boolean eliminar, absorve, ruido;
  int tmin, tmax;
  float x, y, vel, velx, vely, tam;
  Jugador(float x, float y) {
    this.x = x; 
    this.y = y;
    tmin = 20;
    tam = 50;
    vel = 0.1;
    velx = 0;
    vely = 0;
    absorve = false;
  }
  void act() {
    if (entidades.size() > 0) tam *= 0.999;
    else tam *= 0.98;
    if (tam <= tmin) eliminar = true;
    if (eliminar) sonido.s_muerte.trigger();

    /*moverse con teclas
     if (input.ARRIBA.press) vely -= vel;
     else if (input.ABAJO.press) vely += vel;
     else vely /= 1.1;
     if (input.IZQUIERDA.press) velx -= vel;
     else if (input.DERECHA.press) velx += vel;
     else velx /= 1.1;
     
     x += velx;
     y += vely;
     */
    float ang = atan2(mouseY-y, mouseX-x);
    float adis = dist(x, y, mouseX, mouseY);
    float vel = adis*0.08;
    if(vel > 30) vel = 30;
    x += cos(ang)*vel;
    y += sin(ang)*vel;

    if (x < -tam) x += width + tam*2;
    if (x >= width + tam) x = -tam;
    if (y < -tam) y += height + tam*2;
    if (y >= height + tam) y = -tam;

    absorve = false;
    for (int i = 0; i < entidades.size(); i++) {
      Entidad aux = entidades.get(i);
      float dis = dist(x, y, aux.x, aux.y);
      if (dis < (tam + aux.tam) * 0.6) {
        absorve = true;
        if (frameCount%40 == 0) sonido.s_absorcion.trigger();
        float sacar = (tam/10000);
        tam += aux.tam * sacar;
        aux.tam -= aux.tam * sacar;
        score.energia += aux.tam * sacar; 
      }
    }
    dibujar();
  }
  void dibujar() {
    //fill(255,50);
    //ellipse(x, y, tam, tam);
    float t = tam*1.9;
    if (absorve) image(img_jugador[(frameCount/5)%3+12], x-t/2, y-t/2, t, t);
    image(img_jugador[(frameCount/5)%12], x-t/2, y-t/2, t, t);
  }
}
