void setup(){
	size(600, 800);
	generar();
}

void draw(){

}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void generar(){
	background(252);
	noFill();
	stroke(0,10);
	for(int i = 0; i < 1000000; i++){
		float x = cos(random(PI))*width/2+width/2;
		float y = cos(random(PI))*height/2+height/2;
		ellipse(x, y, 2, 2);
	}

	for(int i = 0; i < 5; i++){
		circle(random(width), random(height), random(30,200), int(random(20, 1000)));
	}
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-1;
	saveFrame(nf(n,3)+".png");
}

void circle(float x, float y, float dim, int cantidad){
	ArrayList<PVector> points = new ArrayList<PVector>();
	float r = dim/2;
	stroke(0, 200);
	fill(255);
	for(int i = 0; i < cantidad; i++){
		float dis = (sin(random(0, PI/2)))*r;
		float ang = random(TWO_PI);
		float xx = x+cos(ang)*dis;
		float yy = y+sin(ang)*dis;
		ellipse(xx, yy, 10, 10);
	}
}