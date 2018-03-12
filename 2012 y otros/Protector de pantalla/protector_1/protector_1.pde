ArrayList p;
int cant = 0;
float variacion = 0.1;

void setup() {
  size(screen.width, screen.height);
  frameRate(30);
  noCursor();
  p = new ArrayList();
  colorMode(HSB);
  noStroke();
  background(255);
  smooth();

  for (int i = 0; i < cant; i++) {
    p.add(new Particula(random(width), random(height)));
  }
}

void draw() {
  variacion += 0.1;
  fill(255, 8);
  noStroke();
  rect(0, 0, width, height);

  for (int i = 0; i < cant; i++) {
    Particula aux = (Particula) p.get(i);
    aux.act();
    if (aux.tam > 30) {
      p.remove(i);
      i--;
      cant--;
    }
  }

  if (frameCount%10 == 0) {
    p.add(new Particula(random(width), random(height)));
    cant++;
  }

  //saveFrame("par-####.png"); 
  /*
  if (frameCount > 2800){
   exit(); 
   }
   */
}

void keyPressed() {
  if (frameCount > 2) {
    exit();
  }
}
void mouseMoved() {
  if (frameCount > 2) {
    exit();
  }
}

class Particula {
  float x, y, ang, tam;
  color col, cola;
  Particula(float nx, float ny) {
    x = nx; 
    y = ny;
    ang = random(2*PI);
    col = color(random(256), 256, 256, 40);
    cola = color(hue(col), 256, 256, 20);
    tam = 1;
  }
  void act() {
    ang += noise(variacion+((x-y)/10))-0.5;
    x += cos(ang);
    y += sin(ang);
    if (x < 0) {
      x = width;
    }
    else if ( x > width) {
      x = 0;
    } 
    if (y < 0) {
      y = height;
    }
    else if ( y > height) {
      y = 0;
    }
    draw();
    tam += 0.05;
  }

  void draw() {
    stroke(col);
    fill(cola);
    ellipse(x, y, tam, tam);
  }
}

