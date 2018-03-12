ArrayList<Soldado> soldados, seleccionados;
Input input;
Seleccionador seleccionador;

void setup() {
	size(800, 600);
	input = new Input();
	soldados = new ArrayList<Soldado>();
	seleccionados = new ArrayList<Soldado>();
	seleccionador = new Seleccionador();
	for(int i = 0; i < 30; i++){
		float x = random(width);
		float y = random(height);
		soldados.add(new Soldado(x, y));
	}
}

void draw() {
	background(#A38981);
	seleccionador.update();
	for(int i = 0; i < soldados.size(); i++){
		Soldado s = soldados.get(i);
		s.update();
		if(s.remove) soldados.remove(i--);
	}
	seleccionador.draw();
	input.act();
}

void keyPressed() {
	input.event(true);
}
void keyReleased() {
	input.event(false);
}
void mousePressed() {
	input.mpress();
}
void mouseReleased() {
	input.mreleased();
}

class Soldado{
	boolean remove, select, on;
	float x, y, ix, iy;
	Soldado(float x, float y){
		this.x = x;
		this.y = y;
	}
	void update(){
		if(dist(mouseX, mouseY, x, y) < 6) on = true;
		else on = false;
		if(input.click){
			if(on) select = true;
			else select = false;
		}
		draw();
	}
	void draw(){
		float tt = 8;
		if(select){
			stroke(#CACACA, 200);
			fill(#CACACA, 20);
			ellipse(x, y, tt*3, tt*3);
		}
		if(on) stroke(#91F147);
		else noStroke();
		fill(#26331F);
		ellipse(x, y, tt, tt);
	}
}

class Seleccionador{
	boolean seleccionar;
	int x1, y1, x2, y2;
	void update(){
		if(mouseButton == LEFT){
			if(input.click){
				x1 = mouseX;
				y1 = mouseY;
				seleccionar = true;
			}
			if(input.press){
				x2 = mouseX;
				y2 = mouseY;
			}
			if(input.released) seleccionar();
		}
	}
	void draw(){
		if(seleccionar){
			stroke(#79FB14);
			fill(#79FB14, 20);
			rectMode(CORNERS);
			rect(x1, y1, x2, y2);
			rectMode(CORNER);
		}
	}
	void deseleccionar(){
		for(int i = 0; i < soldados.size(); i++){
			soldados.get(i).select = false;
		}
	}
	void seleccionar(){
		deseleccionar();
		for(int i = 0; i < soldados.size(); i++){
			Soldado s = soldados.get(i);
			if(s.x >= min(x1, x2)-4 && s.x < max(x1, x2)+4 && s.y >= min(y1, y2)-4 && s.y < max(y1, y2)+4){
				s.select = true;
			}
		}
		seleccionar = false;
	}
}