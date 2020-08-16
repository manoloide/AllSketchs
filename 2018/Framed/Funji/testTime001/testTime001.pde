float SCALE = 0.25;
int swidth = 1920;
int sheight = 1080;

int totalSeconds = 180;//60*60*24;

float time;
PGraphics render;

void settings() {
  size(int(swidth*SCALE), int(sheight*SCALE), P2D);
  println(totalSeconds);
}

void setup() {
  render = createGraphics(width, height, P2D);
}

void draw() {
  
  time = millis()*0.001;
  
  render(time);
  
}

void render(float time) {

  float tt = map(time%totalSeconds, 0, totalSeconds, 0, 1);

  render.beginDraw();
  render.background(tt*255);
  render.endDraw();

  image(render, 0, 0);
}
