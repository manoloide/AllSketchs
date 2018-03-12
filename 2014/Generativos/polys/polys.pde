int seed = 0;
int frame = 0;
int paleta[] = {
	#EBF5D8,
	#B5D0BE,
	#66BAA7,
	#012632,
	#DA3754
};

void setup() {
	size(800, 600);
	generar();
}

void draw() {
	randomSeed(seed);
	generar();
	frame++;
}

void keyPressed(){
	if(key == 's') saveImage();
	else if(key == 'g'){
		frame = 0;
		seed = int(random(999999));	
	} else generar();
}

void generar(){
	color cbac = rcol();
	background(cbac);
	stroke(red(cbac)+20, green(cbac)+20, blue(cbac)+20);
	for(int i = -(frameCount%20); i < width+height; i+=20){
		line(i, -2, -2, i);
	}

	for(int i = 0; i < 80; i++){
		float det = frame*random(0.02);
		float x = random(-width/2,width/2) + noise(i*20+det)*width;
		float y = random(-height/2,height/2) + noise(i*65.4+det)*height;
		float dim = random(20, 200);
		int cant = int(random(3,6));
		float ang = random(TWO_PI);
		color col = rcol(); 
		noFill();
		stroke(col);
		strokeWeight(max(dim*random(0.05), 1));
		int r = int(random(3));
		if(r == 0) poly(x,y,dim,cant,ang);
		else if (r == 1){
			dim *= random(0.9);
			noStroke();
			fill(col, 50);
			ellipse(x,y,dim, dim);
			fill(col);
			ellipse(x,y,dim*0.8, dim*0.8);
		}
		if(random(4)<2 && r == 1){
			stroke(rcol());
			strokeCap(SQUARE);
			line(x-dim/2, y-dim/2, x+dim/2, y+dim/2);
			line(x+dim/2, y-dim/2, x-dim/2, y+dim/2);
		}
	}
}

void poly(float x, float y, float dim, int cant, float ang){
	float r = dim/2;
	float da = TWO_PI/cant;
	beginShape();
	for(int i = 0; i < cant; i++){
		vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
	}
	endShape(CLOSE);
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}
