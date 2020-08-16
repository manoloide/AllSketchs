int seed = int(random(9999999));
float h;

void setup() {
	size(600, 600);
	colorMode(HSB, 256);
	generar();
}

void draw() {
	
}

void generar(){
	background(#151722);
	generar2();
	filter(BLUR, 3);
	generar2();
}

void generar2(){
	randomSeed(seed);
	stroke(#C3EC03);
	strokeCap(SQUARE);
	noFill();
	for(int i = 0; i < 10; i++){
		int r = int(random(5));
		float x = random(width);
		float y = random(height);
		float dis = random(width*0.1, width*0.8);
		int cant = int(random(-16, 16));
		float da = TWO_PI/cant;
		float ang = random(TWO_PI);
		float tam = random(width*0.02, width*0.2);
		if(cant < 1) cant = 1;
		strokeWeight(random(width/400, width*0.04));
		pushMatrix();
		translate(x,y);
		rotate(ang);
		for(int j = 0; j < cant; j++){
			rotate(da);
			switch (r) {
				case 0:
				rect(dis, 0, tam, tam);
				break;
				case 1:
				ellipse(dis, 0, tam, tam);
				break;
				case 2:
				line(-tam/2+dis, -tam/2, tam/2+dis, tam/2);
				line(tam/2+dis, -tam/2, -tam/2+dis, tam/2);
				break;
				case 3:
				arc(dis, 0, tam, tam, 0, da);
				break;
				case 4:
				triangle(dis+cos(0)*tam/2, sin(0)*tam/2, dis+cos(TWO_PI/3)*tam/2, sin(TWO_PI/3)*tam/2, dis+cos(TWO_PI/3*2)*tam/2, sin(TWO_PI/3*2)*tam/2);
				break;
			}
		}
		popMatrix();
	}
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		generar();
	}
}