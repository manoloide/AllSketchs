boolean load;
Camera camera;
color colorSel;
Gui gui;
Input input;
int pallete[];
String path;
PGraphics gra;

void setup() {
	size(800, 480);
	camera = new Camera();
	gui = new Gui(width-180, 0, 180, height);
	input = new Input();
	path = "";
	int cant = int(random(8, 20));
	pallete = new int[cant];
	for(int i = 0; i < cant; i++){
		pallete[i] = color(random(256), random(256));
	}
	colorSel = pallete[0];
	newImage();
}

void draw() {
	if(frameCount%20 == 0) frame.setTitle("MiniPixelin  --  FPS:"+frameRate);
	if(load) {
		background(240, 0, 0);
		return;
	}
	background(120);
	pushMatrix();
	camera.update();
	if(mouseButton != CENTER && input.amouseX < gui.x){
		int ax = int((pmouseX-camera.x)/camera.scale);
			int ay = int((pmouseY-camera.y)/camera.scale);
			int px = int((mouseX-camera.x)/camera.scale);
			int py = int((mouseY-camera.y)/camera.scale);
		if(input.click){
			gra.beginDraw();
			gra.noSmooth();
			gra.noStroke();
			gra.fill(colorSel);
			gra.ellipse(px, py,gui.gros.val,gui.gros.val);
			gra.endDraw();
		}
		else if(input.press){
			gra.beginDraw();
			gra.noSmooth();
			gra.strokeWeight(gui.gros.val);
			gra.stroke(colorSel);
			gra.line(ax, ay, px, py);
			gra.endDraw();
		}
	}
	
	noStroke();
	for(int j = 0; j < gra.height; j+=8){
		for(int i = 0; i < gra.width; i+=8){
			if((i+j)%16 == 0) fill(250);
			else fill(200);
			rect(i,j,8,8);
		}
	}
	noSmooth();
	image(gra, 0, 0);
	smooth();
	popMatrix();
	gui.update();
	input.act();
}

void keyPressed() {
	input.event(true);
	palleteImage();
}
void keyReleased() {
	input.event(false);
}

void mousePressed() {
	input.mpress();
}
void mouseReleased() {
	input.mreleased();
}

void mouseDragged(){
	if(mouseButton == CENTER){
		camera.move(mouseX-pmouseX,mouseY-pmouseY);
	}
}

void mouseWheel(MouseEvent event) {
	float e = event.getCount();
	if(e > 0) e = 0.75;
	else e = 1.5;
	float azoom = camera.scale;
	float zoom = camera.scale*e;
	float dx = -(((mouseX-camera.x)/(width*azoom))*(width*zoom - width*azoom));
	float dy = -(((mouseY-camera.y)/(height*azoom))*(height*zoom - height*azoom));
	camera.move(dx, dy);
	camera.scale = zoom;
}

void newImage(){
	path = "";
	gra = createGraphics(480, 360);
	gra.beginDraw();
	gra.endDraw();
}

void saveImage(){
	if(path == "") selectOutput("Save As:", "saveSelection");
	else gra.save(path);
}

void openImage(File f) {
	if (f != null) {
		load = true;
		String path = f.toString();
		String ext = path.substring(path.lastIndexOf(".") + 1, path.length());
		if (ext.equals("png") || ext.equals("jpg")) {
			PImage aux = loadImage(path);
			gra = createGraphics(aux.width, aux.height);
			gra.beginDraw();
			gra.image(aux,0,0);
			gra.endDraw();
			println("Cargo la imagen");
			palleteImage();
		}
		load = false;
	}
}

void saveSelection(File sel) {
	if (sel != null) {
		path = sel.toString();
		saveImage();
	}
}

