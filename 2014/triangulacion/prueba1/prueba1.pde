int seed;

void setup(){
	size(600, 300);
	colorMode(HSB);
	generar();
}

void draw(){	
}

void keyPressed(){
	if(key == 's') saveFrame(""+seed);
	else generar();
}

void generar(){
	seed = (int) random(999999);
	randomSeed(seed);
	for(int i = 0; i < 100; i++){
		circulo(random(width), random(height), random(200, 900), (int)random(3,20), random(TWO_PI));
	}
}
void circulo(float x, float y, float dim, int cant, float ang){
	float rad = dim/3;
	float da = TWO_PI/cant;
	float tam = dist(cos(0)*rad,sin(0)*rad, cos(da)*rad, sin(da)*rad);
	for(int i = 0; i < cant; i++){
		float xx = x+cos(da*i+ang)*rad;
		float yy = y+sin(da*i+ang)*rad;
		fill(255*(i*1./cant), 200, 200, 240);
		noStroke();
		ellipse(xx, yy, tam, tam);
		if(tam > 10){
			circulo(xx, yy, tam, (int)random(10, 20), random(TWO_PI));
		}
	}
}