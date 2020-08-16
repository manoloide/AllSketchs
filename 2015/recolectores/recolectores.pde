ArrayList<Recolector> recolectores;
boolean viewGrill = true;
boolean viewNoise = true;
color colors[];
float noiseValues[][];
int seed;
PGraphics render;
PImage inoise;
PShader blur; 

void setup() {
	size(800, 600, P2D);
	blur = loadShader("blur.glsl"); 
	generate();
}

void draw() {
	frame.setTitle("FPS: "+frameRate);
	background(0);
	if(viewNoise){
		drawNoise();
	}
	if(viewGrill){
		drawGrill();
	}

	render.beginDraw();
	for(int i = 0; i < recolectores.size(); i++){
		Recolector r = recolectores.get(i);
		r.update();
		if(r.remove) recolectores.remove(i--);
	}
	render.endDraw();
	render.filter(blur);
	image(render, 0, 0);
}

void keyPressed(){
	if(key == 'g'){
		viewGrill = !viewGrill;
	}
	else if(key == 'n'){
		viewNoise = !viewNoise;
	}
	else if(key == 's'){
		saveImage();
	}
	else{
		generate();
	}
}

void generate(){
	int seed = int(random(9999999));
	recolectores = new ArrayList<Recolector>();
	for(int i = 0; i < 10000; i++){
		recolectores.add(new Recolector(random(width), random(height)));
	}
	generateNoise();
	drawNoise();

	render = createGraphics(width, height, P2D);
}
void generateNoise(){
	noiseSeed(seed);
	float dx = random(width);
	float dy = random(height);
	noiseValues = new float[width][height];
	float det = 0.005;
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			noiseValues[i][j] = noise(i*det+dx, j*det+dy);
		}
	}
	colors = new color[256];
	for(int i = 0; i < 256; i++){
		colors[i] = lerpColor(color(0, 0, 255), color(255, 0, 0), i*1./256);
	}
	inoise = createImage(width, height, RGB);
	inoise.loadPixels();
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			drawNoisePixel(i, j);
		}
	}
	inoise.updatePixels();
}
void drawNoisePixel(int x, int y){
	if(x < 0 || x >= inoise.width || y < 0 || y >= inoise.height) return;
	inoise.loadPixels();
	int ind = int(noiseValues[x][y]*256);
	ind = constrain(ind, 0, 255);
	color col = colors[ind];
	inoise.set(x, y, col);
	inoise.updatePixels();
}
void drawNoise(){
	image(inoise, 0, 0);
}
void drawGrill(){
	int x = 0; 
	int y = 0; 
	int sx = 20; 
	int sy = 20; 

	int w = width;
	int h = height;

	PGraphics gra = createGraphics(w, h);
	gra.beginDraw();
	gra.stroke(255);
	for(int i = x%sx; i < w; i+=sx){
		gra.line(i, 0, i, h);
	}


	for(int i = y%sy; i < h; i+=sy){
		gra.line(0, i, w, i);
	}
	gra.endDraw();
	tint(255, 40);
	image(gra, 0, 0);
	noTint();
}

class Recolector{
	boolean remove;
	float v;
	int x, y;
	int time;
	Recolector(float x, float y){
		this.x = int(x); 
		this.y = int(y);
		v = 1;
		time = 0;
	}
	void update(){
		noiseValues[x][y] -= 0.05;
		drawNoisePixel(x, y);
		if(noiseValues[x][y] > 0.4){
			v += 0.1;
		}else{
			v -= 0.05;
		}
		int r = int(random(10));
		switch (r) {
			case 0:
			x++;
			break;
			case 1:
			x--;
			break;
			case 2:
			y++;
			break;
			case 3:
			y--;
			break;
			
		}
		if(x < 0 || x >= width || y < 0 || y >= height){
			remove = true;
		}
		if(v < 0) remove = true;
		show();
	}
	void show(){
		render.noStroke();
		render.fill(255, 255, 100);
		float t = 5 * v;
		render.ellipse(x, y, t, t);
	}
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-2;
	saveFrame(nf(n, 3)+".png");
}