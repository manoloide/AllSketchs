int paleta[] ={
	#1C2130,
	#028F76,
	#B3E099,
	#FFEAAD,
	#D14334
};

void setup() {
	size(800 , 800);
	generar();
}

void draw() {
	
}

void generar(){
	for(int i = 0; i < 80; i++){
		float x = random(width);
		float y = random(height);
		float d = random(20, 300);
		float r = int(random(4))*PI*0.5;
		int c1 = rcol();
		int c2 = rcol();
		while(c1 == c2){
			c2 = rcol();
		}
		if(random(1) < 0.5) cubito(x, y, d, c1, c2);
		else pelotita(x, y, d, r, c1, c2);
	}
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}

void pelotita(float x, float y, float dim, float ang, int c1, int c2){
	int cant = int(dim*TWO_PI);
	float da = TWO_PI/cant;
	noStroke();
	for(float i = 0; i < cant; i+=1){
		fill(lerpColor(c1, c2, i*1./cant));
		float a1 = da*i+ang;
		if(i < cant-1) a1-=0.01;
		arc(x, y, dim, dim, a1, da*(i+1)+ang);
	}
}

void cubito(float x, float y, float t, int c1, int c2){
	int cant = int(dist(0, 0, t, t));
	int tipo = int(random(4));
	for(float i = 0; i < cant; i+=0.5){
		stroke(lerpColor(c1, c2, i*1./cant));
		if(tipo == 0) line(x, y+i, x+i, y);
		if(tipo == 1) line(x+t, y+t-i, x+t-i, y+t);
		if(tipo == 2) line(x, y+t-i, x+i, y+t);
		if(tipo == 3) line(x+t, y+i, x+t-i, y);
	}
}