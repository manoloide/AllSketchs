int paleta[] = {
  #512B52, 
  #635274, 
  #7BB0A8, 
  #A7DBAB, 
  #E4F5B1
};

ArrayList<Quad> quads;

void setup() {
  size(1280, 720); 
  frameRate(30);
  quads = new ArrayList<Quad>();
  //generar();
  background(255, 0, 0);
}

void draw() {
  for(int i = 0; i < 20; i++) agregar();
  for (int i = 0; i < quads.size (); i++) {
    Quad q =  quads.get(i);
    q.update();
    if (q.eliminar) quads.remove(i--);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  quads = new ArrayList<Quad>();
  int maxx = 10;
  int cantidad = 4000;
  int tt = int(pow(2, maxx));
  for (int j = 1; j <= maxx+1; j++) {
    for (int i = 0; i < cantidad/tt; i++) {
      int x = int(random(width/tt+1))*tt;
      int y = int(random(height/tt+1))*tt;
      quads.add(new Quad(x, y, tt, rcol()));
    }
    tt /= 2;
  }
}

class Quad {
  boolean eliminar;
  color col, nue;
  float x, y, t, time;
  float cambiarColor, tiempoVida, tiempoCambio;
  Quad(float x, float y, float t, color col) {
    this.x = x; 
    this.y = y;
    this.t = t;
    this.col = col;
    nue = rcol();
    time = 0;
    tiempoCambio = random(1, 2);
    cambiarColor = time + random(0, 5);
    tiempoVida = random(3, 10);
  }
  void update() {
    time += 1./30;
    if (time > cambiarColor) {
      float p = time-cambiarColor;
      col = lerpColor(col,nue,p/tiempoCambio);
      if (p > tiempoCambio) {
        nue = rcol();
        cambiarColor = time + random(2, 5);
      }
    }else{
     if (time > tiempoVida) eliminar = true; 
    }
    show();
  }
  void show() {
    
    stroke(0, 8);
     for (int s = 3; s >= 1; s--) {
     strokeWeight(s);
     rect(x, y, t, t);
     }
     
    noStroke();
    fill(col);
    rect(x, y, t, t);
  }
}

void agregar() {
  int maxx = 10;
  int tt = int(pow(2, int(random(1, maxx))));
  int x = int(random(width/tt+1))*tt;
  int y = int(random(height/tt+1))*tt;

  for (int i = 0; i < quads.size (); i++) {
    if (quads.get(i).t < tt) {
      quads.add(i, new Quad(x, y, tt, rcol()));
      return;
    }
  }
  quads.add(new Quad(x, y, tt, rcol()));
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length;
  saveFrame(nf(n, 3)+".png");
}
