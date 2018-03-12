int pixelSize = 2;

PGraphics master;

void setup() {
  size(720, 480); 
  noSmooth();
  frameRate(5);
  master = createGraphics(width/pixelSize, height/pixelSize);
}

void draw() {
  drawMap();
  image(master, 0, 0, width, height);
}

void drawMap() {
  master.beginDraw();
  master.noSmooth();
  master.clear(); 
  int tt = 64;
  master.noStroke();
  // master.fill(240, 40);
  for (int j = 0; j < 10; j++) {
    for (int i = 0; i < 10; i++) {
      int c = (int) random(256);
      master.fill(c);
      master.noStroke();
      int x = i*tt+(j%2)*tt/2;
      int y = j*tt/4;
      tileDraw(x, y, tt);   
    }
  }
  master.endDraw();
}

void tileDraw(int x, int y, int t) {
  t/=2;
  master.beginShape();
  master.vertex(x-t, y);
  master.vertex(x, y-t/2);
  master.vertex(x+t, y);
  master.vertex(x, y+t/2);
  master.endShape(CLOSE);
}
