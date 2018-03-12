int WIDTH = 360;
int HEIGHT = 180;
int scale = 4;
PGraphics render;

PGraphics state;

void settings() {
  size(WIDTH*scale, HEIGHT*scale); 
  noSmooth();
}


void setup() {
  render = createGraphics(WIDTH, HEIGHT);

  createState();
}


void draw() {
  render.beginDraw();
  render.background(90, 140, 250);
  state.beginDraw();
  for (int i = 0; i < 1000; i++) {
    int x = int(random(1, state.width));
    int y = int(random(1, state.width));
    if (alpha(state.get(x, y)) > 10) {
      if (alpha(state.get(x, y-1)) < 10) {
        state.set(x, y, color(40, 200, 5));
      }
    }
  }
  state.endDraw();
  render.image(state, 0, 0);
  render.ellipse(mouseX/scale, mouseY/scale, 16, 16);
  render.endDraw();

  image(render, 0, 0, width, height);
}

void mousePressed() {
  hole(state, mouseX/scale, mouseY/scale, random(60));
}

void createState() {
  state = createGraphics(WIDTH, HEIGHT);
  state.beginDraw();
  float det = 0.03;
  for (int j = 0; j < state.height; j++) {
    for (int i = 0; i < state.width; i++) {
      if (j > 32) {
        color col = lerpColor(color(#834E22), color(#462E1A), map(j+cos(i*0.1)*4, 0, state.height, 0, 1));
        col = lerpColor(col, color(#B98254), random(random(0.1)));
        col = lerpColor(col, color(0), noise(i*det, j*det)*0.2);
        state.set(i, j, col);
      } else {
        state.set(i, j, color(0, 0));
      }
    }
  }
  state.endDraw();
}

void hole(PGraphics render, float x, float y, float s) {
  int ms = int(s*0.5);
  int x1 = constrain(int(x-ms), 0, render.width);
  int y1 = constrain(int(y-ms), 0, render.height);
  int x2 = constrain(int(x+ms), 0, render.width);
  int y2 = constrain(int(y+ms), 0, render.height);

  render.beginDraw();
  for (int j = y1; j <= y2; j++) {
    for (int i = x1; i <= x2; i++) {
      if (dist(x, y, i, j) < ms)
        render.set(i, j, color(0, 0));
    }
  }
  render.endDraw();
}