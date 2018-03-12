float x1, y1, tam1, x2, y2, tam2, col1, col2;

void setup() {
  size(400, 400);
  colorMode(HSB, 100);
  noStroke();
  x1 = 200;
  y1 = 200;
  tam1 = 40;
  col1 = 30;
  tam2 = 20;
  col2 = 60;
}

void draw() {
  x2 = mouseX;
  y2 = mouseY;

  background(0);
  fill(col1, 100, 100);
  rect(x1-tam1/2, y1-tam1/2, tam1, tam1);
  if (!colisiona(x1, y1, tam1, x2, y2, tam2)) {
    fill(col2, 100, 100);
  }
  rect(x2-tam2/2, y2-tam2/2, tam2, tam2);
}


boolean colisiona(float x1, float y1, float tam1, float x2, float y2, float tam2) {
  tam1 /= 2;
  tam2 /= 2;
  float dis = tam1 + tam2;
  if (abs(x1 - x2) < dis && abs(y1 - y2) < dis){
    return true;
  }  
  return false;
}