class Gui{
	int x, y, w, h, scol;
	int dpy;
	Slider r, g, b, a, gros;
	String options[];
	Gui(int x, int y, int w, int h){
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;

		String aux[] = {"New", "Open", "Save"};
		options = aux;

		dpy = 56;
		r = new Slider(x+4, y+dpy+210, w-8, 20, 0, 0, 255);
		g = new Slider(x+4, y+dpy+240, w-8, 20, 0, 0, 255);
		b = new Slider(x+4, y+dpy+270, w-8, 20, 0, 0, 255);
		a = new Slider(x+4, y+dpy+300, w-8, 20, 255, 0, 255);
		gros = new Slider(x+4, y+dpy+330, w-8, 20, 1, 1, 100);
	}
	void update(){
		draw();
	}
	void draw(){
		pushStyle();
		strokeCap(SQUARE);
		stroke(0, 12);
		for(int i = 6; i >= 1; i--){
			strokeWeight(i);
			line(x, 0, x, height);
		}

		//topmenu
		noStroke();
		fill(40);
		rect(x, y, w, h);
		int cant = options.length;
		float aw = w*1./cant;
		textAlign(CENTER, TOP);
		for(int i = 0; i < cant; i++){
			boolean on = false;
			if(mouseX >= x+aw*i && mouseX < x+aw*(i+1) && mouseY >= y && mouseY < y+20){
				on = true;
				if(input.click){
					if(options[i].equals("New")){
						newImage();
					}else if(options[i].equals("Open")){
						selectInput("Open imagen", "openImage");
					}else if(options[i].equals("Save")){
						saveImage();
					}
				}
			}
			fill(60);
			if(on) fill(70);
			rect(x+aw*i, y, aw, 20);
			fill(230);
			text(options[i], x+aw*(i+0.5), y+2);
		}
		stroke(0, 8);
		for(int i = 6; i >= 1; i--){
			strokeWeight(i);
			line(x, y+20, x+w, y+20);
		}


		//pallete
		stroke(36);
		fill(20);
		rect(x+4, y+dpy, w-8, 200, 4);
		cant = pallete.length;
		boolean neww = true;
		for(int i = 0; i < pallete.length; i++){
			int ww = 20;
			int www = (ww+4);
			int xx = (www*i)%(w-12);
			int yy = ((www*i)/(w-12))*www;

			boolean on = false;
			if(mouseX >= x+8+xx && mouseX < x+8+xx+ww && mouseY >= y+dpy+yy && mouseY < y+dpy+yy+ww){
				on = true;
				neww = false;
			}
			if(on && input.click){
				colorSel = pallete[i];
				scol = i;
			}
			strokeWeight(1.5);
			stroke(160);
			if(on)stroke(180);
			if(i == scol) stroke(220);
			fill(pallete[i]);
			rect(x+8+xx, y+dpy+yy+4, ww, ww, 4);
		}
		if(input.dclick && neww && mouseX >= x+4 && mouseX < x+w-4 && mouseY >= y+dpy && mouseY < y+dpy+200){
			addColorPallete(color(random(256), random(256), random(256)));
		}
		r.val = red(pallete[scol]);
		g.val = green(pallete[scol]);
		b.val = blue(pallete[scol]);

		r.update();
		g.update();
		b.update();
		a.update();
		pallete[scol] = color(r.val, g.val, b.val);
		colorSel = color(r.val, g.val, b.val, a.val);
		gros.update();
		popStyle();
	}
};
void addColorPallete(color nc){
	int apallete[] = new int[pallete.length+1];
	for(int i = 0; i < pallete.length; i++){
		apallete[i] = pallete[i];
	}
	apallete[pallete.length] = nc;
	pallete = apallete;
}
void palleteImage(){
	IntList colores = new IntList();
	println(gra.width, gra.height);
	for(int j = 0; j < gra.height; j++){
		for(int i = 0; i < gra.width; i++){
			color ca = gra.get(i,j);
			boolean add = true;
			for(int k = 0; k < colores.size(); k++){
				color cc = colores.get(k);
				if(cc == ca){
					add = false;
					continue;
				}
			}
			if(add) colores.append(ca);
		}
	}
	int cant = colores.size();
	println(cant);
	pallete = new color[cant];
	for(int i = 0; i < cant; i++){
		pallete[i] = colores.get(i);
	}
	gui.scol = 0;
}

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
		if(on && input.click){
			move = true;
		}
		if(move){
			if(!input.press) move = false;
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

class Camera{
	float x, y;
	float scale;
	Camera(){
		scale = 1;
	}
	Camera(float x, float y){
		this.x = x;
		this.y = y;
		scale = 1;
	}
	void update(){
		translate(x, y);
		scale(scale);
	}
	void move(float mx, float my){
		x += mx;
		y += my;
	}
};
