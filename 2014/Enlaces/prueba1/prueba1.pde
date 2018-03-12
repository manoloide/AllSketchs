ArrayList<Particula> particulas;
boolean click;
void setup() {
	size(800, 600);
	click = false;
	iniciar();
}

void draw() {
	if(frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
	background(120);
	for(int i = 0; i < particulas.size(); i++){
		Particula p = particulas.get(i);
		p.update();
		if(p.eliminar) particulas.remove(i--);

		for(int j = 0; j < particulas.size(); j++){
			Particula aux = particulas.get(j);
			if(aux == p) continue;
			float dis = dist(p.x, p.y, aux.x, aux.y);
			if(aux.tam <= p.tam && dis < (p.tam+aux.tam)){
				float aa = atan2(p.y-aux.y, p.x-aux.x);
				float vv = (p.tam+aux.tam)/100;
				aux.x -= cos(aa)*vv;
				aux.y -= sin(aa)*vv;
			}
		}
		
	}
	click = false;
}
void keyPressed(){
	if(key == 'r') iniciar();
}
void mousePressed(){
	click = true;
}

void iniciar(){
	particulas = new ArrayList<Particula>();
	particulas.add(new Particula(random(width), random(height), 100));
}


class Particula{
	ArrayList<Particula> hijos;
	boolean eliminar, sobre;
	float x, y, tam, ang, vel;
	int tiempo;
	Particula papa;
	Particula(float x, float y, float tam){
		papa = null;
		this.x = x;
		this.y = y;
		this.tam = tam;
		tiempo = 0;
		ang = random(TWO_PI);
		vel = 0.1;
		hijos = new ArrayList<Particula>();
	}
	Particula(Particula papa){
		this.papa = papa;
		this.x = papa.x;
		this.y = papa.y;
		this.tam = papa.tam*0.8;
		tiempo = 0;
		ang = random(TWO_PI);
		vel = random(0.08,0.02);
		x += cos(ang)*vel;
		y += sin(ang)*vel;
		hijos = new ArrayList<Particula>();
	}
	void update(){
		tiempo++;
		if(dist(mouseX, mouseY, x, y) < tam/2) sobre = true;
		else sobre = false;
		if(sobre && click && tiempo > 1){
			int c = int(random(3));
			hijos(c);
		}
		ang += random(-vel/2, vel/2);
		x += cos(ang)*vel;
		y += sin(ang)*vel;
		for(int i = 0; i < hijos.size(); i++){
			Particula h = hijos.get(i);
			float disopt = (tam+h.tam)*0.7;
			float dis = dist(x, y, h.x, h.y)*1.2;
			float vv = (dis-disopt)/20;
			float aa = atan2(y-h.y, x-h.x);
			h.x += cos(aa)*vv;
			h.y += sin(aa)*vv;
		}
		draw();
	}
	void draw(){
		stroke(255, 200);
		fill(255, 120);
		ellipse(x, y, tam, tam);
		line(x+cos(ang)*tam*0.2, y+sin(ang)*tam*0.2, x-cos(ang)*tam*0.2, y-sin(ang)*tam*0.2);
		line(x+cos(ang+PI/2)*tam*0.2, y+sin(ang+PI/2)*tam*0.2, x-cos(ang+PI/2)*tam*0.2, y-sin(ang+PI/2)*tam*0.2);
		if(papa != null)line(x, y, papa.x, papa.y);
	}
	void hijos(int c){
		for(int i = 0; i < c; i++){
			Particula p = new Particula(this);
			hijos.add(p);
			particulas.add(p);
		}
	}

}