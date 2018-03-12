ArrayList<Caminador> caminadores;
boolean grabar = false;
int frames = 30*8;

void setup() {
	size(800, 600);
	background(20);
	generar();
}
void draw() {
	//if(frameCount%30 == 0) println(frameRate);
	noStroke();
	fill(8, 8);
	rect(0,0,width, height);
	for(int j = 0; j < 90; j++){
		for(int i = 0; i < caminadores.size(); i++){
			Caminador c = caminadores.get(i);
			c.update();
		}
	}
	if(grabar){
		saveFrame("export/####.png");
		if(frameCount >= frames) exit();
	}
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void generar(){
	background(20);
	int cant = int(random(2, 12));
	caminadores = new ArrayList<Caminador>();
	for(int i = 0; i < cant; i++){
		caminadores.add(new Caminador(width/2, height/2));
	}
	frameCount = 0;
}

class Caminador{
	color col;
	float gro;
	int ax, ay, x, y, r, vel;
	Caminador(int x, int y){
		this.x = ax = x;
		this.y = ay = y;
		vel = 16;
		gro = random(vel/2);
		pushStyle();
		colorMode(HSB);
		col = color((hue(#BB77FF)+int(random(6)*50))%256, saturation(#BB77FF), brightness(#BB77FF));
		popStyle();
		draw();
	}
	void update(){
		if(random(6)<5){
			ax = x;
			ay = y;
			r = int(random(20));
			if(r == 0) x -= vel;
			else if(r == 1) y -= vel;
			else if(r == 2) x += vel;
			else if(r == 3) y += vel;
			draw();
			if(dist(x, y, width/2, height/2) > width){
				ax = x = width/2;
				ay = y = height/2;
			}
		}
	}
	void draw(){
		strokeWeight(gro);
		stroke(col, 8);
		noFill();
		if(r < 4){
			line(ax, ay, x, y);
		}
		else if(r == 4){
			strokeWeight(gro/2*random(0.9));
			stroke(col, 200);
			float tt = gro * random(0.2, 0.8);
			strokeCap(SQUARE);
			line(x-tt, y-tt, x+tt, y+tt);
			line(x+tt, y-tt, x-tt, y+tt);
		}
		else if(r == 5 && random(2000)<2){
			strokeWeight(1);
			stroke(col, 200);
			fill(col, 160);
			dialogo(x, y, 80, 50);
		}
		else{
			ellipse(x, y, 6, 6);
		}
	}
}

void dialogo(float x, float y, float w, float h){
	beginShape();
	vertex(x,y);
	vertex(x, y-h);
	vertex(x+w, y-h);
	vertex(x+w, y-h*0.2);
	vertex(x+w*0.1, y-h*0.2);
	endShape(CLOSE);
	noStroke();
	fill(250, 90);
	int bw = int(w*0.05);
	int tt = int(bw*1.4);
	int cmax = int(w/tt)-2;
	int ch = int(h*0.8-bw*2)/tt-2;
	for (int i = 0; i < ch; ++i) {
		int cc = int(random(2, cmax+1));
		rect(x+bw, y-h+i*(tt+bw)+bw, tt*cc, tt);
	}
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}