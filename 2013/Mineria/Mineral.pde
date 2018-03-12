class Mineral{
	static Mineral tierra = new Mineral("tierra",0);
	static Mineral piedra = new Mineral("piedra",1);
	
	color col;
	int id; 
	String nombre; 
	public Mineral(String nombre, int id) {
		this.nombre = nombre;
		this.id = id; 
		this.col = col; 
	}
}