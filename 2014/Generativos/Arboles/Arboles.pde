void setup() {
	size(800, 800);
	generar();
}

void draw() {
	
}

void generar(){
	background(250);
	Arbol a = new Arbol(width/2, height/3*2, height/3);
	a.init();
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}

class Arbol{
	boolean struc;
	int seed;
	float x, y, w, h;
	Arbol(float x, float y, float h){
		this.x = x; 
		this.y = y; 
		this.h = h;
		this.w = h*random(0.18, 0.95);

		struc = true;
		seed = int(random(999999999));
	}

	int cantRamas, maxRami;
	float desang, probRami; 
	void init(){
		randomSeed(seed);
		desang = random(-0.02,0.02);
		cantRamas = int(random(2, 9));
		maxRami = int(random(1, 4));
		probRami = 0;
		if(maxRami > 1){
			probRami = random(1);
		}
		stroke(0);
		float des = h*map(cantRamas, 2, 8, 0.5, 0.20);
		float ang = TWO_PI-PI/2+desang;
		rama(x, y, cantRamas, ang, des);

		if(struc) drawStruc();
	}
	void rama(float px, float py, int rama, float ang, float des){
		println(rama);
		float x = px + cos(ang)*des;
		float y = py + sin(ang)*des;
		strokeWeight(map(rama, 0, cantRamas-1, 1, 5));
		line(px, py, x, y);
		des *= map(rama, 2, 8, 1, 0.70);
		ang += desang;
		rama -= 1;
		if(rama < 0) return;
		int cant = 0;
		if(random(1) > probRami){
			cant = int(random(maxRami)+1);
		}
		for(int i = 0; i < cant; i++){
			float auxang = ang + desang*(i-cant/2+((random(1) < 0.5)?0:0.5))*80;
			rama(x, y, rama, auxang, des);
		}
	}

	void drawStruc(){
		strokeWeight(1);
		stroke(#4B9EFF, 80);		
		noFill();
		line(x, y-h, x, y);
		line(x-w/2, y-h, x+w/2, y);
		line(x-w/2, y, x+w/2, y-h);
		rect(x-w/2,y-h,w,h);
	}
}