ArrayList<Cargador> cargadores;

void setup() {
	size(640, 480);
	cargadores = new ArrayList<Cargador>();
	cargadores.add(new Cargador(width/2, height/2, width*0.3));
}

void draw() {
	background(20);
	for(int i = 0; i < cargadores.size(); i++){
		Cargador c = cargadores.get(i);
		c.update();
		if(c.remove) cargadores.remove(i--);
	}
}

class Cargador{
	boolean remove;
	float x, y, d, ang;
	int time, maxTime;
	Cargador(float x, float y, float d){
		this.x = x;
		this.y = y;
		this.d = d;
		ang = -PI/2;
		time = 160;
		maxTime = 180;
	}
	void update(){
		float dis = dist(mouseX, mouseY, x, y);
		if(dis < d/2) time++;
		else time--;
		time = constrain(time, 0, maxTime);
		draw();
	}
	void draw(){
		float da = map(time, 0, maxTime, 0, TWO_PI);
		strokeWeight(2);
		stroke(40);
		fill(30);
		ellipse(x, y, d, d);
		stroke(50);
		fill(40);
		if(da > TWO_PI-PI/2) fill(lerpColor(color(40), color(0,255,0), map(da,TWO_PI-PI/2,TWO_PI,0,0.6)));
		if(da < PI/2) fill(lerpColor(color(40), color(255,0,0), map(da,PI/2,0,0,0.6)));
		arc(x, y, d, d, ang-da, ang);
	}
}