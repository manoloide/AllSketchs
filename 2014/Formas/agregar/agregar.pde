Forma f;

void setup() {
	size(600,600);
	f = new Forma(width/2, height/2, 400, 4);
}

void draw() {
	background(#0088FF);
	noStroke();
	fill(#FF8800);
	f.update();
}
void keyPressed(){
	if(key == 'a') f.agregar();
	if(key == 's') f.eliminar();
}

class Forma{
	ArrayList<Punto> puntos;
	float x, y, tam, ang; 
	int cant;
	Forma(float x, float y, float tam, int cant){
		this.x = x; 
		this.y = y; 
		this.tam = tam;
		this.cant = cant;
		ang = 0;
		puntos = new ArrayList<Punto>();
		float da = TWO_PI/cant;
		for (int i = 0; i < cant; ++i) {
			puntos.add(new Punto(x+cos(da*i)*tam/2, y+sin(da*i)*tam/2));		
		}
	}
	void update(){
		ang += 0.002;
		float da = TWO_PI/cant;
		for (int i = 0; i < cant; ++i) {
			Punto p = puntos.get(i);
			Punto a = new Punto(x+cos(da*i+ang)*tam/2, y+sin(da*i+ang)*tam/2);
			float ang1 = da*i+ang;
			float ang2 = atan2(p.y-a.y, p.x-a.x);
			float dif = (ang1-ang2)/200;
			p.x = x+cos(ang2+dif)*tam/2;
			p.y = y+sin(ang2+dif)*tam/2;
		}
		draw();
	}
	void draw(){
		beginShape();
		for(int i = 0; i < puntos.size(); i++){
			Punto p = puntos.get(i);
			vertex(p.x, p.y);
		}
		endShape(CLOSE);
	}
	void agregar(){
		int v = int(random(cant));
		Punto p = puntos.get(v);
		Punto n = new Punto(p.x, p.y);
		ang = atan2(p.y-y, p.x-x);
		puntos.add(v, n);
		cant = puntos.size();
	}
	void eliminar(){
		if(puntos.size() <= 3) return;
		puntos.remove(int(random(puntos.size())));
		cant = puntos.size();
	}
}

class Punto{
	boolean eliminar;
	float x, y;
	Punto(float x, float y){
		this.x = x; 
		this.y = y;
	}
}