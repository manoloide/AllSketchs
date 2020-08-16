void setup() {
	size(800, 600);
}

void draw() {
	
	background(0);
	blendMode(SCREEN);
	strokeWeight(30);
	stroke(102, 0, 0);
	crus(mouseX, mouseY, 25);
	stroke(0, 102, 0);
	crus(mouseX, mouseY, 25);
	stroke(0, 0, 102);
	crus(mouseX, mouseY, 25);
}

void crus(float x, float y, float tam){
	line(x-tam, y-tam, x+tam, y+tam);
	line(x+tam, y-tam, x-tam, y+tam);
}