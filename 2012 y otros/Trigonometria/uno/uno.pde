float[] linea;
float periodo, amplitud;

void setup() {
  size(600, 400);
  linea = new float[width+1];
  for (int i = 0; i <= width; i++) {
    linea[i] = 0;
  }
}

void draw() {
  amplitud = map(mouseY,0,height,1,-1);
  for (int i = 0; i < width; i++) {
    line(
  }
}

