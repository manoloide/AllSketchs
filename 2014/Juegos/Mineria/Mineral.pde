static class Mineral {
  static Mineral tierra = new Mineral("tierra", 0, #523425);
  static Mineral piedra = new Mineral("piedra", 1, #3D403E);
  static Mineral esmeralda = new Mineral("esmeralda", 2, #27B341);
  
  color col;
  int id; 
  String nombre; 
  public Mineral(String nombre, int id, color col) {
    this.nombre = nombre;
    this.id = id; 
    this.col = col;
  }
}
