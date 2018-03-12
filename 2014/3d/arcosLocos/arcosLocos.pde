long seed;
void setup() {
	size(800, 600, P3D);
	smooth(4);
	seed = int(random(999999));
}

void draw() {
	background(180);
	randomSeed(seed);
	translate(width/2, height/2, 0);
	rotateX((frameCount%200)/200. * TWO_PI);
	rotateZ((frameCount%340)/340. * TWO_PI);
	noStroke();
	for(int i = 0; i < 20; i++){
		fill(random(256), random(256), random(256), 180);
		rotateX(random(TWO_PI));
		rotateY(random(TWO_PI));
		rotateZ(random(TWO_PI));
		float tam = random(100, 300)+cos((abs(frameCount%120-60.)/120)*TWO_PI)*200;
		float a1 = random(TWO_PI);
		float a2 = a1+random(TWO_PI);
		arc(0, 0, tam, tam, a1, a2);
	}
}

void keyPressed(){
	if(key == 's') saveFrame("######");
	else seed = int(random(999999));
}