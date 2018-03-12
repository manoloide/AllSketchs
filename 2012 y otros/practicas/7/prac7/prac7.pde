int cant = 10;
int tam = 10;
int x[], y[], vel[];

void setup() {
  size(400, 400);
  x = new int[cant];
  y = new int[cant];
  vel = new int[cant];
  tam = height/cant;
  for (int i = 0; i < cant; i++) {
    x[i] = width/2;
    y[i] = i * tam + tam/2;
    vel[i] = 1;
  }
  rectMode(CENTER);
}

void draw() {
  for (int i = 0; i < cant; i++) {
    x[i] += vel[i];
    if (x[i] > width-tam/2 || x[i] < tam/2) {
      vel[i] *= -1;
    }
    rect(x[i],y[i],tam,tam);
  }
}

