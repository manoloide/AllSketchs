/*
  ANIMATOR
 
 */
import manoloide.Input.Input; 

Input input;

Canvas canvas;
Layers layers;

void setup() {
  size(800, 600);
  frame.setResizable(true);

  input = new Input(this);

  canvas = new Canvas();
  layers = new Layers();
}

void draw() {
  background(200);  
  canvas.update();
  layers.update();
  if (input.click) {
    background(random(256));
  }
}

