int sca = 2;
PGraphics img;

void setup() {
  size(640, 480);
  img = createGraphics(width/sca, height/sca);
}

void draw() {
	println(frameRate);
	img.beginDraw();
	img.ellipse(mouseX/sca,mouseY/sca,30,30);
	img.endDraw();
	image(expandir(img,sca),0,0);
}

PGraphics expandir(PGraphics ori, int sca){
	PGraphics aux = createGraphics(ori.width*sca, ori.height*sca);
	aux.beginDraw();
	for (int j = 0; j<ori.height; j++){
		for (int i = 0; i<ori.width; i++){
			for(int l = 0; l<sca; l++){
				for (int k = 0; k<sca; k++){
					aux.set(i*sca+k, j*sca+l, ori.get(i, j));	
				}
			}
		}
	}
	aux.endDraw();
	return aux;
}

