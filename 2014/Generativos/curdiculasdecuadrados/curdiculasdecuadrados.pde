ArrayList<Cubito> cubitos;
void setup() {
  size(600, 600);
  smooth(8);
  cubitos = new ArrayList<Cubito>();
  generar(0, 0, width, height, 5);
}

void draw() {
  background(255);
  for (int i = 0; i < cubitos.size(); i++) {
    Cubito aux = cubitos.get(i);
    aux.act();
  }
}

void keyPressed() {
  if ( key == 's') {
    saveFrame("####");
  }
  else {
    cubitos = new ArrayList<Cubito>();
    generar(0, 0, width, height, 5);
  }
}

void generar(float x, float y, float w, float h, int n) {
  cubitos.add(new Cubito(x, y, w, h));
  n--;
  if (n > 0) {
    if (random(5) < n) generar(x, y, w/2, h/2, n);
    if (random(5) < n) generar(x+w/2, y, w/2, h/2, n);
    if (random(5) < n) generar(x, y+h/2, w/2, h/2, n);
    if (random(5) < n) generar(x+w/2, y+h/2, w/2, h/2, n);
  }
}

class Cubito {
  boolean eliminar;
  color s, f;
  int dir;
  float esp, min_esp, max_esp, vel, des;
  float x, y, w, h;
  Cubito(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w;
    this.h = h;
    min_esp = int(random(1, 20));
    max_esp = int(random(20, 60));
    esp = random(min_esp, max_esp);
    vel = random(0.1, 0.4);
    dir = int(random(4));
    if (random(10) < 5) {
      s = color(0);
      f = color(255);
    }
    else {
      s = color(255);
      f = color(0);
    }
  }
  void act() {
    des += 0.01;
    if (des > 1) des = 0;
    esp += vel;
    if (esp > max_esp) esp = min_esp;
    dibujar();
  }
  void dibujar() {
    noStroke();
    fill(f);
    rect(x, y, w, h);
    stroke(s);
    rectLine(x, y, w, h, esp, des, dir);
  }
}


void rectLine(float x, float y, float w, float h, float esp, float des, int dir) {
  strokeCap(SQUARE);
  if (dir == 0) {
    for (int i = int(esp*des); i < h; i+=esp) {
      line(x, y+i, x+w, y+i);
    }
  }
  else if (dir == 1) {
    for (int i = int(esp*des); i < w+h; i+=esp) {
      if (i < h) {
        if (x+i <= x+w) line(x, y+h-i, x+i, y+h);
        else line(x, y+h-i, x+w, y+h-i+w);
      }
      else {
        if (y-i+h+w <= y+h) line(x+i-h, y, x+w, y-i+h+w);
        else line(x+i-h, y, x+i, y+h);
      }
    }
  }
  else if (dir == 2) {
    for (int i = int(esp*des); i < w; i+=esp) {
      line(x+i, y, x+i, y+h);
    }
  }  
  else if (dir == 3) {
    for (int i = int(esp*des); i < w+h; i+=esp) {
      if (i < h) {
        if (x+i <= x+w) line(x+w, y+h-i, x+w-i, y+h);
        else line(x, y+h-i+w, x+w, y+h-i);
      }
      else {
         if (y-i+h+w <= y+h) line(x, y+h-i+w, x-i+w+h, y);
         else line(x-i+w+h, y, x-i+w, y+h);
      }
    }
  }
}
