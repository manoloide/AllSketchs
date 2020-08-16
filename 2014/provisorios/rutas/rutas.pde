int seed = int(random(9999999));

void setup() {
	size(800 , 600);
	generar();
}

void draw() {
	
}

void generar(){
	randomSeed(seed);
	background(250);
	rutas(10, height/2, 100);
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		generar();
	}
}

void rutas(float x, float y, float tam){
	float mt = tam/2;
	line(x, y, x+mt, y);
	float xx = x+mt+cos(TWO_PI-PI/4)*mt;
	float yy = y+sin(TWO_PI-PI/4)*mt;
	line(x+mt, y, xx, yy);
	float auxt = tam*random(0.6, 0.9);
	if(random(10) < 4)rutas(xx, yy, auxt);
	xx = x+mt+cos(PI/4)*mt;
	yy = y+sin(PI/4)*mt;
	line(x+mt, y, xx, yy);
	auxt = tam*random(0.6, 0.9);
	if(random(10) < 4)rutas(xx, yy, auxt);
}