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
	color col1 = color(random(256), random(256), random(256));
	color col2 = color(random(256), random(256), random(256)); 
	for(int i = 0; i < height; i++){
		stroke(lerpColor(col1, col2, map(i, 0, height, 0, 1)));
		line(0, i, width, i);
	}
	circulo(width/2, height/2, width, random(TWO_PI), 20, 10);
}

void circulo(float x, float y, float d, float ang, float sep, float tam){
	int cant = int(d/sep);
	int mc = cant/2;
	for(int i = -mc; i < mc; i++){
		for(int j = -mc; j < mc; j++){
			float xx = cos(ang)*i*sep;
			float yy = sin(ang)*j*sep;
			ellipse(xx, yy, tam, tam);
		}
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