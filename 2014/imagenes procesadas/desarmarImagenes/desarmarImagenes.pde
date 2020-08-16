String src = "https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xap1/v/t1.0-9/10659232_837624916247891_7414287472711010934_n.jpg?oh=b5806ee5ff23ce2315b037c017ff84db&oe=54CF1CDB&__gda__=1422633991_50d3863514cbf264d2a702a6d919f666";
PImage img;


void setup() {
	img = loadImage(src);
	size(img.width, img.height);
	for(int i = 0; i < 30; i++){
		img = desordenar(img, int(random(-20, 20)), int(random(-20, 20)));
	}
	image(img, 0, 0);
}								

void draw() {}


PImage desordenar(PImage img, int cw, int ch){
	int w = img.width;
	int h = img.height;
	PImage aux = createImage(w, h, RGB);
	float det = 0.05;
	aux.loadPixels();
	for (int i = 0; i < w; i++) {
		for (int j = 0; j < h; j++) {
			int xx = int(i+cw*noise(i*det+500)+w)%w;
			int yy = int(j+ch*noise(j*det+200)+h)%h;
			color col = img.get(xx, yy);
			aux.set(i,j,col); 
		}
	}
	aux.updatePixels();
	return aux;
}
