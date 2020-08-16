import codeanticode.tablet.*;
import manoloide.Input.Input;

boolean play;
boolean loop = true;
color bcolor = color(250);
Input input;
int gw = 500;
int gh = 500;
int framesCant = 5;
int pos = 0;
int vel = 15;
int mx, my, px, py;
PGraphics papelCebolla;
PGraphics frames[];
Tablet tablet;

void setup() {
	size(800, 600);
	input = new Input(this);
	tablet = new Tablet(this); 
	frame.setResizable(true);
	frames = new PGraphics[framesCant];
	for(int i = 0; i < framesCant; i++){
		frames[i] = createGraphics(gw, gh);
		frames[i].beginDraw();
		/*
		frames[i].noStroke();
		frames[i].fill(20);
		frames[i].ellipse(abs(i*1./(framesCant-1)-0.5)*gw/2+gw/2-gw/8, gh/2, 40, 40);
		float ang = (TWO_PI/framesCant)*i+PI/2;
		frames[i].ellipse(gw/2+cos(ang)*120, gh/2+sin(ang)*120, 30, 30);
		*/
		frames[i].endDraw();
	}
	generarPapelCebolla();
}

void draw() {
	if(input.ENTER.click){
		play = !play;
		if(!play)
			generarPapelCebolla();
	}
	px = width/2-gw/2; 
	py = height/2-gh/2;
	if(play){
		reproduccir();
	}else{
		editar();
	}
	dibujar();
	input.update();
	tablet.saveState();
	tablet.getSavedPressure();
}

void keyPressed(){
	input.event(true);
}

void keyReleased(){
	input.event(false);
}
void mousePressed(){
	input.mpress();
}
void mouseReleased(){
	input.mreleased();
}

void reproduccir(){
	frameRate(vel);
	pos++;
	if(pos >= framesCant){
		if(loop) pos%=framesCant;
		else{
			play = false;
			pos = framesCant-1;
		}
	}
}

void editar(){
	frameRate(60);
	if(input.DERECHA.click){
		pos++;
		pos %= framesCant;
		generarPapelCebolla();
	}
	if(input.IZQUIERDA.click){
		pos--;
		if(pos < 0) pos += framesCant;
		generarPapelCebolla();
	};
	mx = mouseX-px;
	my = mouseY-py;
	if(input.press){
		PGraphics p = frames[pos];
		/*
		p.beginDraw();
		float tam = random(20, 80);
		p.noStroke();
		p.fill(random(256), random(256), random(256));
		p.ellipse(mx, my, tam, tam);
		p.endDraw();
		*/
		lineStroke(p, pmouseX-px, pmouseY-py, tablet.getSavedPressure()*12, mouseX-px, mouseY-py, tablet.getPressure()*12);
	}
}

void dibujar(){
	background(200);
	noStroke();
	fill(bcolor);
	rect(px, py, gw, gh);
	if(!play) image(papelCebolla, px, py);
	image(frames[pos], px, py);
}

void generarPapelCebolla(){
	PGraphics aux = createGraphics(gw, gh);
	int cc = 3;
	int ma = 200;
	aux.beginDraw();
	for(int i = cc; i > 0; i--){
		aux.tint(255, ma-ma*(i/(cc+1.)));
		int ap = pos-i;
		if(ap >= 0){
			aux.image(frames[ap], 0, 0);
		}
		ap = pos+i;
		if(ap < framesCant){
			aux.image(frames[ap], 0, 0);
		}
	}
	aux.endDraw();
	papelCebolla = aux;
}

void lineStroke(PGraphics p, float x1, float y1, float p1, float x2, float y2, float p2){
  float ang = atan2(y2-y1,x2-x1);
  float anc = 0.90;
  p.noStroke();
  p.fill(5);
  p.beginDraw();
  p.ellipse(x1, y1, p1*anc, p1*anc);
  p.ellipse(x2, y2, p2*anc, p2*anc);
  anc = 0.5;
  p.beginShape();
  p.vertex(x1+cos(ang-PI/2)*p1*anc,y1+sin(ang-PI/2)*p1*anc);
  p.vertex(x1+cos(ang+PI/2)*p1*anc,y1+sin(ang+PI/2)*p1*anc);
  p.vertex(x2+cos(ang+PI/2)*p2*anc,y2+sin(ang+PI/2)*p2*anc);
  p.vertex(x2+cos(ang-PI/2)*p2*anc,y2+sin(ang-PI/2)*p2*anc);
  p.endShape(CLOSE);
  p.endDraw();
}