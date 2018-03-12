ArrayList <Movedor> movedores;
boolean click;
int tam, w, h;
void setup(){
	size(800, 400);
	tam = 40;
	w = width/tam;
	h = height/tam; 
	iniciar();
}

void draw(){
	background(20);
	stroke(255, 4);
	for(int j = 0; j <= height; j+=tam){
		line(0, j, width, j);
	}
	for(int i = 0; i <= width; i+=tam){
		line(i, 0, i, height);
	}
	for(int i = 0; i < movedores.size(); i++){
		Movedor m = movedores.get(i);
		m.update();
		if(m.eliminar) movedores.remove(i--);
	}
	click = false;
}
void keyPressed(){
	iniciar();
}
void mousePressed(){
	click = true;
	movedores.add(new Movedor(mouseX, mouseY, tam));
}

void iniciar(){
	movedores = new ArrayList<Movedor>();
	while(movedores.size() < 40){
		float x = (int(random(width))/tam)*tam + tam/2;
		float y = (int(random(height))/tam)*tam + tam/2;
		movedores.add(new Movedor(x, y, tam));
	}
}

class Movedor{
	boolean sobre, eliminar, mover;
	float x, y; 
	int cx, cy, tam;
	PImage img;
	Movedor(float x, float y, int tam){
		this.x = x;
		this.y = y;
		this.tam = tam;
		cx = int(x)/int(tam);
		cy = int(y)/int(tam);
		mover = true;
		img = crerCosito(tam);
	}
	void update(){
		if(mouseX >= x-tam/2 && mouseX < x+tam/2 && mouseY >= y-tam/2 && mouseY < y+tam/2){
			sobre = true;
		}else{
			sobre = false;
		}
		//if(sobre && click) eliminar = true;
		if(mover){
			float dx = cx * tam + tam/2;
			float dy = cy * tam + tam/2;
			float ang = atan2(dy-y,dx-x);
			float vel = dist(x, y, dx, dy)/5;
			x += cos(ang)*vel;
			y += sin(ang)*vel;
			if(vel < 0.05){
				mover = false;
				x = round(x);
				y = round(y);
			}
		}else if(sobre){
			mover = true;
			if(random(1)<0.5){
				if((random(1) < 0.5 && cx > 0) || cx+1 >= w) cx--;
				else cx++;
			}else{
				if((random(1) < 0.5 && cy > 0) || cy+1 >= h) cy--;
				else  cy++;
			}
		}
		draw();
	}
	void draw(){
		/*
		rectMode(CENTER);
		noStroke();
		fill(40);
		rect(x, y, tam , tam);
		rectMode(CORNER);
		*/
		image(img, x-tam/2, y-tam/2);
	}
}

PImage crerCosito(int tam){
	PGraphics gra = createGraphics(tam, tam);
	PImage aux = createImage(tam, tam, ARGB);
	color c1 = color(random(10,240));
	color c2 = color(random(10,240));
	gra.beginDraw();
	switch(int(random(3))){
	case 0:
		int cant = int(random(2, 10));
		float tt = tam*1.5/cant;
		gra.noStroke();
		for(int i = cant; i > 0; i--){
			gra.fill(lerpColor(c1, c2, i*1./cant));
			gra.ellipse(tam/2, tam/2, tt*i , tt*i);
		}
		break;
	case 1:
		gra.background(c1);
		float gro = random(tam*0.05, tam*0.2);
		float ang = random(TWO_PI);
		gra.strokeWeight(gro);
		gra.stroke(c2);
		float dx = cos(ang+PI/2)*tam;
		float dy = sin(ang+PI/2)*tam;
		for(float i = -tam; i < tam+gro; i+=gro*2){
			float x1 = tam/2+cos(ang)*i-dx;
			float y1 = tam/2+sin(ang)*i-dy;
			float x2 = tam/2+cos(ang)*i+dx;
			float y2 = tam/2+sin(ang)*i+dy;
			gra.line(x1,y1,x2,y2);
		}
		break;
	case 2:
		cant = int(random(2, 10));
		tt = tam*1./cant;
		gra.rectMode(CENTER);
		gra.noStroke();
		for(int i = cant; i > 0; i--){
			gra.fill(lerpColor(c1, c2, i*1./cant));
			gra.rect(tam/2, tam/2, tt*i , tt*i);
		}
		break;
	}
	gra.endDraw();
	for(int i = 0; i < gra.pixels.length; i++){
		aux.pixels[i] = gra.pixels[i];
	}
	return aux;
}