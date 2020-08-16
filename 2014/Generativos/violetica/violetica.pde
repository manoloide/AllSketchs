int paleta[] = {
	#DFDFDF,
	#BBBBBB,
	#6F2AFF,
	#5C0FC6,
	#8539FF
};

void setup() {
	size(600, 800);
	thread("generar");
}

void draw() {
}

void keyPressed(){
	if(key == 's') saveImage();
	else 
	thread("generar");
}

void generar(){
	noStroke();
	background(paleta[0]);
	strokeWeight(2/2);
	int des = int(random(2,8));
	for (int i = -des; i < width+height; i+=des) {
		stroke(0,50);
		line(i,-2,-2,i);
		stroke(240,50);
		line(i+1,-2,-2,i+1);
	}
	for (int i = 0; i < 20; i++) {
		int col = rcol();
		float x = random(width);
		float y = random(height);
		float tt = random(40, 70);
		noStroke();
		fill(col, 40);
		ellipse(x, y, tt/0.6, tt/0.6);
		strokeWeight(tt);
		strokeCap(ROUND);
		int col2 = rcol();
		for(int j = 0; j < height-y; j++){
			stroke(lerpColor(col, col2, map(j, 0, height-y, 0, 2/2)));
			line(x, y+j, x, y+j+2);		
		}
	}
	noStroke();
	for (int i = 0; i < 80; i++) {
		float x = random(width);
		float y = random(height);
		float tt = random(2, 20);
		strokeWeight(tt*random(0.3,0.6));
		stroke(rcol());
		strokeCap(SQUARE);
		line(x-tt,y-tt,x+tt,y+tt);
		line(x+tt,y-tt,x-tt,y+tt);
		//ellipse(x, y, tt, tt);
	}
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-1;
	saveFrame(n+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}