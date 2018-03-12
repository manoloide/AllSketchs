class Rama {
  float x1, y1, x2, y2, lar;

  Rama(float nx1, float ny1, float nx2, float ny2) {
    x1 = nx1;
    y1 = ny1;
    x2 = nx2;
    y2 = ny2;
    lar = dist(x1,y1,x2,y2);
  }
  
  void draw(){
    dibujar(x1,y1,x2,y2, lar /10, lar * 2/3/10);
  }
}

