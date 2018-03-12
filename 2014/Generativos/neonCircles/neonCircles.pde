int paleta[] = {
	#EBF5D8,
	#B5D0BE,
	#66BAA7,
	#012632,
	#DA3754
};

int seed = int(random(999999999));

void setup() {
	size(600, 600);
}

void draw() {}

void keyPressed(){
	if(key == 's') saveImage();
	else {
		seed = int(random(999999999));
		thread("generar");
	}
}

void generar(){
	background(#322A2A);
	randomSeed(seed);
	circulos();
	filter(BLUR, 3);
	randomSeed(seed);
	circulos();
}

void circulos(){
	strokeCap(SQUARE);
	float dim = width*random(0.5,0.9);
	float x = width/2;
	float y = height/2;
	noFill();
	stroke(#F7B71A);
	float tt = random(28, 50);
	for(float i = dim; i > 0; i-=tt){
		strokeWeight(tt/random(3, 20));
		stroke(rcol());
		int t = int(random(3));
		if(t == 0) ellipse(x, y, i, i);
		if(t == 1){
			int c = int(pow(2,int(random(6))));
			float da = TWO_PI/(c*2);
			for(int j = 0; j < c; j++){
				stroke(rcol());
				arc(x, y, i, i, (da*2)*j, (da*2)*j+da);
			}
		}
		if(t == 2){
			float ang = random(TWO_PI);
			float da = 0;
			float da2 = random(PI*0.75);
			stroke(rcol());
			while(da < TWO_PI){
				strokeWeight(tt/random(3, 20));
				arc(x, y, i, i, da+ang, da2+ang);
				da = da2;
				da2 += random(PI*0.75);
			}
		}
	}
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}