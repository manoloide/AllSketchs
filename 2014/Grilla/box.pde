class Box{
	float x1, y1, x2, y2;
	Box(float x1, float y1, float x2, float y2){
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
	}
	void update(){
		draw();
	}
	void draw(){
		stroke(220);
		fill(250, 128);
		rectMode(CORNERS);
		rect(x1, y1, x2, y2);
		rectMode(CORNER);
	}
}