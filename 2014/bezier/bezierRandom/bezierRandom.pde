RandomBezier rx, ry, rtam;
Slider s;

void setup() {
	size(800, 600);	
	rx = new RandomBezier(10, 10, 120, 120, 200, 800);
	ry = new RandomBezier(10, 140, 120, 120, 0, 600);
	rtam = new RandomBezier(10, 270, 120, 120, 20, 80);
	s = new Slider(10, 400, 120, 20, 20, 0, 80);
}

void draw() {
	background(40);
	stroke(10, 8);
	for(int i = 1; i <= 5; i++){
		strokeWeight(i);
		line(140, 0,140, height);
	}
	strokeWeight(1);
	noStroke();
	fill(50);
	rect(0,0, 140, height);	

	rx.update();
	rx.draw();
	ry.update();
	ry.draw();
	rtam.update();
	rtam.draw();

	s.update();

	fill(#F7FF29);
	noStroke();
	for(int i = 0; i < 80; i++){
		float x = rx.rand();
		float y = ry.rand();
		float tam = rtam.rand();
		ellipse(x,y,tam,tam);
	}
}

class RandomBezier{
	int x, y, w, h;
	float min, max;
	PointSelector pa1, pa2, pc;
	RandomBezier(int x, int y, int w, int h, float min, float max){
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.min = min;
		this.max = max;

		pa1 = new PointSelector(x, y+h);
		pa2 = new PointSelector(x+w, y);
		pc = new PointSelector(x+w/2, y+h/2);
	}
	void update(){
		pa1.update();
		pa1.y = y+h;
		if(pa1.x < x) pa1.x = x;
		if(pa1.x > x+w) pa1.x = x+w;
		pa2.update();
		pa2.y = y;
		if(pa2.x < x) pa2.x = x;
		if(pa2.x > x+w) pa2.x = x+w;
		pc.update();
		if(pc.x < x) pc.x = x;
		if(pc.x > x+w) pc.x = x+w;
		if(pc.y < y) pc.y = y;
		if(pc.y > y+h) pc.y = y+h;
	}
	void draw(){
		fill(20);
		stroke(60);
		rect(x,y, w, h, 4);
		bezier(pa1.x, pa1.y, pc.x, pc.y, pc.x, pc.y, pa2.x, pa2.y);
		pa1.draw();
		pa2.draw();
		pc.draw();
	}
	float rand(){
		float r = random(1);
		float xx = bezierPoint(pa1.x, pc.x, pc.x, pa2.x, r);
		float yy = bezierPoint(pa1.y, pc.y, pc.y, pa2.y+h, r);
		return map(xx,x,x+w,min,max);
	}
};

class PointSelector{
	boolean move, on;
	float x, y, tam;
	PointSelector(float x, float y){
		this.x = x;
		this.y = y;
		tam = 6;
		move = on = false;
	}
	void update(){
		if(dist(mouseX, mouseY, x, y) < tam/2){
			on = true;
			if(mousePressed) move = true;
		}else{
			on = false;
		}
		if(move){
			x = mouseX;
			y = mouseY;
			if(!mousePressed) move = false;
		}
	}
	void draw(){
		noStroke();
		if(on) stroke(100);
		if(move) stroke(120);
		fill(90);
		ellipse(x,y, tam, tam);
	}
};

class Slider{
	boolean on, move;
	float x, y, w, h, sw;
	float val, min, max;
	Slider(float x, float y, float w, float h, float val, float min, float max){
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		sw = h/2;
		this.val = val;
		this.min = min;
		this.max = max;
	}
	void update(){
		if(mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h){
			on = true;
		}else{
			on = false;
		}
		if(on && mousePressed){
			move = true;
		}
		if(move){
			if(!mousePressed) move = false;
			val = constrain(map(mouseX, x+sw/2, x+w-sw/2, min, max),min,max);
		}
		draw();
	}
	void draw(){
		fill(20);
		stroke(60);
		rect(x, y, w, h, 4);
		float dx = map(val, min, max, 0, w-sw);
		fill(50);
		stroke(60);
		rect(x+dx, y, sw, h, 4);
		for(int i = -1; i <= 1; i++){
			fill(70);
			stroke(60);
			float xx = x+sw/2 + dx;
			float yy = y+h/2 + h*i*0.25;
			float tt = h/5;
			ellipse(xx,yy,tt,tt);
		}
	}
};

