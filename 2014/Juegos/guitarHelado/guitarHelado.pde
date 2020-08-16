/*

 
 no dibujar notas al pedo
 agregar extension a las notas
 
 */

int paleta[] = {
  -13774701, 
  -74949, 
  -1204433, 
  -5076934, 
  -80463, 
  -94591
};

ArrayList<Nota> notas;
boolean play;
String teclas = "asdjkl";
String teclasPresionadas = "";

int cantidadFilas = paleta.length;
int puntos, bonus;
float tiempo;

PFont helve;

void setup() {
  size(720, 480);
  frameRate(-1);
  helve = createFont("Helvetica Neue Bold", 64, true);
  notas = new ArrayList<Nota>();
  float time = 2;
  float intervalos[] = {
    0.125, 0.25, 0.5, 1, 2
  };
  for (int i = 0; i < 120; i++) {
    int c = int(1 + random(1.2));
    for (int j = 0; j < c; j++) {
      notas.add(new Nota(int(random(cantidadFilas)), time));
    }
    time += intervalos[c+int(random(3))];
  }
}

void draw() {
  if (frameCount%10 == 0) frame.setTitle("fps: "+frameRate);
  if (play) tiempo += 1./frameRate;
  float ww = width/cantidadFilas;
  for (int i = 0; i < cantidadFilas; i++) {
    noStroke();
    fill(paleta[i]);
    rect(ww*i, 0, ww, height);
  }

  for (int i = 0; i < notas.size (); i++) {
    Nota n = notas.get(i);
    n.update();
  }

  for (int i = 0; i < cantidadFilas; i++) {
    boolean press = (teclasPresionadas.indexOf(teclas.charAt(i)) != -1);
    stroke(250);
    if (press) stroke(0, 255, 0);
    strokeWeight(4);
    fill(255, 80);
    rect(ww*(i+0.2), height-ww*0.9, ww*0.6, ww*0.6, 6);
  }


  noStroke();
  fill(0, 80);
  rect(0, 0, width, 68);
  fill(5);
  textFont(helve);
  textAlign(LEFT, TOP);
  text(nf(puntos, 4), 20, 10);
  textAlign(CENTER, TOP);
  text(nf(int(tiempo), 3), width/2, 10);
  textAlign(RIGHT, TOP);
  text(bonus+"x", width-20, 10);
}

void keyPressed() {
  if (!play) {
    play = true;
    tiempo = 0;
  }
  if (teclasPresionadas.indexOf(key) == -1) {
    teclasPresionadas += key;
    boolean mataste = false;
    for (int i = 0; i < notas.size (); i++) {
      Nota n = notas.get(i);
      if (!n.tocada && abs(tiempo-n.time) < 0.2 && teclas.charAt(n.nota) == key) {
        bonus++;
        n.tocada = true;
        mataste = true;
        break;
      }
    }
    if (!mataste) {
      bonus = 0;
    }
  }
}

void keyReleased() {
  if (teclasPresionadas.indexOf(key) != -1) {
    int ind = teclasPresionadas.indexOf(key);
    String aux = teclasPresionadas.substring(0, ind);
    if (ind < teclasPresionadas.length())
      aux += teclasPresionadas.substring(ind+1);
    teclasPresionadas = aux;
  }
}

class Nota {
  boolean tocada;
  int nota; 
  float time;
  Nota(int nota, float time) {
    this.nota = nota;
    this.time = time;
    tocada = false;
  }
  void update() {
    if (!tocada && tiempo-time > 0.2) {
      bonus = 0;
      tocada = true;
    }
    draw();
  }
  void draw() {
    float ww = width/cantidadFilas;
    float xx = ww*(nota+0.2);
    float yy = map(time, tiempo, tiempo+1, height-ww*0.9, 0);
    strokeWeight(4);
    stroke(250);
    if (tocada) fill(0, 255, 0, 80);
    else fill(255, 180);
    rect(xx, yy, ww*0.6, ww*0.6, 6);
  }
}
