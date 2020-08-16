ArrayList<Pelota> pelotas, seleccionados;
int paleta[] = {
  #5A5C75, 
  #492D49, 
  #87555C, 
  #E07A6C, 
  #D1B68D
};

void setup() {
  size(800, 600);
  float sep = 100;
  int cx = int(width/sep)-1;
  int cy = int(height/sep)-1;
  int dx = (width-int((cx-1)*sep))/2;
  int dy = (height-int((cy-1)*sep))/2;
  pelotas = new ArrayList<Pelota>(); 
  seleccionados = new ArrayList<Pelota>(); 
  for (int j = 0; j < cy; j++) {
    for (int i = 0; i < cx; i++) {
      pelotas.add(new Pelota(i*sep+dx, j*sep+dy));
    }
  }
}

void draw() {
  background(40);
  for (int i = 1; i <= seleccionados.size (); i++) {
    Pelota ant = seleccionados.get(i-1);
    Pelota act;
    if(i != seleccionados.size()) 
      act = seleccionados.get(i);
    else
      act = new Pelota(mouseX, mouseY);
    stroke(paleta[ant.col]);
    strokeWeight(5);
    line(ant.x, ant.y, act.x, act.y);
  }
  for (int i = 0; i < pelotas.size (); i++) {
    Pelota p = pelotas.get(i);
    p.update();
    if(p.remove) pelotas.remove(i--);
    if (p.press && seleccionados.indexOf(p) == -1) {
      if (seleccionados.size() == 0 || p.col == (seleccionados.get(0)).col) {
        seleccionados.add(p);
      }
      println("dassdas");
    }
  }
}

void mouseReleased() {
  if (seleccionados.size() > 1) {
    for (int i = 0; i < seleccionados.size (); i++) {
      seleccionados.get(i).remove = true;
    }
  }
  seleccionados = new ArrayList<Pelota>();
}

class Pelota {
  boolean sel, sobre, press, remove;
  float x, y, s;
  int col;
  Pelota(float x, float y) {
    this.x = x;
    this.y = y;
    s = 30;
    col = int(random(paleta.length));
  }
  void update() {
    if (dist(mouseX, mouseY, x, y) < s/2) {
      sobre = true;
    } else {
      sobre = false;
    }
    if (mousePressed && sobre)
      press = true;
    else 
      press = false;
    show();
  }
  void show() {
    stroke(lerpColor(paleta[col], color(240), 0.4));
    strokeWeight(2);
    noStroke();
    fill(paleta[col]);
    if (sobre)
      ellipse(x, y, s*1.1, s*1.1);
    else
      ellipse(x, y, s*1., s*1.);
  }
}
