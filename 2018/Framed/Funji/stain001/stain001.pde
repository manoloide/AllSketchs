float SCALE = 0.25;
int swidth = 1920;
int sheight = 1080;

int totalSeconds = 180;//60*60*24;
float time;
PGraphics render;
PShader clouds;

void settings() {
  size(int(swidth*SCALE), int(sheight*SCALE), P2D);
}

void setup() {
  clouds = loadShader("clouds.glsl");
  render = createGraphics(width, height, P2D);
  render(0);
}

void draw() {
  
  time = millis()*0.001;
  
  render(time);
  
}

void render(float time) {

  float tt = map(time%totalSeconds, 0, totalSeconds, 0, 1);

  render.beginDraw();
  render.background(tt*255);
  clouds = loadShader("clouds.glsl");
  clouds.set("resolution", float(width), float(height));
  render.filter(clouds);
  render.rect(0, 0, render.width, render.height);
  render.endDraw();

  image(render, 0, 0);
}
