void setup() {
  size(960, 960);
  smooth(8);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(5);
  blendMode(ADD);
  int subw = int(random(2, 7));
  int subh = int(random(1, 3));
  float sw = width*1./subw;
  float sh = height*1./subh;
  noStroke();
  for (int j = 0; j < subh; j++) {
    for (int i = 0; i < subw; i++) {
      hud(sw*i, sh*j, sw, sh, 2, int(random(1, 8)), int(random(1, 80)));
    }
  }
}

void hud(float x, float y, float w, float h, float b, int sw, int sh) {
  float dw = (w-b*2)*1./sw;
  float dh = (h-b*2)*1./sh;
  for (int j = 0; j < sh; j++) {
    for (int i = 0; i < sw; i++) {
      fill(rcol(), random(150));
      rect(x+b+i*dw+1, y+b+j*dh+1, dw-2, dh-2);
      rect(x+b+i*dw+1, y+b+j*dh+1, dw-2, dh-2);
    }
  }
}

int colors[] = {#FA425A, #42A8FA, #FFFFFC};
int rcol() {
  return colors[int(random(colors.length))];
}