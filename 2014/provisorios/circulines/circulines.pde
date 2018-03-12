int seed = int(random(9999999));


void setup(){
	size(800, 400);
	generar();
}

void draw(){

}

void generar(){
	randomSeed(seed);
	background(#DACBCB);
	int t = 20;
	int dd = 40;
	for(int j = 0; j < height/dd; j++){
		for(int i = 0; i < width/dd; i++){
			float x = dd/2 + dd * i;
			float y = dd/2 + dd * j;
			float tt = dd*0.8;
			noStroke();
			fill(#373737, 30);
			ellipse(x, y, tt, tt);
		}	
	}
	noFill();
	for(int i = 0; i < width/t; i++){
		stroke(#7AE80F);
		strokeWeight(1);
		float x = width/2;
		float y = height/2;
		float tt = t * (i+1);
		ellipse(x, y, tt, tt);
		float a1 = random(TWO_PI);
		float a2 = a1 + random(PI/6, PI*3/2);
		strokeWeight(t/2 -2);
		arc(x, y, tt, tt, a1, a2);
		strokeWeight(2);
		stroke(#373737);
		arc(x, y, tt, tt, a1, a2);
	}
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		generar();
	}
}