int paleta[] = {
	#9A1FFF,
	#232323,
	#3E3E3E,
	#C8C8C8
};

void setup() {
	size(600, 600);
}

void draw() {
	
}

void generar(){
	background(rcol());
	int des = int(random(2, 6));
	stroke(255, 20);
	strokeWeight(1);
	for (int i = -int(random(des)); i < width+height; i+=des) {
		line(i, -2, -2, i);
	}

	float x = width/2; 
	float y = height/2; 
	float d = 60;
	strokeCap(SQUARE);
	noFill();
	float ang = random(TWO_PI);
	for(int i = 0; i < 20; i++){
		float a2 = ang+random(PI*0.5,PI*1.5);
		float aa = random(TWO_PI);
		float dd = random(5);
		strokeWeight(dd*random(1,2));
		for(int j = 0; j < 40; j++){
			stroke(rcol());
			arc(x, y, d, d, ang, a2);
			x += cos(aa)*dd;
			y += sin(aa)*dd;
		}	
		x += cos(a2)*d;
		y += sin(a2)*d;
		ang = a2;
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