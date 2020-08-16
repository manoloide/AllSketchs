void setup(){
	size(800, 800);
	generar();
}

void draw(){

}

void keyPressed(){
	if(key == 's') saveFrame("#####.png");
	else generar();
}

void generar(){
	class Quad{
		int x, y, w, h;
		Quad(int x, int y, int w, int h){
			this.x = x; 
			this.y = y;
			this.w = w;
			this.h = h;
		}
	}
	ArrayList<Quad> quads = new ArrayList<Quad>();
	quads.add(new Quad(0,0,width,height));
	for(int i = 0; i < quads.size(); i++){
		println(i);
		Quad q = quads.get(i);
		if(random(1)<q.w/(width*2)){
			q.w /= 2;
			q.h /= 2;
			quads.add(new Quad(q.x+q.w, q.y+q.h, q.w, q.h));
			quads.add(new Quad(q.x+q.w, q.y, q.w, q.h));
			quads.add(new Quad(q.x, q.y+q.h, q.w, q.h));
		}
	}
	noStroke();
	for(int i = 0; i < quads.size(); i++){
		Quad q = quads.get(i);
		PGraphic tata = createGraphic(q.w, q.h);
		tata.beginDraw();
		tata.background(255-random(8),255-random(8),255-random(8));
		tata.endDraw();
		image(tata, q.x, q.y);
	}
}