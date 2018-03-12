String txt[];

void setup() {
	size(800,800);
	background(120);
	generar();
	/*
	txt = loadStrings("prueba.pde");
	textFont(createFont("FreeMono", 22, true));
	for(int j = 0; j < 1; j++){
		for(int i = 0; i < txt.length; i++){
			txt[i] = txt[i].replace("	", "  ");
			color gri = color(140+j*8);
			fill(lerpColor(gri, color(240, 120, 0), i*1./txt.length));
			text(txt[i], 20+j, 20+i*22+j);
		}
	}
	*/
}

void draw() {}

void keyPressed(){
	if(key == 's') saveFrame("######.png");
	else generar();
}

void generar(){
	background(80);
	int espa = int(random(2, 9));
	stroke(75);
	strokeCap(SQUARE);
	strokeWeight(1);
	for(int i = -3; i < width+height; i+=espa){
		line(-2,i,i,-2);
	}
	float tam = random(8, 400); //40;
	noFill();
	int w = int(width/tam)-1;
	float dw = (width-w*tam)/2;
	int h = int(height/tam)-1;
	float dh = (height-h*tam)/2;
	for(int j = 0; j < h; j++){
		for(int i = 0; i < w; i++){
			float x = dw+i*tam;
			float y = dh+j*tam;
			stroke(0, 8);
			strokeWeight(1);
			rect(x, y, tam, tam);
			if(i > 0 && j > 0){
				float da = TWO_PI/16;
				for(int k = 0; k < 16; k++){
					line(x,y,x+cos(da*k)*tam/2,y+sin(da*k)*tam/2);
				}
				for(int k = 0; k <4; k++){
					int alp = 255;
					if(random(4)<2){
						alp = 20;
					}
					stroke(70, alp);
					strokeWeight(2);
					arc(x, y, tam, tam, PI/2*k, PI/2*(k+1));
					stroke(110, alp);	
					arc(x, y, tam/4*3, tam/4*3, PI/2*k, PI/2*(k+1));
					stroke(90, alp);
					arc(x, y, tam/2, tam/2, PI/2*k, PI/2*(k+1));
					stroke(#FFA323, alp);
					arc(x, y, tam/4, tam/4, PI/2*k, PI/2*(k+1));
					//else{
					// 	stroke(70);
					// 	strokeWeight(2);
					// 	arc(x+tam/2, y+tam/2, tam, tam, PI/2*k, PI/2*(k+1));
					// }
				}
			}
		}
	}
}