ArrayList<Caminador> caminadores;
PGraphics gfondo, ggui;
void setup() {
	size(800, 600);
	background(20);
	generar();
}
void draw() {
	if(frameCount%20 == 0) frame.setTitle("fps: "+frameRate);
	background(20);
	clearGraphics(gfondo, 250);
	clearGraphics(ggui, 252);
	for(int j = 0; j < 30; j++){
		for(int i = 0; i < caminadores.size(); i++){
			Caminador c = caminadores.get(i);
			c.update();
		}
	}


	image(gfondo, 0, 0);
	image(ggui, 0, 0);
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void generar(){
	background(20);
	gfondo = createGraphics(width, height);
	ggui = createGraphics(width, height);
	int cant = int(random(2, 12));
	caminadores = new ArrayList<Caminador>();
	for(int i = 0; i < cant; i++){
		caminadores.add(new Caminador(width/2, height/2));
	}
}

void clearGraphics(PGraphics gra, float cant){
	gra.beginDraw();
	PImage aux = gra.get();
	gra.clear();
	gra.tint(255, cant);  
	gra.image(aux, 0, 0);
	gra.endDraw();
}

class Caminador{
	color col;
	float gro;
	int ax, ay, x, y, r, vel;
	float inteligencia, carisma;  
	Caminador(int x, int y){
		this.x = ax = x;
		this.y = ay = y;
		vel = 16;
		generar();
	}
	void update(){
		if(random(5)<5){
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
		gfondo.strokeWeight(gro);
		gfondo.stroke(col, 10);
		gfondo.noFill();
		if(r < 4){
			gfondo.line(ax, ay, x, y);
		}
		else if(r == 4){
			gfondo.strokeWeight(gro/2*random(0.9));
			gfondo.stroke(col, 200);
			float tt = gro * random(0.2, 0.8);
			gfondo.strokeCap(SQUARE);
			gfondo.line(x-tt, y-tt, x+tt, y+tt);
			gfondo.line(x+tt, y-tt, x-tt, y+tt);
		}
		else if(r == 5 && random(2000)<2){
			dialogo(x, y, 80, 50, col);
		}
		else{
			gfondo.ellipse(x, y, 6, 6);
		}
	}

	void generar(){
		gro = random(vel/2);
		pushStyle();
		colorMode(HSB);
		col = color((hue(#BB77FF)+int(random(6)*50))%256, saturation(#BB77FF), brightness(#BB77FF));
		popStyle();


	}
}

void dialogo(float x, float y, float w, float h, color col){
	ggui.strokeWeight(1);
	ggui.stroke(col, 200);
	ggui.fill(col, 160);
	ggui.beginShape();
	ggui.vertex(x,y);
	ggui.vertex(x, y-h);
	ggui.vertex(x+w, y-h);
	ggui.vertex(x+w, y-h*0.2);
	ggui.vertex(x+w*0.1, y-h*0.2);
	ggui.endShape(CLOSE);
	ggui.noStroke();
	ggui.fill(250, 90);
	int bw = int(w*0.05);
	int tt = int(bw*1.4);
	int cmax = int(w/tt)-2;
	int ch = int(h*0.8-bw*2)/tt-2;
	for (int i = 0; i < ch; ++i) {
		int cc = int(random(2, cmax+1));
		ggui.rect(x+bw, y-h+i*(tt+bw)+bw, tt*cc, tt);
	}
}

void saveImage(){
	int c = (new File(sketchPath)).listFiles().length-1;
	saveFrame(c+".png");
}