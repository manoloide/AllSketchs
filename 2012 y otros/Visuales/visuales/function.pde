void pintarFondo() {
  noStroke();
  fill(fondo);
  rect(0, 0, width, height);
}
void lineas() {
  for (int i = 0; i < 50; i++) {
    stroke(random(255), random(255), random(255));
    float ang = random(2*PI);
    float x = random(width);
    float y = random(height);
    line(x -cos(ang)*DIAGONAL, y -sin(ang)*DIAGONAL, x +cos(ang)*DIAGONAL, y +sin(ang)*DIAGONAL);
  }
}
void diagonales() {
  float ang = random(2*PI);
  for (int i = 0; i < 50; i++) {
    stroke(random(255), random(255), random(255));
    strokeWeight(random(50));
    float x = random(width);
    float y = random(height);
    line(x -cos(ang)*DIAGONAL, y -sin(ang)*DIAGONAL, x +cos(ang)*DIAGONAL, y +sin(ang)*DIAGONAL);
  }  
  strokeWeight(1);
}
void diagonales2() {
  float total = 0;
  float cant = 0;
  float ang = random(PI*2);
  float mitad = DIAGONAL/2;

  pushMatrix();
  translate(width/2, height/2);
  rotate(ang);

  while (total < DIAGONAL) {
    cant = random(10,100);
    fill(random(255), random(255), random(255));
    rect(total-mitad, -mitad, cant, DIAGONAL);
    total += cant;
  }

  popMatrix();
}

