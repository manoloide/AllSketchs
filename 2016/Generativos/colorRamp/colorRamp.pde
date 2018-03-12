ColorRamp cr;

void setup() {
	size(640, 640);
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
/*
	noStroke();
	for(int i = 0; i < 100000; i++){
		fill(cr.getColor(random(1)), 10);
		float x = random(width);
		float y = random(height);
		float s = random(5);
		ellipse(x, y, s, s);
	}*/
/*
	ArrayList<Parti> partis = new ArrayList<Parti>();

	for(int i = 0; i < 300; i++){
		partis.add(new Parti());
	}

	for(int j = 0; j < 1000; j++){
		for(int i = 0; i < partis.size(); i++){
			Parti p = partis.get(i);
			p.update();
		}
	}
	*/

	int cc = int(random(1, 92)*random(1));
	float tt = width*1./cc;

	noStroke();
	float r1 = random(1.4);
	float r2 = random(0.5 );
	for(int j = 0; j <= cc; j++){
		for(int i = 0; i <= cc; i++){
			float x = i*tt;
			float y = j*tt;
			float s = tt*(((i+j)%2 == 0)? r1 : r2);
			float d = random(1.2);
			fill(0, random(30));
			ellipse(x+d, y+d, s, s);
			fill(cr.getColor(random(1)), 240);
			ellipse(x, y, s, s);
		}
	}

	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			stroke(255, random(22)*random(1));
			point(i, j);
		}
	}

	PGraphics cap = createGraphics(width, height);
	cap.beginDraw();
	cap.copy(g, 0, 0, width, height, 0, 0, width, height);
	cap.endDraw();

	float det = random(0.02)*random(1);
	float dd = random(2, random(10, 600));
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			float a = noise(i*det, j*det)*TWO_PI;
			set(i, j, getSmooth(cap, i+cos(a)*dd, j+sin(a)*dd));
		}
	}

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


class Parti{
	float x, y, a, s, v; 
	float pcol;
	float da, dc; 
	Parti(){
		x = width*random(0.1, 0.9);
		y = height*random(0.1, 0.9);
		a = random(TWO_PI);
		v = random(0.2, 1);
		s = random(10, 60);
		da = random(-0.01, 0.01);
		dc = random(-0.004, 0.004);
		pcol = random(1);
	}

	void update(){
		a += da;
		a += random(-0.1, 0.1)*random(1);
		x += cos(a)*v;
		y += sin(a)*v;

		pcol += dc;
		if(pcol < 0) pcol += 1;
		if(pcol > 1) pcol -= 1;
		

		fill(cr.getColor(pcol), 10);
		float n = noise(x*0.005, y*0.005);
		ellipse(x, y, s*n, s*n);
	}
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