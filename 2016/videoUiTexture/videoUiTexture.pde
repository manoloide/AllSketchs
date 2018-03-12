import processing.video.*;
Movie mov;

int colors[] = {#1E2E5D, #EDB629, #FFE51A, #FAFAFA};
PImage img;

void setup() {
  size(900, 720);
  background(0);
  mov = new Movie(this, "video.mov");  
  mov.play();
  mov.volume(0);
  generate();
  rectMode(CENTER);
}

void draw() {
  background(0);
  if (mov.available() == true) {
    mov.read();
  }

  int ss = 10;
  for (int j = ss/2; j < width; j+= ss) {
    for (int i = ss/2; i < width; i+= ss) {
      float v = brightness(mov.get(i/2, j/2))/255.;
      form(i, j, ss, v);
    }
  }
}

void keyPressed() {
  generate();
}

void generate() {
}

void form(float x, float y, float s, float v) {
  stroke(255);
  noFill();
  float m1 = s*0.4*min(0.5, v);
  float m2 = s*0.4*map(v, 0.4, 0.8, 0, 1);
  line(x-m1, y-m1, x+m1, y+m1); 
  if (v > 0.4) line(x-m2, y+m2, x+m2, y-m2);
  if (v > 0.8) rect(x, y, s, s);
}