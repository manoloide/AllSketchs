class Jugador {
  float x, y, w, h;
  float velocidad;
  int materiales[];
  Jugador(float x, float y) {
    this.x = x; 
    this.y = y;
    materiales = new int[256];
    for(int i = 0; i < materiales.length; i++){
       materiales[i] = 0; 
    }
    w = h = 32;
    velocidad = 2;
  }
  void act() {
    float xx = 0, yy = 0;
    if (input.DERECHA.press) {
      xx += velocidad;
    } else if (input.IZQUIERDA.press) {
      xx -= velocidad;
    } else if (input.ARRIBA.press) {
      yy -= velocidad;
    } else if (input.ABAJO.press) {
      yy += velocidad;
    }
    if (!m.colision(this, xx, yy)) {
      x += xx;
      y += yy;
    }
    if(x < 0) x += m.w * 16;
    if(y < 0) y += m.h * 16; 
  }
  void dibujar() {
    fill(255);
    rect(width/2-w/2, height/2-h/2, w, h);
  }
}
