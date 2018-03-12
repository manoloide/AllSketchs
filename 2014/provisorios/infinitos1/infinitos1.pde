int seed = int(random(9999999));


void setup() {
	size(600 , 600);
	generar();
}

void draw() {
	
}

void generar(){
	randomSeed(seed);
	noFill();
	for(int i = 0; i < width; i++){
		stroke(random(256),20);
		strokeWeight(i/6);
		ellipse(width/2,height/2, i*2, i*2);
	}
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		generar();
	}
}