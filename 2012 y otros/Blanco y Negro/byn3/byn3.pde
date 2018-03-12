float valores[];

int cant = 400;
int maxi = 20;
float ruidin = 0.02;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
  valores = new float[cant];
  for (int i = 0; i < cant; i++) {
    valores[i] = random(maxi);
  }
}

void draw() {
  ruidin += 0.002;
  //ruidin %= 1;
  fill(0, 10);
  //rect(0, 0, width, height);

  fill(255, 140);
  for (int i = 0; i < cant; i+=2) {
    float vX = valores[i];
    float vY = valores[i+1];
    ellipse(noise(ruidin*vX)*width, noise(ruidin*vY)*height, 2, 2);
  }
}

