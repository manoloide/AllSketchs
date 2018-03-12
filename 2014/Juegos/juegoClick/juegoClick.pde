ArrayList<Cargador> cargadores;
boolean click = false;

int puntos; 

void setup() {
  size(480, 680);
  cargadores = new ArrayList<Cargador>();
  cargadores.add(new Cargador(width/2, height/2, 120));
  cargadores.add(new Cargador(width/2, height/2-180, 120));
  cargadores.add(new Cargador(width/2, height/2+180, 120));
}

void draw() {
  background(8);
  /*
  for(int i = 0; i < width; i++){
     line(i, height, i, height-pow(1.01,int(i+1))); 
  }
  */
  for (int i = 0; i < cargadores.size (); i++) {
    Cargador c = cargadores.get(i);
    c.update();
  }
  fill(100);
  textSize(32);
  textAlign(CENTER, TOP);
  text(puntos, width/2, 30);
  click = false;
}

void mouseClicked() {
  click = true;
}

class Cargador {
  boolean sobre, press;
  color col;
  float x, y, d;
  float carga, nivel;
  float timeSobre;
  Cargador(float x, float y, float d) {
    this.x = x;
    this.y = y;
    this.d = d;
    sobre = false;
    col = color(#02F762);
  }
  void update() {
    if (dist(x, y, mouseX, mouseY) < d/2) {
      sobre = true;
      timeSobre = min(timeSobre+0.1, 1);
    } else {
      sobre = false;
      timeSobre = max(timeSobre-0.1, 0);
    }
    press = false;
    if (sobre && click) {
      press = true;
      nivel += 0.6/pow(1.2, int(nivel+1));
    }
    float auxCar = 0.001*pow(1.1,int(nivel+1));
    if(sobre) auxCar *= 2;
    carga += auxCar;
    if (carga > 1) {
      carga = 0;
      puntos += 1;
    }
    show();
  }
  void show() {
    color col = this.col;
    if (press) col = color(255);
    float gro = d*0.02;
    float dd = d*map(sin(timeSobre*PI*0.5), 0, 1, 1, 0.6);
    fill(col, 70);
    noStroke();
    ellipse(x, y, dd, dd);
    arc(x, y, dd, dd, PI*0.5-PI*carga, PI*0.5+PI*carga, 2);
    dd = dd-gro;
    stroke(col, 120);
    strokeWeight(gro);
    ellipse(x, y, dd, dd);

    noFill();
    stroke(255);
    gro = d*0.02;
    dd = d-gro;
    strokeWeight(gro*timeSobre);
    strokeCap(SQUARE);
    float ang = PI*(nivel%1);
    arc(x, y, d+sin(timeSobre*PI/2)*d*0.2-gro, d+sin(timeSobre*PI/2)*d*0.2-gro, PI*1.5-ang, PI*1.5+ang);
  }
}
