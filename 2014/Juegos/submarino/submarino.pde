ArrayList<Tipito> tipitos;

void setup(){
	size(800, 600);
	tipitos = new ArrayList<Tipito>();
	tipitos.add(new Tipito(width/2, height/2));
}

void draw(){
	background(5);

	for(int i = 0; i < tipitos.size(); i++){
		Tipito t = tipitos.get(i);
		t.update();
	}

	noStroke();
	fill(80);
	rect(0,height-60, width, 60);
	int cant = 5;
	int tt = 40;
	int bb = 10;
	fill(200);
	for(int i = 0; i < cant; i++){
		rect(width/2 + (i-cant/2.) * (bb+tt) + bb/2, height-70, tt, tt);
	}

	stroke(250, 40);
	line(width/2, 0, width/2, height);
	line(0, height/2, width, height/2);
}

class Tipito{
	boolean mover, select, sobre;
	color cpiel, cremera, cpantalon;
	float x, y, nx, ny, w, h;
	Tipito(float x, float y){
		this.x = x; 
		this.y = y;
		w = 16;
		h = 32;
		pushStyle();
		colorMode(HSB, 240);
		cpiel = color(random(30), random(70,230), random(200, 230));
		cremera = color(random(240), random(70,230), random(50, 180));
		cpantalon = color(random(240), random(70,230), random(50, 180));
		popStyle();
	}
	void update(){
		if(mouseX >= x-w/2 && mouseX < x+w/2 && mouseY >= y-h/2 && mouseY < y+h/2) sobre = true;
		else sobre = false;
		if(mousePressed){
			if(sobre && mouseButton == LEFT) select = true;
			if(!sobre && mouseButton == LEFT) select = false;
			if(select && mouseButton == RIGHT){
				nx = mouseX;
				ny = y;
				mover = true;
			} 
		}
		if(mover){
			float ang = atan2(ny-y,nx-x);
			x += cos(ang);
			y += sin(ang);
			if(dist(x,y,nx,ny) < 1){
				mover = false;
			}
		}
		if(keyPressed){
			pushStyle();
			colorMode(HSB, 240);
			cpiel = color(random(30), random(70,220), random(200, 230));
			cremera = color(random(240), random(70,230), random(50, 180));
			cpantalon = color(random(240), random(70,230), random(50, 180));
			popStyle();
		}
		draw();
	}
	void draw(){
		noStroke();
		fill(cpiel);
		rect(x-w/2, y-h/2, w, h/2);
		fill(cremera);
		rect(x-w/2, y, w, h/2);

		if(select){
			stroke(20, 240, 30);
			noFill();
			rect(x-w/2, y-h/2, w, h);
		}
	}
}