int seed = int(random(9999999));
int paleta[] = {
	#FAD089,
	#FF9C5B,
	#F5634A,
	#ED303C,
	#3B8183
};

void setup() {
	size(600, 800);
	thread("generar");
}

void draw() {
	
}

void generar(){
	randomSeed(seed);
	//background(rcol());
	degrade(rcol(), rcol());
	
	int des = int(random(4, 9));
	if(random(2)<1){
		stroke(rcol(), 200);
		for(int i = -int(random(des)); i < width; i+=des){
			line(i, 0, i, height);
		}
	}else{
		stroke(rcol(), 200);
		strokeWeight(2);
		des = int(random(5, 14));
		for(int i = -int(random(des)); i < width+height; i+=des){
			line(i, -2, -2, i);
		}
	}
	for(int i = 0; i < 3; i++){
		float x = random(width);
		float y = random(height);
		float tam = random(30, 900);
		float ang = 0;
		stroke(0, 4);
		noFill();
		for(int j = 5; j > 0; j--){
			strokeWeight(j);
		}
		int col = rcol();
		stroke(col);
		fill(col, 240);
		poly(x, y, tam, 6, ang);
	}
	strokeCap(SQUARE);
	for(int i = 0; i < 120; i++){
		float x = random(width);
		float y = random(height);
		float t = random(3, 30);
		float gro = t*random(0.2, 0.4);
		for(int j = 0; j < gro-2; j+=4){
			stroke(rcol());
			strokeWeight(gro-j);
			line(x-t/2, y-t/2, x+t/2, y+t/2);
			line(x+t/2, y-t/2, x-t/2, y+t/2);
		}
	}
	for(int i = 0; i < 3; i++){
		float x = random(width);
		float y = random(height);
		float tam = random(30, 700);
		float ang = 0;
		stroke(0, 4);
		noFill();
		for(int j = 5; j > 0; j--){
			strokeWeight(j);
		}
		int col = rcol();
		stroke(col);
		fill(col, 240);
		poly(x, y, tam, 6, ang);
	}
	float ttt = random(2.3, 9);
	for(int i = 0; i < 60; i++){
		float x = random(width);
		float y = random(height);
		float tam = random(30, 90)*ttt;
		float ang = int(random(6))*(TWO_PI/12);
		stroke(0, 6);
		noFill();
		for(int j = 5; j > 0; j--){
			strokeWeight(j);
			poly(x, y, tam, 3, ang);
		}
		int col = rcol();
		stroke(col);
		fill(col, 240);
		int cant = 8;
		cant = 1;
		for(int j = 0; j < cant; j++){
			noStroke();
			fill(rcol());
			float dd = 1-j*1./cant;
			poly(x, y, tam*dd, 3, ang);
		}
	}
	noStroke();
	for(int i = 0; i < 40; i++){
		float x = random(width);
		float y = random(height);
		float tam = random(5, 20);
		float umb = random(1.15, 1.3);
		fill(255, 30);
		ellipse(x, y, tam*umb, tam*umb);
		fill(rcol());
		ellipse(x, y, tam, tam);
	}
	noStroke();
	for(int i = 0; i < 20; i++){
		float x = random(width);
		float y = random(height);
		float tam = random(20, 60);
		float umb = random(1.15, 1.3);
		fill(255, 30);
		ellipse(x, y, tam*umb, tam*umb);
		fill(255);
		ellipse(x, y, tam, tam);
		/*
		for(int j = 0; j < 40; j++){
			float ang = random(TWO_PI);
			float dis = tam*random(0.8);
			float xx = x+cos(ang)*dis;
			float yy = y+sin(ang)*dis;
			float tt = tam*random(0.1, 0.3);
			float um = random(1.15, 1.3);
			//fill(255, 30);
			//ellipse(xx, yy, tt*um, tt*um);
			//fill(rcol());
			ellipse(xx, yy, tt, tt);
		}*/
	}
}

void keyPressed(){
	if(key == 's') saveImage();
	else {
		seed = int(random(9999999));
		thread("generar");
	}
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}

void poly(float x, float y, float d, int cant, float ang){
	float r = d/2;
	float da = TWO_PI/cant;
	beginShape();
	for(int i = 0; i < cant; i++){
		vertex(x+cos(ang+da*i)*r,y+sin(ang+da*i)*r);
	}
	endShape(CLOSE);
}

void degrade(int c1, int c2){
	strokeWeight(2);
	for(int i = 0; i < height; i++){
		stroke(lerpColor(c1, c2, i*1./height));
		line(0, i, width, 0);
		line(width, height-i, 0, height);
	}
}