long seed;
void setup() {
	size(800, 600, P3D);
	smooth(4);
	frameRate(30);
	seed = int(random(999999));
}

void draw() {
	if(frameCount%15 == 0) seed = int(random(999999));
	background(40);
	randomSeed(seed);
	for(int j = -1; j < 2; j++){
		for(int i = -1; i < 2; i++){
			resetMatrix();
			translate((width/4)*i, (height/4)*j, -400);
			rotateX((frameCount%240)/240. * TWO_PI);
			rotateZ((frameCount%120)/120. * TWO_PI);
			noStroke();
			int cant = int(random(10, 20));
			color c1 = color(random(256),random(256),random(256),240);
			color c2 = color(random(256),random(256),random(256),240);
			float da = TWO_PI/cant;
			float tam = map(cos((abs(frameCount%120-60.)/60)*TWO_PI),-1, 1, 10, 100);
			for(int k = 0; k < cant; k++){
				fill(lerpColor(c1, c2, k*1./cant));
				rotateX(random(da*k));
				//rotateY(random(TWO_PI));
				//rotateZ(random(TWO_PI));
				//float tam = random(100, 300)+cos((abs(frameCount%120-60.)/120)*TWO_PI)*200;
				float a1 = 0;//random(TWO_PI);
				float a2 = TWO_PI;//a1+random(TWO_PI);
				ellipse(0,0,tam,tam);
				//arc(0, 0, tam, tam, a1, a2);
			}
		}
	}
}

void keyPressed(){
	if(key == 's') saveFrame("######");
	else seed = int(random(999999));
}