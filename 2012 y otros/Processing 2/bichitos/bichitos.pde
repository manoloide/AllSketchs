ArrayList<Destino> destinos;
ArrayList<Bichito> bichitos;

int cantb = 300;
int cantd = 10;

void setup() {
  size(640, 480);

  destinos = new ArrayList<Destino>();
  bichitos = new ArrayList<Bichito>();

  for (int i = 0; i < cantd; i++) {
    destinos.add(new Destino(random(width), random(height)));
  }

  noStroke();
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);
  for (int i = 0; i < bichitos.size(); i++) {
    Bichito b =  bichitos.get(i);
    b.act();
    if (b.borrar) {
      bichitos.remove(i--);
    }
  }
  for (int i = 0; i < destinos.size(); i++) {
    Destino d = destinos.get(i);
    d.act();
    if (d.borrar) {
      destinos.remove(i--);
    }
  }
  if (frameCount <= cantb) {
    bichitos.add(new Bichito(width/2, height/2));
  }
  fill(0);
  text("cant bichos:"+bichitos.size(),6,16);
  fill(255);
  text("cant bichos:"+bichitos.size(),5,15);
}

class Bichito {
  boolean borrar;
  float x, y;
  Destino d; 
  Bichito(float x, float y) {
    this.x = x; 
    this.y = y;
    d = nueDestino();
  }
  void act() {
    //mover 
    float ang = atan2(d.y-y, d.x-x);
    x += cos(ang) + random(-0.3, 0.3);
    y += sin(ang) + random(-0.3, 0.3);
    if (dist(x, y, d.x, d.y) < d.tam/2) {
      if (d.tam < 10) {
        borrar = true; 
        d.ener += 10;
      }
      else {
        x = d.x;
        y = d.y;
        d = nueDestino();
      }
    }
    //dibujar
    fill(240, 9, 84);
    ellipse(x, y, 2, 2);
  }

  Destino nueDestino() {
    if ( d != null) {
      d.ener++;
    }
    return destinos.get(int(random(destinos.size())));
  }
}

class Destino {
  boolean borrar = false;
  float x, y, tam, ener;
  Destino(float x, float y) {
    this.x = x;
    this.y = y;
    ener = 40;
  }

  void act() {
    if (ener > 0) {
      ener-=0.1;
    }
    else {
      borrar = true;
    }
    if (ener > 50) {
      bichitos.add(new Bichito(x, y));
      ener-=10;
    }
    //dibujar
    tam = ener;
    fill(255);
    ellipse(x, y, tam, tam);
  }
}

