class Meta {
  float x, y, tam; 
  String niv;
  
  Meta(float x, float y) {
    this.x = x;
    this.y = y;
    this.niv = "";
    tam = TAMTILE*2;
  }
  Meta(float x, float y, String niv) {
    this.x = x;
    this.y = y;
    this.niv = niv;
    tam = TAMTILE*2;
  }

  void dibujar() {
    noStroke();
    fill(random(255), random(255), 255);
    rect(x, y, TAMTILE, TAMTILE);
    fill(random(255), random(255), 255);
    rect(x-TAMTILE, y, TAMTILE, TAMTILE);
    fill(random(255), random(255), 255);
    rect(x, y-TAMTILE, TAMTILE, TAMTILE);
    fill(random(255), random(255), 255);
    rect(x-TAMTILE, y-TAMTILE, TAMTILE, TAMTILE);
  }
}
