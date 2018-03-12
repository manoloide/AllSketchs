void setup() {
	size(600, 600);
	thread("generar");
}

void draw() {
	
}

void keyPressed(){
	if(key == 's') saveFrame("#####");
	else thread("generar");
}

void generar(){
	int cant = int(random(3, 200));
	float tam_max = dist(0,0,width,height);
	float incremento = tam_max /cant;
	float x = width/2;
	float y = height/2;
	int col = color(random(255), random(255), random(255));
	for(int i = 0; i < cant; i++){
		float tam = tam_max-(incremento*i);
		int cc = 2*int(random(1, 10));
		color c = desplazar(col, 1./int(random(2,5)));
		circulo(x, y, tam, tam, cc, c);
	}
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