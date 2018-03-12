ArrayList<Pajaro> pajaros;

void setup() {
	size(800, 600);
	pajaros = new ArrayList<Pajaro>();
	for(int i = 0; i < 5; i++){
		pajaros.add(new Pajaro(random(width), random(height), random(40, 120)));
	} 
}

void draw() {
	background(250);
	for(int i = 0; i < pajaros.size(); i++){
		Pajaro p = pajaros.get(i);
		p.update();
	}
}

class Pajaro{
	boolean eliminar;
	float x, y, tam;
	Pajaro(float x, float y, float tam){
		this.x = x;
		this.y = y;
		this.tam = tam;
	}
	void update(){
		draw();
	}
	void draw(){
		noStroke();
		fill(10, 200);
		float rot = 0.2;
		beginShape();
		vertex(x+cos(TWO_PI-rot)*tam/2, y+sin(TWO_PI-rot)*tam/2);
		vertex(x+cos(PI-rot)*tam/2, y+sin(PI-rot)*tam/2);
		vertex(x+cos(PI/8-rot)*tam/3, y+sin(PI/8-rot)*tam/3);
		endShape(CLOSE);
	}
}