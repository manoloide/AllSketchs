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
	background(0);
	for(int i = 0; i < width/5; i++){
		float h = exp(i);
		rect(i*5, height/2-h/2, 5, h);
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