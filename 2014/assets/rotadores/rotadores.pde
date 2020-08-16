int paleta[];
PShape[] rotadores;

void setup(){
	size(600, 800);
	rotadores = cargarFormas("assets.svg");
	for (PShape r : rotadores){
		r.disableStyle();
	}
	paleta = new int[3];
	paleta[0] = #F7084D;
	paleta[1] = #0C8BF2;
	paleta[2] = #0BF4A6;
}

void draw(){
}
void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}
void generar(){
	background(#93CAC9);
	for(int i = 0; i < 180; i++){
		pushMatrix();
		translate(random(width), random(height));
		rotate(random(TWO_PI));
		scale(random(0.2,2));
		int cant = int(random(60, 160));
		float ang = random(0.01);
		float vel = random(1, 6);
		int icol = rcol();
		int fcol = rcol();
		stroke(icol);
		PShape aux =  rotadores[int(random(rotadores.length))];
		for(int j = 0; j < cant; j++){
			fill(bri(lerpColor(icol, fcol, j*1./cant),random(20)), random(40));
			shape(aux, 0, 0);
			translate(cos(ang)*vel, sin(ang)*vel);
			ang += random(-0.04, 0.04);
			rotate(ang);
		}
		popMatrix();
	}
}

int rcol(){
	return paleta[int(random(paleta.length))];
}
int bri(color col, float bri){
	return color(red(col)+bri, green(col)+bri, blue(col)+bri);
}

void saveImage(){
	File f = new File(sketchPath);
	int cant = f.listFiles().length-1;
	saveFrame(cant+".png");
}


PShape[] cargarFormas(String src){
	PShape original = loadShape(src);;
	PShape formas[];
	int cant = original.getChildCount();
	formas = new PShape[cant];
	for (int i = 0; i<cant; i++){
		PShape form = original.getChild(i);
		boolean llenar = true;
		float xmin, ymin, xmax, ymax;
		xmin = ymin = xmax = ymax = 0;
		for(int k = 0; k < form.getChildCount(); k++){
			PShape aux = form.getChild(k);
			for (int j = 0; j < aux.getVertexCount(); j++) {
				PVector v = aux.getVertex(j);
				if(llenar){
					xmin = xmax = v.x;
					ymin = ymax = v.y;
					llenar = false;
				}
				xmin = min(v.x, xmin);
				ymin = min(v.y, ymin);
				xmax = max(v.x, xmax);
				ymax = max(v.y, ymax);
			}
		}
		form.translate(-xmin-(xmax-xmin)/2,-ymin-(ymax-ymin)/2);
		formas[i] = form;
	}
	return formas;
}
