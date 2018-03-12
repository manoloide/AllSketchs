class Entidad {
  boolean eliminar;
  color col; 
  int tmin, tmax;
  float x, y, tam, ang; 
  void act() {
  }
  void dibujar() {
  }
}

class Bicho extends Entidad {
  Bicho(float x, float y, float tam) {
    this.x = x; 
    this.y = y; 
    this.tam = tam;
    tmin = 15;
    tmax = 90;
    ang = random(TWO_PI);
    col = color(random(256), random(256), random(256));
  }
  void act() {
    ang += random(-0.1, 0.1);
    x += cos(ang);
    y += sin(ang);

    if (tam < tmin) eliminar = true;
    if (tam > tmax) {
      if (random(60) <= 1) { 
        tam -= 1;
        entidades.add(new Bicho(x, y, tmin));
      }
    }
    else {
      tam += 0.015;
    }

    if (x < -tam) x += width + tam*2;
    if (x >= width + tam) x = -tam;
    if (y < -tam) y += height + tam*2;
    if (y >= height + tam) y = -tam;
    dibujar();
  }
  void dibujar() {
    float h = (512 - map(tam, tmin, tmax, 60, 256))%256;
    col = color(h, 200, 200);
    int f = int(map(tam,tmin,tmax,0,17));
    if(f < 0) f = 0;
    if(f > 16) f = 16;
    float t = tam*1;
    image(img_comida[f], x-t/2, y-t/2, t, t);
    /*
    stroke(col);
     col = color(h, 200, 200, 140);
     fill(col);
     ellipse(x, y, tam, tam);
    */
  }
} 
