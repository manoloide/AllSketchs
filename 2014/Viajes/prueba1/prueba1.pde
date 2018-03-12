//agregar formas grandes onda planos al fondo, medio niponas darles algo de textura,

int paleta[] = {
	#DF8600,
	#427857,
	#1B1B1B,
	#998D8D,
	#15B82E
};

void setup() {
	size(800, 800);
	thread("generar");
}

void draw() {
	
}

void generar(){
	background(rcol());
	stroke(255, 20);
	int esp = int(random(2, 8));
	for(int i = -int(random(esp)); i < width+height; i+=esp){
		line(-2, i, i, -2);
	}
	for(int i = 0; i < 30; i++){
		for(int j = 0; j < 16; j++){
			stroke(rcol());
			cruz(random(width), random(height), random(100)*random(1)*random(1));
		}
		forma(random(width), random(height), 100);
		if(random(1) < 0.2)dialog(random(width), random(height), 120, 40);
		if(i == 20){
			noStroke();
			fill(rcol());
			forma2(width*random(0.2, 0.5), height*random(0.2, 0.5), width);
		}
	}
	PVector pos = new PVector(100, 100);
	PVector des = (random(1) < 0.5)? new PVector(0, 1) : new PVector(1, 0);
	float tt = 40;
	for(int i = 0; i < 4; i++){
		fill(rcol());
		stroke(rcol());
		ellipse(pos.x, pos.y, tt, tt);
		float a1 = random(TWO_PI);
		float a2 = a1+random(PI/2, TWO_PI);
		stroke(rcol());
		noFill();
		arc(pos.x, pos.y, tt*1.5, tt*1.5, a1, a2);
		pos.x += des.x * tt*2.5;
		pos.y += des.y * tt*2.5;
	}
}

void forma(float x, float y, float t){
	ArrayList<PVector> puntos = new ArrayList<PVector>();
	for(int i = 0; i < 20; i++){
		puntos.add(new PVector(x-random(-t, t), y+random(-t, t)));
	}

	strokeWeight(random(8));
	stroke(rcol(), 20);
	fill(rcol(), 20);
	float des = random(1.1, 2.2);
	for(int j = 0; j < 100; j++){
		beginShape();
		for(int i = 0; i < puntos.size(); i++){
			PVector p = puntos.get(i);
			vertex(p.x, p.y);
			p.x += des;
			p.y += des;
		}
		endShape(CLOSE);
	}
}

void cruz(float x, float y, float d){
	float r = d/2;
	pushStyle();
	strokeWeight(d*0.05);
	//stroke(255, 200);
	noFill();
	//ellipse(x,y, d*1, d*1);
	popStyle();
	for(int i = 0; i < 10; i++){
		float des = random(d*0.8);
		float dd = d*random(0.05)*(1-des/d);
		strokeWeight(dd);
		ellipse(x+random(d)-r, y-des, dd, dd);
	}
	strokeCap(SQUARE);
	strokeWeight(d*random(0.4, 0.6));
	line(x-r, y-r, x+r, y+r);
	line(x+r, y-r, x-r, y+r);

}

void dialog(float x, float y, float w, float h){
	stroke(250, 240);
	fill(250, 180);
	strokeWeight(1);
	rect(x, y, w, h, 3);
	noStroke();
	fill(250, 240);
	triangle(x+8, y+h, x+10, y+h+4, x+12, y+h);
}

void forma2(float x, float y, float t){
	beginShape();
	float desx = random(0.1,0.8)*t;
	float desy = random(0.1,0.8)*t;
	vertex(x+t, y);
	vertex(x+t, y+t);
	vertex(x, y+t);
	vertex(x, y+desy);
	vertex(x+desx, y);
	endShape(CLOSE);
}

void keyPressed(){
	if(key == 's') saveImage();
	else thread("generar");
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-2;
	saveFrame(nf(n, 3)+".png");
}

int rcol(){
	color c1 = color(paleta[int(random(paleta.length))]);
	color c2 = color(paleta[int(random(paleta.length))]);
	//return lerpColor(c1, c2, random(1));
	return paleta[int(random(paleta.length))];
}