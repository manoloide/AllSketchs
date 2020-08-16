PFont helve;
PGraphics noise;

void setup() {
	size(800, 400);
	helve = createFont("HelveticaLight.otf", 12, true);
	textFont(helve);
	generar();
}

void draw() {
	
}

void keyPressed(){
	if(key == 's') saveFrame("#####");
	else generar();
}

void generar(){
	noise = generarNoise(width, height);
	image(noise, 0, 0);
	return;
	/*
	float tam = 20;
	background(252);
	noStroke();
	for(int j = 0; j < height/tam; j++){
		for(int i = 0; i < width/tam; i++){
			float x = i*tam+tam/2;
			float y = j*tam+tam/2;
			float val = red(noise.get(int(x),int(y)))/255;
			float dim = map(val, 0, 1, tam, 0);
			if(val > 0.3) fill(20, 120, 255);
			else fill(80, 40, 4);
			//fill(10);
			ellipse(x, y, dim, dim);
			fill(252);
			ellipse(x, y, dim/3, dim/3);

			if(val < 0.01 && random(100) < 2) cartelLugar("hola", x, y);
		}
	}
	*/
	/*
	noStroke();
	fill(#FFFF30, random(20,70));
	float tt = random(width/2,width*1.2);
	ellipse(random(width), random(height), tt, tt);
	float rad = random(height/2*0.7, height/2);
	stroke(#FFFF30);
	noFill();
	for(int i = 0; i < rad*10; i+=20){
		strokeWeight(5);//random(0.5,3));		
		float x = width/4;
		float y = height/2;
		float a1 = random(TWO_PI);
		float a2 = a1+random(PI/4,PI);
		arc(x, y, i, i, a1, a2);
	}
	*/
}

PGraphics generarNoise(int w, int h){
	PGraphics aux = createGraphics(w, h);
	//defaul 0.003
	float ns1 = random(0.0001, 0.005);
	float ns2 = 0.02;
	noiseSeed(int(random(99999999)));
	aux.beginDraw();
	for (int j = 0; j < h; ++j) {
		for (int i = 0; i < w; ++i) {
			float val = noise(i*ns1, j*ns1);
			//if(val < 0.5) val = sin(val*2*PI/2)*0.5;
			//if(val > 0.5) val = 0.5-sin(((val*2))*PI/2)*0.5;
			//val += (noise(i*ns2, j*ns2)-0.5)*0.09+0.09;
			color col = color(val*256);
			aux.set(i,j,col);
		}
	}
	aux.endDraw();
	return aux;
}

void cartelLugar(String nombre, float x, float y){
	textAlign(CENTER, CENTER);
	float w = textWidth(nombre)+4;
	float h = 12;
	noStroke();
	fill(#FFFF30);
	rect(x-w/2, y-h-h/2, w, h);
	triangle(x-w/6, y-h/2, x+w/6, y-h/2, x, y);
	fill(252);
	text(nombre, x-w/2, y-h-h/2, w, h);  
}