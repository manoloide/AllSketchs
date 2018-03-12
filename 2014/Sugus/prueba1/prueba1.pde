color paleta[];
int seed;
PImage marca, textura;

void setup(){
	size(800, 600);
	marca = loadImage("/../marca.png");
	textura = loadImage("/../textura.png");
	paleta = new color[5];
	paleta[0] = color(#FF0000);
	paleta[1] = color(#FF9900);
	paleta[2] = color(#FFFF00);
	paleta[3] = color(#22AA00);
	paleta[4] = color(#00AA22);
	thread("generar");
}

void draw(){
	sugus(random(width), random(height), random(80, 120), random(TWO_PI));
}

void keyPressed(){
	if(key == 's') saveFrame(""+seed);
	thread("generar");
}

void generar(){
	seed = int(random(999999));
	randomSeed(seed);
	for(int i = 0; i < 5; i++){
		filter(BLUR, 1-i/5.);
		for(int j = 0; j < 10; j++){
			float tam = 60+2*8;
			sugus(random(width), random(height), tam, random(TWO_PI));
		}
	}
}

void sugus(float x, float y, float tam, float ang){
	pushMatrix();
	PGraphics aux = createGraphics(int(tam), int(tam));
	float w = textura.width*tam/300;
	float h = textura.height*tam/300;
	float xx = -w/4;
	float yy = -h/2;
	aux.beginDraw();
	aux.tint(paleta[int(random(paleta.length))]);
	translate(x, y);
	rotate(ang);
	aux.image(textura, 0, 0, w, h);
	aux.noTint();
	aux.image(marca, 0, 0, w, h);
	aux.endDraw();
	image(aux, x-tam/2, y-tam/2);
	popMatrix();
}