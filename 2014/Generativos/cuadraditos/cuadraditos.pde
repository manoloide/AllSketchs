int seed = int(random(9999999));

void setup() {
	size(600 , 800);
	generar();
}

void draw() {
	
}

void generar(){
	randomSeed(seed);
	background(#181818);
	for (int j = 0; j < 24; ++j) {
		for (int i = 0; i < 7; ++i) {
			logito(30+i*80, 40+j*30, 8, 2, 5, 4);		
		}
	}
	noisee();
}

void keyPressed(){
	if(key == 's') saveImage();
	else {
		seed = int(random(9999999));
		generar();
	}
}

void logito(float x, float y, int cw, int ch, float t, float esp){
	stroke(200, 80);
	noStroke();
	fill(200, 180);
	for (int j = 0; j < ch; ++j) {		
		for (int i = 0; i < cw; ++i) {
			if(random(100) < 30) continue;
			rect(x+(t+esp)*i,y+(t+esp)*j, t, t);
		}
	}
}

void noisee(){
	for (int j = 0; j < height; ++j) {
		for (int i = 0; i < width; ++i) {
			color col = get(i, j);
			float bri = random(10);
			set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
		}
	}
}

void saveImage(){
	File f = new File(sketchPath);
	int cant = f.listFiles().length-1;
	saveFrame(cant+".png");
}