int fps = 30;
float seconds = 5;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
  smooth(8);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {
  background(255, 128, 0);
  
  for(int i = 0; i < 100; i++) {
      
  }
}