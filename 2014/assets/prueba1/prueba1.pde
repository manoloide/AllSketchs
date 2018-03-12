PShape[] formitas, puntitos;

void setup(){
	size(600, 800);
	formitas = cargarFormas("../formitas1.svg");
	puntitos = cargarFormas("../puntitos.svg");
	for (PShape p : puntitos){
		p.disableStyle();
	}
}

void draw(){
}
void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}
void generar(){
	background(#93CAC9);
	puntitos();
	for(int i = 0; i < 80; i++){
		pushMatrix();
		translate(random(width), random(height));
		rotate(random(TWO_PI));
		scale(random(0.5,2));
		int cant = 1;//int(random(1, 60));
		float ang = random(0.01);
		float vel = random(1, 6);
		PShape aux =  formitas[int(random(formitas.length))];
		for(int j = 0; j < cant; j++){
			shape(aux, 0, 0);
			translate(cos(ang)*vel, sin(ang)*vel);
			ang += random(-0.04, 0.04);
			rotate(ang);
		}
		popMatrix();
	}
}

void puntitos(){
	int des = 10;
	stroke(250, 30);
	fill(250, 25);
	for(int j = -int(random(des)); j < height+des; j+=des){
		for(int i = -int(random(des)); i < width+des; i+=des){
			shape(puntitos[int(random(puntitos.length))], i, j);
		}
	}
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
