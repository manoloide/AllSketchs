ArrayList<Fila> filas;
color paleta[];

void setup() {
  size(600, 800);
  smooth(8);
  paleta = new color[5];
  paleta[0] = color(#556270);
  paleta[1] = color(#4ECDC4);
  paleta[2] = color(#C7F464);
  paleta[3] = color(#FF6B6B);
  paleta[4] = color(#C44D58);
  filas = new ArrayList<Fila>();
  for (int i = 0; i < 9; i++) {
    Fila aux = new Fila(0, i*80, width, 80);
    filas.add(aux);
  }
}

void draw() {
  background(0);
  float h = 0;
  for (int i = 0; i < filas.size(); i++) {
    Fila aux = filas.get(i);
    aux.y = h;
    aux.act();
    h += aux.h;
  }
}

class Fila {
  boolean eliminar, sobre;
  color col, cluz, csom; 
  float x, y, w, h, hmin, hmax;
  int time;
  Fila(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w;
    this.h = h;
    hmin = h;
    hmax = h*2;
    col = paleta[int(random(paleta.length))];
    colorMode(HSB);
    cluz = color(hue(col), saturation(col)-20, brightness(col)+20);
    csom = color(hue(col), saturation(col), brightness(col)-20);
    colorMode(RGB);
  }
  void act() {
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) {
      if (!sobre) {
        time = 0;
        sobre = true;
      }
      if (time < 30) time += 1;
    }
    else {
      if (sobre) {
        time = 30;
        sobre = false;
      }
      if (time > 0) time--;
    }
    if (h < hmax && sobre) { 
      float vel = abs(map((hmax-h), 0, hmax-hmin, -1, 1))*10;
      vel = (hmax-h)/6;
      h += vel;
    }
    if (!sobre && h > hmin) {
      //float vel = abs(map((h-hmin),0,hmax-hmin,-1,1))*10;
      float vel = (h-hmin)/6;
      h -= vel;
    }
    dibujar();
  }
  void dibujar() {
    strokeWeight(1);
    noStroke();
    fill(col);
    rect(x, y, w, h);
    stroke(cluz);
    line(x, y, x+w, y);
    stroke(csom);
    line(x, y+h-1, x+w, y+h-1);
    noStroke();
    fill(255, time);
    rect(x, y, w, h);
    /*
    stroke(255, 50);
    triangle(x+w*0.25, y, x+w*0.75, y, w*0.5, y+w*0.25);*/
    if (time > 0) {
      noStroke();
      fill(255, 200);
      float dx = -30 + sin((time/30.)*(PI/2))*80;
      triangle(x+dx, y+h*0.25, x+dx, y+h*0.75, x+dx+h*0.25, y+h*0.5);
    }
  }
}
