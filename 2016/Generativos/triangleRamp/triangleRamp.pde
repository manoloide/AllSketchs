ColorRamp cr;

void setup() {
	size(640, 640, P2D);
	generate();
}

void draw() {
}

void keyPressed(){
	if(key == 's') saveImage();
	else generate();
}

void generate(){
	generateColors();
	cr.show(0, 0, width, height);

	if(random(1) > 1){
		for(int i = 0; i < 200; i++){
			color c1 = cr.getColor(random(1));
			color c2 = cr.getColor(random(1));
			float x = random(width);
			float y = random(height);
			float r = random(20, 140*random(0.5, 1));
			float a = random(TWO_PI);

			float da = TWO_PI/3;

	/*
			stroke(0, 6);
			noFill();
			for(int st = 8; st > 0; st--){
				strokeWeight(st);
				beginShape();
				for(int j = 0; j < 3; j++){
					vertex(x+cos(a+da*j)*r, y+sin(a+da*j)*r);
				}	
				endShape(CLOSE);
			}		
			*/
			noStroke();
			for(int j = 0; j < 3; j++){
				beginShape();
				fill(c1);
				vertex(x, y);
				fill(c2);
				vertex(x+cos(a+da*j)*r, y+sin(a+da*j)*r);
				vertex(x+cos(a+da*(j+1))*r, y+sin(a+da*(j+1))*r);
				endShape();
			}
		}
	}
	else {
		noStroke();
		rectMode(CENTER);
		int cc = int(random(3, 100*random(1)));
		float tt = width*1./cc;
		for(int j = -2; j < cc/2+1; j++){
			for(int i = -2; i < cc/2+1; i++){
				fill(cr.getColor(random(1)));
				float x = i*tt-tt; 
				float y = j*tt-tt;
				rect(width/2+x, width/2+y, tt, tt);
				rect(width/2-x, width/2+y, tt, tt);
				rect(width/2+x, width/2-y, tt, tt);
				rect(width/2-x, width/2-y, tt, tt);
			}
		}
	}

	PGraphics cap = createGraphics(width, height);
	cap.beginDraw();
	cap.copy(g, 0, 0, width, height, 0, 0, width, height);
	cap.endDraw();

	/*
	float det = random(0.02)*random(1);
	float dd = random(2, random(10, 600));
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			float a = noise(i*det, j*det)*TWO_PI;
			set(i, j, getSmooth(cap, i+cos(a)*dd, j+sin(a)*dd));
		}
	}
	*/

	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			stroke(255, random(22)*random(1));
			point(i, j);
		}
	}
}

color getSmooth(PGraphics img, float x, float y){
	int x1 = int(constrain(x, 0, img.width-1));
	int y1 = int(constrain(y, 0, img.height-1));
	int x2 = int(constrain(x+1, 0, img.width-1));
	int y2 = int(constrain(y+1, 0, img.height-1));
	color c1 = lerpColor(img.get(x1, y1), img.get(x2, y1), x%1.0);
	color c2 = lerpColor(img.get(x1, y2), img.get(x2, y2), x%1.0);
	return lerpColor(c1, c2, y%1.0);
}

void saveImage() {
	String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
	saveFrame(timestamp+".png");
}

void generateColors(){
	cr = new ColorRamp();
	
	cr.addColor(color(random(255), random(255), random(255)), 0);
	cr.addColor(color(random(255), random(255), random(255)), 1);
	cr.addColor(color(random(255), random(255), random(255)), random(1));
	cr.addColor(color(random(255), random(255), random(255)), random(1));
	/*
	cr.addColor(color(random(255)), 0);
	cr.addColor(color(random(255)), 1);
	cr.addColor(color(random(255)), random(1));
	cr.addColor(color(random(255)), random(1));
	*/
}

class Color {
	color col;
	float pos;
	Color (int col, float pos) {
		this.col = col;
		this.pos = pos;
	}
}

class ColorRamp {
	ArrayList<Color> colors;
	ColorRamp () {
		colors = new ArrayList<Color>();
	}

	void addColor(int c, float p){
		p = constrain(p, 0, 1);
		int ind = 0;
		for(int i = 0; i < colors.size(); i++){
			ind = i;
			if(p >= colors.get(i).pos){
				break;
			}
		}
		colors.add(ind, new Color(c, p));
	}

	color getColor(float p){
		p = constrain(p, 0, 1);
		color col = color(0);

		if(colors.size() > 0) col = colors.get(0).col;

		for(int i = 1; i < colors.size(); i++){
			if(p >= colors.get(i).pos){
				col = lerpColor(colors.get(i-1).col, colors.get(i).col, map(p, colors.get(i-1).pos, colors.get(i).pos, 0, 1));
				break;
			}
		}
		return col;
	}

	void show(float x, float y, float w, float h){
		for(int i = 0; i < w; i++){
			stroke(getColor(i*1./w));
			line(x, y+i, x+w, y+i);
		}
	}

}