int paleta[] = {
	#FFFFFF
};

void setup() {
	size(600, 600);
	generar();
}

void draw() {
	
}

void generar(){
	background(250);
	noise(5);
	filter(BLUR, 1);
	noFill();
	strokeCap(PROJECT);
	for(int i = 0; i < 3; i++){
		float xx = random(width);
		float yy = random(height);
		float dd = random(20, 400);
		int cant = int(random(3, 20));
		float sep = random(0.6);
		float ang = random(TWO_PI);
		strokeWeight(max(dd*random(0.2),2));
		circuloPunteado(xx, yy, dd, cant, sep, ang);
	}
}

void noise(int cant){
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			color col = get(i, j);
			float bri = random(-cant, cant);
			col = color(red(col)+bri, green(col)+bri, blue(col)+bri);
			set(i, j, col);
		}
	}

}

void circuloPunteado(float x, float y, float dim, int cant, float sep, float ang){
	sep = constrain(sep, 0, 1);
	float da = TWO_PI/cant;
	for(int i = 0; i < cant; i++){
		arc(x, y, dim , dim, da*i+ang, da*(i+sep)+ang);
	}
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-2;
	saveFrame(nf(n, 3)+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}