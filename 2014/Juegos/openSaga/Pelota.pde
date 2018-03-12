class Pelota {
  int tipo;
  float x, y;
  color col;
  Pelota(float x, float y) {
    this.x = x; 
    this.y = y;
    tipo = int(random(6)); 
    switch(tipo) {
    case 0: 
      col = color(255, 0, 0); 
      break;   
    case 1: 
      col = color(0, 0, 255); 
      break;
    case 2: 
      col = color(255, 255, 0); 
      break;
    case 3: 
      col = color(0, 255, 0); 
      break;
    case 4: 
      col = color(255, 128, 0); 
      break;
    case 5: 
      col = color(255, 0, 128); 
      break;
    }
  }
  void act() {
    //dibujar();
  }
  void dibujar() {
    noStroke();
    fill(col);
    ellipse(x, y, 55, 55);
  }
}
