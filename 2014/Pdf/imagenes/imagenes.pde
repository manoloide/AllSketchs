import processing.pdf.*;

int w, h;
PImage img, expa;

void setup() {
	img = loadImage("a4.jpg");
	w = img.width;
	h = img.height;
	expa = createImage(w*10, h*10, ARGB);
	expa.loadPixels();
	for(int i = 0; i < img.pixels.length; i++){
		expa.pixels[i] = img.pixels[i];
	}
	expa.updatePixels();
	expa.copy(img, 0, 0, w, h, 0, 0, w*10,h*10);
	size(w, h);

	for (int j = 0; j < 10; j++) {
		for (int i = 0; i < 10; i++) {
			background(0,255,0);
			println(i,j);
			image(expa, -i*w, -j*h);
			saveFrame(j+"_"+i+".jpg");
		}
	}
	image(expa, 0, 0);
	exit();
}

void draw() {
	
}