ArrayList giradores;
int col, ran, can;
girador g1, g2, g3;

void setup() {
  size(600, 600); 
  colorMode(HSB);
  smooth();
  noStroke();
  iniciar();
  background((col+128)%256, 255, 255);
  ran = 10;
  can = 20;
  giradores = new ArrayList();
  for (int i = 0; i < can; i++) {
    giradores.add(new girador());
  }
}

void draw() {
  fill((col+128)%256, 255, 255, 5);
  rect(0, 0, width, height);
  for (int j = 0; j < height/ran; j++) {
    for (int i = 0; i < width/ran; i++) {
      if (random(2) > 1) {
        fill((col+128)%256, 255, 255, 10);
      }
      else {
        fill(col, 255, 255, 10);
      }
      rect(ran*i, ran*j, ran, ran);
    }
  } 
  for (int i = 0; i < can; i++) {
    girador aux = (girador) giradores.get(i);
    aux.act();
  }
  //cambio de color
  col += int(random(-1, 2));
  col = col%256;
}

void keyPressed() {
  if (key == 'r') {
    iniciar();
  }
}

void iniciar() {
  col = int(random(256));
  background((col+128)%256, 215, 255);
}

class girador {
  float x, y, ang, vel, rad, dim;
  girador() {
    x = random(width);
    y = random(height);
    ang = random(TWO_PI);
    vel = 1;
    dim = random(20, 200);
    rad = dim/2;
  } 
  void act() {
    //mueve
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    //aleja del mouse
    float distancia = dist(x, y, mouseX, mouseY);
    if (distancia < dim) {
      float angu = atan2(mouseY-y, mouseX-x);
      float velo = (dim - distancia)/10;
      x -= cos(angu)*velo;
      y -= sin(angu)*velo;
    }
    //controla los bordes...
    if (x > width+rad) {
      x = -rad;
    }
    else if (x < -rad) {
      x = width+rad;
    }

    else if (y > height+rad) {
      y = -rad;
    }

    else if (y < -rad) {
      y = height+rad;
    }
    //color aleatorio
    if (random(2) > 1) {
      fill((col+128)%256, 255, 255, 100);
    }
    else {
      fill(col, 255, 255, 100);
    }
    //dibuja
    ellipse(x, y, dim, dim);
    ang += random(-0.1, 0.1);
    ang = ang%TWO_PI;
  }
}

