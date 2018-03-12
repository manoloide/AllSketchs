class Particula {
  boolean eliminar;
  color col; 
  int tmin, tmax;
  float x, y, tam, ang, vel; 
  void act() {
  }
  void dibujar() {
  }
}

class Luces extends Particula {
  int periodo;
  float osc;
  Luces(float x, float y) {
    this.x = x;
    this.y = y;
    tam = random(1,8);
    ang = random(TWO_PI);
    vel = random(0.001, 0.12);
    periodo = int(random(60,180));
    eliminar = false;
  }
  void act() {
    osc = sin(((abs(frameCount%periodo)*1./periodo-0.5)*2)*TWO_PI);
    
    ang += random(-0.1, 0.1);
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    if (x < -tam) x += width + tam*2;
    if (x >= width + tam) x = -tam;
    if (y < -tam) y += height + tam*2;
    if (y >= height + tam) y = -tam;
    dibujar();
  }
  void dibujar() {
    noStroke();
    fill(0,0,255,30+score.avance*140);
    float cre = score.avance*2;
    ellipse(x, y, tam+osc/2+cre, tam+osc/2+cre);
  }
}
