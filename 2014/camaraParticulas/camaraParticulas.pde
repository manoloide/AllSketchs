import manoloide.Input.*;

ArrayList<Particula> particulas;
Camara camara;
Input input;
Particula seleccionada;

void setup() {
	size(800,600);
	input = new Input(this);
	camara = new Camara(width/2, height/2);
	particulas = new ArrayList<Particula>();
	seleccionada = null;
	for(int i = 0; i < 3; i++){
		float ang = random(TWO_PI);
		float dis = random(height);
		float x = cos(ang)*dis;
		float y = sin(ang)*dis;  
		particulas.add(new Particula(x, y));
	}
}

void draw() {
	background(250);
	camara.act();
	fill(255, 40, 180);
	ellipse(0,0,20,20);
	for(int i = 0; i < particulas.size(); i++){
		Particula p = particulas.get(i);
		p.act();
		if(p.eliminar) particulas.remove(i--);
	}

	if(input.click){
		if(seleccionada == null){
			seleccionada = particulas.get(int(random(particulas.size())));
			camara.ix = seleccionada.x;
			camara.iy = seleccionada.y;
			camara.iscala(2);
		}
		else{
			seleccionada = null;
			camara.iscala(0.25);
		}
	}
	input.update();
}

void mousePressed(){
	input.mpress();
}	

void mouseReleased(){
	input.mreleased();
}	
class Camara{
	float x, y, es;
	float ix, iy;
	float ie;
	Camara(float x, float y){
		this.x = x;
		this.y = y;
		ie = es = 1;
	}
	void act(){
		mover(ix, iy);
		translate(x, y);
		//es = cos(frameCount/100.)/2 + 1;
		es += (ie-es)/10.;
		scale(es);
	}
	void mover(float mx, float my){
		float es = camara.es;
		float dx = (-mx+(width/2)/es)*es;
		float dy = (-my+(height/2)/es)*es;//+(width/2)*es;
		x += (dx-x)/10.;
		y += (dy-y)/10.;
	}
	void iscala(float i){
		ie = i;
	}
};

class Particula{
	boolean eliminar, sobre;
	float x, y, ang, tam, vel;
	Particula(float x, float y){
		this.x = x;
		this.y = y;
		tam = random(10, 60);
		ang = random(TWO_PI);
		vel = tam/1000.;
	}
	void act(){
		ang += random(-0.05, 0.05);
		x += cos(ang)*vel;
		y += sin(ang)*vel;
		if(dist(mouseX/camara.es-camara.x, mouseY/camara.es-camara.y, x, y) < tam/2) sobre = true;
		else sobre = false;
		dibujar();
	}
	void dibujar(){
		noStroke();
		if(sobre) fill(32, 0, 0);
		else fill(5);
		ellipse(x,y,tam,tam);
	}
}