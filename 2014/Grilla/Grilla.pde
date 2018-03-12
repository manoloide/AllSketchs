ArrayList<Box> boxes;
boolean viewGrill;

int cant = 8;
int pw = 2;
int bw = 1;
int bh = 20;
float xx = 0;
float yy = 0;
float mx, my;
PGraphics canvas;

void setup() {
	size(800, 600);
	frame.setResizable(true);
	boxes = new ArrayList<Box>();
	viewGrill = true;
	canvas = createGraphics(600, 400);
	canvas.beginDraw();
	canvas.background(250);
	canvas.endDraw();
}

void draw() {
	background(200);
	float dsw = (width-canvas.width)/2;
	float dsh = (height-canvas.height)/2;
	mx = mouseX-dsw;
	my = mouseY-dsh;
	translate(dsw,dsh);
	lineUpdate();	
	yy = my - (my%bh); 
	image(canvas, 0, 0);
	if(viewGrill) drawGrill();
	for(int i = 0; i < boxes.size(); i++){
		Box b = boxes.get(i);
		b.update();
	}
	line(xx, 0, xx, canvas.height);
	if(mousePressed){
		Box b = boxes.get(boxes.size()-1);
		b.x2 = xx;
		b.y2 = yy;
	}
}

void mousePressed(){
	boxes.add(new Box(xx, yy, xx, yy));
}

void drawGrill(){
	bw = (canvas.width/100)*pw;
	float w = (canvas.width-bw*(cant+1.))/cant;
	float dw = w+bw;
	fill(60, 100);
	noStroke();
	for(int i = 0; i < cant; i++){
		rect(bw+dw*i, 0, w, canvas.height);
	}
}

void lineUpdate(){
	stroke(0, 128);
	float w = (canvas.width-bw*(cant+1.))/cant;
	float dw = w+bw;
	float md = mx;
	for(int i = 0; i < cant; i++){
		float dis = abs(bw+dw*i-mx);
		if(dis < md){
			xx = bw+dw*i;
			md = dis;
		}
		dis = abs(bw+dw*i+w-mx);
		if(dis < md){
			xx = bw+dw*i+w;
			md = dis;
		};
	}
}