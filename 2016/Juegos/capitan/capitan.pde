ArrayList<PVector> points;

PShader post;

void setup() {
	size(800, 600, P2D);

	points = new ArrayList<PVector>();

	post = loadShader("post.glsl");
	post.set("resolution", float(width), float(height));
}

void draw() {
	background(10);

	for(int i = 1; i < points.size(); i++){
		PVector p1 = points.get(i-1);
		PVector p2 = points.get(i);

		lineSegment(p1.x, p1.y, p2.x, p2.y);	

		fill(250);
		noStroke();
		ellipse(p2.x, p2.y, 4, 4);
		noFill();
		stroke(250);
		ellipse(p2.x, p2.y, 8, 8);
	}
	

	post.set("mouse", float(mouseX), float(mouseY));
	post.set("time", millis()/1000.);
	filter(post);
}

void mousePressed(){
	points.add(new PVector(mouseX, mouseY));
}

void lineSegment(float x1, float y1, float x2, float y2){
	/*
	stroke(255, 0, 0, 100);
	line(x1, y1, x2, y2);
	*/

	stroke(255, 120);
	int cc = 10;
	float l = 0.4;//(frameCount*0.01)%1;
	float t = (frameCount*0.01)%1;
	float dis = dist(x1, y1, x2, y2);
	float ang = atan2(y2-y1, x2-x1);
	float dd = dis/(cc-0.5);
	dd += (dd*(1-l))/(cc-0.5);

	float d1, d2, cos, sin;
	cos = cos(ang);
	sin = sin(ang);
	for(int i = -1; i < cc-1; i++){
		d1 = (dd*(i+t));
		d2 = (dd*(i+l+t));
		
		if(i == -1){
			d1 = max(0, d1);
			d2 = max(0, d2);
		}
		if(i == cc-2){
			d1 = min(dis, d1);
			d2 = min(dis, d2);
		}
		//d2 = (i == cc-1)? (dd*(i+l+t)) : (dd*(i+l+t));
		line(x1+cos*d1, y1+sin*d1, x1+cos*d2, y1+sin*d2);
	}
}