import manoloide.Color.Paleta;

int seed = int(random(9999999));
Paleta paleta;

void setup() {
	size(600, 600);
	paleta = new Paleta(#D0C3BA, #E4D7CB, #3E3131, #D4524E, #89C1C2);
	generar();
}

void draw() {
	
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		thread("generar");
	}
}


void generar(){
	randomSeed(seed);
	size(600, 600);
	background(paleta.rcol());
	for(int i = 0; i < width; i+=2){
		if(i%4 == 0) stroke(paleta.rcol());
		else continue;
		line(i-random(-1,1), 0, i-random(-1,1), height);
	}
	noStroke();
	fill(5);
	float esp = 20;
	float tam = esp*1;
	pushMatrix();
	translate(esp/2, esp/2);
	for(int j = 0; j < height/esp; j++){
		for(int i = 0; i < width/esp; i++){
			float ang = random(TWO_PI);
			for(int k = int(tam)/4; k > 0; k-=1){
				if(int(k)%2 == 0) fill(paleta.rcol());
				else fill(paleta.rcol());
				triangulo(i*esp, j*esp, k*4, ang);
			}
		}
	}
	popMatrix();
	for(int i = int(width*0.6); i > 1; i-=int(random(4)+1)){
		fill(paleta.rcol());
		ellipse(width/2, height/2, i, i);
	}
}

void triangulo(float x, float y, float tam, float ang){
	float da = TWO_PI/3.;
	float mt = tam/2;
	beginShape();
	for(int i = 0; i < 3; i++){
		vertex(x+cos(ang+da*i)*mt, y+sin(ang+da*i)*mt);
	}
	endShape(CLOSE);
}