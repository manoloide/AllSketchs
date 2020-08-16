String state = "edite";
PGraphics tiles, mask;
PImage back;

void setup() {
	size(800, 600, P2D);

	tiles = createGraphics(width, height);
	mask = createGraphics(width, height);

	mask.beginDraw();
	mask.background(0);
	mask.endDraw();

	createBackground();
}

void draw() {
	if(state.equals("view")){
		updateView();
	}
	else if(state.equals("edite")){
		updateEdite();
	}
}	

void updateView(){

}

void updateEdite(){

	textureWrap(REPEAT);
	beginShape(); 
	texture(back);
	vertex(0, 0, 0, 0);
	vertex(width, 0, width, 0);
	vertex(width, height, width, height);
	vertex(0, height, 0, height);
	endShape();


	if(mousePressed){
		if(mouseButton == LEFT){
			tiles.beginDraw();
			tiles.fill(0);
			tiles.strokeWeight(5);
			tiles.line(pmouseX, pmouseY, mouseX, mouseY);
			tiles.endDraw();
			
			mask.beginDraw();
			mask.stroke(255);
			mask.strokeWeight(5);
			mask.line(pmouseX, pmouseY, mouseX, mouseY);
			mask.endDraw();
		}
		if(mouseButton == RIGHT){
			mask.beginDraw();
			mask.stroke(0);
			mask.strokeWeight(5);
			mask.line(pmouseX, pmouseY, mouseX, mouseY);
			mask.endDraw();
		}
	}

	PImage aux = tiles.get();
	aux.mask(mask);
	image(aux, 0, 0);
}


void createBackground(){
	PGraphics gra = createGraphics(16, 16);
	gra.beginDraw();
	gra.background(120);
	gra.noStroke();
	gra.fill(220);
	gra.rect(0, 0, 8, 8);
	gra.rect(8, 8, 8, 8);
	gra.endDraw();

	back = gra.get();
}