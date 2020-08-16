color col;
int seed;

void setup() {
	size(600, 800);
	smooth(8);
	seed = int(random(9999999));
	generar();
}

void draw() {
	
}

void keyPressed(){
	if(key == 's') saveFrame("#####");
	else generar();
}

void generar(){
	seed = int(random(9999999));
	randomSeed(seed);
	col = color(random(255), random(255), random(255));
	PImage img = crearLineas(width, height);
	img = loadImage("http://fondos10.com/wp-content/uploads/images/60/bosques.jpg");
	image(img, 0, 0);
	int cant = int(random(10,30));
	for(int i = 0; i < cant; i++){
		float x = width/2;//random(width);
		float y = height/2;//random(height);
		float ang = random(TWO_PI);
		float dim = int(random(16, 20));
		PGraphics mask = createGraphics(width, height);
		mask.beginDraw();
		mask.background(0);
		mask.noStroke();
		mask.fill(255);
		mask.ellipse(x, y, dim, dim);
		mask.endDraw();
		img.mask(mask.get());
		translate(x, y);
		rotate(ang);
		image(img, -x, -y);
	}
}

PImage crearLineas(int width, int height){
	PGraphics gra = createGraphics(width, height);
	int cantColor = 8;
	color paleta[] = new color[cantColor];
	for(int i = 0; i < cantColor; i++){
		paleta[i] = desplazar(col, 1./int(random(2,6)));
	}
	gra.pushMatrix();
	gra.translate(width/2, height/2);
	gra.rotate(random(TWO_PI));
	float diag = dist(0, 0, width, height);
	float des = -diag/2;
	gra.noStroke();
	while (des < diag/2) {
		gra.fill(luz(paleta[int(random(paleta.length))], random(-20, 20)));
		float tt = random(2, 60);
		gra.rect(-diag/2, des, diag, tt+1);
		des += tt;
	}
	gra.popMatrix();
	return gra.get();
}

void circulo(float x, float y, float w, float h, int cant, color col){
	noStroke();
	float da = TWO_PI/cant;
	for(int i = 0; i < cant; i++){
		fill(luz(col, random(-20, 20)));
		arc(x, y, w, h, da*i, da*(i+1));
	}
}

color luz(color col, float c){
	return(color(red(col)+c, green(col)+c, blue(col)+c));
}

color desplazar(color ori, float d){
	pushStyle();
	colorMode(HSB, 256, 256, 256);
	color aux = color((hue(ori)+256*d)%256, saturation(ori), brightness(ori));
	popStyle();
	return aux;
}