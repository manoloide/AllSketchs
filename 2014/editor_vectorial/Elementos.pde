class Elemento {
  boolean bloqueado, eliminar, seleccionado, visible;
  color fill, stroke;
  float x, y, w, h;
  float strokeTam;
  String nombre;
  Elemento() {
    fill = color(240);
    stroke = color(0);
    strokeTam = 1;
    bloqueado = false;
    eliminar = false;
    seleccionado = false;
    visible = true;
  }
  void act() {
  }
  void dibujar() {
  }
  void dibujarSeleccion() {
    noFill();
    strokeWeight(1);
    stroke(70, 120, 230);
  }
  void move(float mx, float my){
    x += mx;
    y += my;
  }
  boolean sobre(float x1, float y1, float x2, float y2) {
    float ax = max(x1, x2);
    float ay = max(y1, y2);
    x1 = min(x1, x2);
    y1 = min(y1, y2);
    x2 = ax;
    y2 = ay;
    float w2 = x2-x1;
    float h2 = y2-y1;
    if (this instanceof Ellipse) return colisionRect(x, y, w, h, x1+w2/2, y1+h2/2, w2, h2);
    return colisionRect(x+w/2, y+h/2, w, h, x1+w2/2, y1+h2/2, w2, h2);
  }
  boolean sobre(float x, float y) {
    return sobre(x, y, x, y);
  }
};

class Ellipse extends Elemento {
  Ellipse(float x, float y, float w, float h, String nombre) {
    super();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nombre = nombre;
    if (nombre.equals("")) {
      int cant = 1;
      for (int i = 0; i < elementos.size(); i++) {
        if (elementos.get(i) instanceof Ellipse) cant++;
      }
      nombre = "ellipse_"+cant;
    }
  }
  Ellipse(float x, float y, float w, float h) {
    this(x, y, w, h, "");
  }
  Ellipse(float x, float y, float d) {
    this(x, y, d, d, "");
  }
  void act() {
    if (visible) dibujar();
  }
  void dibujar() {
    fill(fill);
    strokeWeight(strokeTam);
    stroke(stroke);
    ellipse(x, y, w, h);
    if (seleccionado) {
      noFill();
      strokeWeight(0.8);
      stroke(70, 120, 230);
      ellipse(x, y, w, h);
    }
  }
};

class Line extends Elemento {
  float x1, y1, x2, y2;
  Line(float x1, float y1, float x2, float y2, String nombre) {
    super();
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.nombre = nombre;
    x = min(x1, x2);
    y = min(y1, y2);
    w = abs(x1-x2);
    h = abs(y1-y2);
    if (nombre.equals("")) {
      int cant = 1;
      for (int i = 0; i < elementos.size(); i++) {
        if (elementos.get(i) instanceof Rect) cant++;
      }
      nombre = "line_"+cant;
    }
  }
  Line(float x1, float y1, float x2, float y2) {
    this(x1, y1, x2, y2, "");
  }
  void act() {
    if (visible) dibujar();
  }
  void dibujar() {
    strokeWeight(strokeTam);
    stroke(stroke);
    line(x1, y1, x2, y2);
    if (seleccionado) {
      strokeWeight(0.8);
      stroke(70, 120, 230);
      line(x1, y1, x2, y2);
    }
  }
};

class Rect extends Elemento {
  Rect(float x, float y, float w, float h, String nombre) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.nombre = nombre;
    if (nombre.equals("")) {
      int cant = 1;
      for (int i = 0; i < elementos.size(); i++) {
        if (elementos.get(i) instanceof Rect) cant++;
      }
      nombre = "rect_"+cant;
    }
  }
  Rect(float x, float y, float w, float h) {
    this(x, y, w, h, "");
  }
  void act() {
    if (visible) dibujar();
  }
  void dibujar() {
    fill(fill);
    strokeWeight(strokeTam);
    stroke(stroke);
    rect(x, y, w, h);    
    if (seleccionado) {
      noFill();
      strokeWeight(0.8);
      stroke(70, 120, 230);
      rect(x, y, w, h);
    }
  }
};
