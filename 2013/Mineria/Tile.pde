class Tile{
	boolean eliminar;
	Mineral minerales[]; 
	PImage img;
	Tile(){
		eliminar = false;
		minerales = new Mineral[32];
		crearImagen();
	}
	void crearImagen(){
		img = createImage(16,16,RGB);
		for(int i = 0; i < img.pixels.length; i++){
			img.pixels[i] = color(random(256),random(256),random(256));
		}
	}
	void act(){	
		
	}
}