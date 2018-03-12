class Draco extends Entidad {
  int tiempo;
  Draco(float x, float y) {
    this.x = x; 
    this.y = y;
    tmin = 15;
    tmax = 60;
    tiempo = 0;
    tam = tmax;
    ang = random(TWO_PI);
    col = color(0);
    sonido.s_draco.trigger();
  }
  void act() {
    tiempo++;
    if(tiempo%(60*1.8) == 0) sonido.s_draco.trigger();
    float d = -1;
    Bicho obj = null;
    for (int i = 0; i < entidades.size(); i++) {
      Entidad aux = entidades.get(i);
      if (aux instanceof Bicho) {
        float ad = dist(x, y, aux.x, aux.y);
        if (d == -1 || d > ad) {
          d = ad;
          obj = (Bicho) aux;
        }
      }
    }
    if (obj == null) {
      ang = atan2(jugador.y-y, jugador.x-x);
    }
    else {
      ang = atan2(obj.y-y, obj.x-x);
    }
    
    ang += random(-0.1, 0.1);
    x += cos(ang);
    y += sin(ang);

    for (int i = 0; i < entidades.size(); i++) {
      Entidad aux = entidades.get(i);
      float dis = dist(x, y, aux.x, aux.y);
      if (aux != this && dis < (tam + aux.tam) * 0.6) {
        float sacar = (tam/10000);
        tam += aux.tam * sacar;
        aux.tam -= aux.tam * sacar;
      }
    }

    float dis = dist(x, y, jugador.x, jugador.y);
    if (dis < (tam + jugador.tam) * 0.6) {
      float sacar = (tam/10000);
      //tam += jugador.tam * sacar;
      jugador.tam -= jugador.tam * sacar;
    }

    if (tam < tmin) eliminar = true;
    if (tam < tmax) tam += 0.01;
    if (tam > tmax) tam = tmax;

    if (x < -tam) x += width + tam*2;
    if (x >= width + tam) x = -tam;
    if (y < -tam) y += height + tam*2;
    if (y >= height + tam) y = -tam;
    dibujar();
  }
  void dibujar() {
    float t = tam*1.9;
    image(img_draco[(frameCount/10)%4], x-t/2, y-t/2, t, t);
    /*
    noStroke();
    fill(col);
    ellipse(x, y, tam, tam);
    */
  }
}
