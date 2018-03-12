int cant = 10;
float tam = 10;
float x[], y[], vel[], col[];

void setup() {
  size(400, 400);
  colorMode(HSB);
  x = new float[cant];
  y = new float[cant];
  vel = new float[cant];
  col = new float[cant];
  tam = height/cant;
  for (int i = 0; i < cant; i++) {
    x[i] = width/2;
    y[i] = i * tam + tam/2;
    vel[i] = random(1, 3);
    col[i] = random(256);
  }
  rectMode(CENTER);
}

void draw() {
  background(200);
  for (int i = 0; i < cant; i++) {
    x[i] += vel[i];
    if (x[i] > width-tam/2 || x[i] < tam/2) {
      vel[i] *= -1;
    }
    fill(col[i], 256, 256);
    rect(x[i], y[i], tam, tam);
  }
}

void mousePressed() {
  int py = int(mouseY/tam);
  if ( mouseX-tam/2 < x[py] && mouseX+tam/2 > x[py]) { 
    col[py] = random(256);
    vel[py] *= -1;
  }
}

