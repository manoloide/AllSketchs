import manoloide.Gui.*;

Gui gui;
Nave nave;
Window window;

void setup() {
	size(800, 600, P3D);
	smooth(8);
	gui = new Gui(this);
	frame.setResizable(true);
	window = new Window("Editor", 10, 10, 200, 400);
	gui.add(window);
	window.add(new Slider("width", 10, 10, 180, 10, 10, 500, 200));
	window.add(new Slider("height", 10, 40, 180, 10, 10, 500, 200));
	window.add(new Slider("cant w", 10, 70, 180, 10, 2, 36, 16));
	window.add(new Slider("cant h", 10, 100, 180, 10, 3, 36, 10));
	window.add(new Slider("amp1", 10, 130, 180, 10, 0, TWO_PI, 0));
	window.add(new Slider("amp2", 10, 160, 180, 10, 0, TWO_PI*2, PI/2));
	nave = new Nave();
}

void draw() {
	hint(ENABLE_DEPTH_TEST);
		lights();
	pushMatrix();
	translate(width/2, height/2, 100);
	background(200);
	nave.update();
	popMatrix();
	hint(DISABLE_DEPTH_TEST);
	gui.update();
	gui.draw();
}

