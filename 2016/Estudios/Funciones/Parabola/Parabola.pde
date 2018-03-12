void setup() {
	size(640, 640);
}

void draw() {

}

void keyPressed(){

	background(240);
	float a = random(2)*random(1);
	float b = random(-width/2, width/2);
	float c = random(-height/4, height/4);
	float ant = parabola(-1, a, b, c);
	for(float x = 0; x < width; x+=0.5){
		float act = parabola(x-width/2, a, b, c)+height/2;
		line(x-1, ant, x, act);
		ant = act;
	}
}

float parabola(float x, float a, float b, float c){
	return (x*x)*a+b*x+c;
}