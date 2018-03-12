float x[], y[], tam;
int estado[], col[], cant, vel;

void setup() {
  size(400, 400);
  noStroke();
  smooth();
  colorMode(HSB);
  frameRate(60);
  tam = 40;
  cant = (width/40)/2;
  vel = 5;

  x = new float[cant];
  y = new float[cant];
  estado = new int[cant];
  col = new int[cant];

  for (int i = 0; i < cant; i++) {
    x[i] = i*tam;
    y[i] = i*tam;
    estado[i] = 1;
    col[i] = int(random(256));
  }
}

void draw() {
  fill((col[0]+128)%256, 255, 255, 2);
  rect(0, 0, width, height);

  for (int i = 0; i < cant; i++) {
    if (estado[i] == 1) {
      x[i]+=vel-(i/2);
      if (x[i] >= width-(tam*(i+1))) {
        col[i] = int(random(256));
        estado[i] = 2;
      }
    }
    else if (estado[i] == 2) {
      y[i]+=vel-(i/2);
      if (y[i] >= height-(tam*(i+1))) {
        col[i] = int(random(256));
        estado[i] = 3;
      }
    }
    else if (estado[i] == 3) {
      x[i]-=vel-(i/2);
      if (x[i] <= i*tam) {
        col[i] = int(random(256));
        estado[i] = 4;
      }
    }
    else if (estado[i] == 4) {
      y[i]-=vel-(i/2);
      if (y[i] <= i*tam) {
        col[i] = int(random(256));
        estado[i] = 1;
      }
    }
    fill(col[i], 255, 255);
    rect(x[i], y[i], tam, tam);
  }
}

