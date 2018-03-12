class Tile {
  boolean eliminar;
  Mineral minerales[]; 
  PImage img;
  Tile() {
    eliminar = false;
    minerales = new Mineral[32];
    for(int i = 0; i < 32; i++){
      float r = random(1);
      if(r < 0.5){
        minerales[i] = Mineral.tierra;
      }else if(r < 0.99){
        minerales[i] = Mineral.piedra;  
      }else{
        minerales[i] = Mineral.esmeralda;
      }
    }  
    crearImagen();
  }
  void crearImagen() {
    PGraphics aux = createGraphics(16,16);
    aux.beginDraw();
    aux.noStroke();
    for(int j = 0; j < 4; j++){
       for(int i = 0; i < 8; i++){
         aux.fill(minerales[i+j*8].col);
         aux.rect(i*2, j*2, 2, 2); 
         aux.rect(6+(8-i*2), 14-j*2, 2, 2); 
       } 
    }
    aux.endDraw();
    img = createImage(16, 16, RGB);
    img.loadPixels();
    for (int i = 0; i < img.pixels.length; i++) {
      img.pixels[i] = aux.pixels[i];
    }
    img.updatePixels();
  }
  void picar(Jugador j){
    for(int i = 0; i < minerales.length; i++){
       j.materiales[minerales[i].id]++; 
    }
  }
  void act() {
  }
}
