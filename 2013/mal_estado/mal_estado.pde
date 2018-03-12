int escala = 1;
PFont font;

void setup() {
  size(671*escala, 663*escala);
  font = loadFont("font.vlw");
  textFont(font);
  strokeWeight(8);
}

void draw() {
	background(255, 225, 53);
  	stroke(235,233,228,240);
  	noFill();
	rect(72,72,360,200,20);
	fill(235,233,228,240);

	text("Mal\nestado...", 90,152);
  	stroke(255,253,248,240);
  	noFill();
	rect(70,70,360,200,20);
	fill(255,253,248,240);
	text("Mal\nestado...", 88,150);
}

