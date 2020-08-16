void setup() {
	size(600, 800);
	generar();
}

void draw() {
}
void keyPressed(){
	generar();
}

void generar(){
	for (int i = 0; i < 1000; ++i) {
		stroke(random(256),random(256),random(256), 50);
		float x = random(width);
		float y = random(height);
		float dim = random(20,400);
		circulo(x, y, dim, int(random(5,20)));
		fill(255,190);
		circulo2(x, y, dim, int(random(5,20)));

	}
	/*
	textAlign(LEFT, TOP);
	textSize(80);
	text("Diferencia!", 20, 20);
*/
}

void circulo(float x, float y, float dim, int cant){
	float tam = dim/2/cant;
	strokeWeight(tam/4);
	noFill();
	for(int i = 0; i < cant; i++){
		ellipse(x,y,tam*i, tam*i);
	}
}

void circulo2(float x, float y, float dim, int cant){
	float r = dim/2;
	float da = TWO_PI/cant;
	for(int i = 0; i < cant; i++){
		ellipse(x+cos(i*da)*r,y+sin(i*da)*r,r/cant, r/cant);
	}
}