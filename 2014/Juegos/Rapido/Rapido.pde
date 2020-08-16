int tam = 50;
int bor = 10;
int cw = 12;
int ch = 8;

ArrayList<Cargador> cargadores;

void setup() {
	size(800, 600);
	cargadores = new ArrayList<Cargador>();
	float bw = (width/2-(tam*cw + bor*(cw+1))/2);
	float bh = (height/2-(tam*ch + bor*(ch+1))/2);
	for (int j = 0; j < ch; ++j) {
		for (int i = 0; i < cw; ++i) {
			float x = bw+tam/2+bor+(tam+bor)*i;
			float y = bh+tam/2+bor+(tam+bor)*j;
			cargadores.add(new Cargador(x,y));
		}
	}
}

void draw() {
	background(20);
	for(int i = 0; i < cargadores.size(); i++){
		Cargador c = cargadores.get(i);
		c.update();
	}
}

class Cargador{
	boolean sobre;
	float x, y, t;
	float val;
	Cargador(float x, float y){
		this.x = x; 
		this.y = y;
		this.t = tam;
	}
	void update(){
		if(dist(x, y, mouseX, mouseY) < tam/2){
			sobre = true;
		}else sobre = false;
		if(sobre) val += 0.02;
		else val -= 0.003;
		if(val > 1) val = 1;
		if(val < 0) val = 0;
		draw();
	}
	void draw(){
		noStroke();
		fill(255, 10);
		ellipse(x,y,tam,tam);
		fill(255, 40);
		arc(x,y,tam,tam,-PI/2,TWO_PI*val-PI/2);
	}
}