ArrayList<PVector> points;
int scale = 4;
PGraphics gra;

void setup() {
  size(600, 600);
  points = new ArrayList<PVector>();
  gra = createGraphics(width/scale, height/scale);
}

void draw() {
  gra.beginDraw();
  gra.background(#2D2E3B);
  if (pmouseX != mouseX || pmouseY != mouseY) {
    //points.add(new PVector((mouseX+pmouseX)/2, (mouseY+pmouseY)/2, random(30, 60)));
  }
  points.add(new PVector(mouseX, mouseY, random(30, 60)));
  for (int k = 0; k < points.size (); k++) {
    PVector p = points.get(k);
    p.y += 2;
    p.z *= random(0.6, 0.9);
    if (p.z < 1) points.remove(k--);
  }
  for (int j = 0; j < gra.height; j++) {
    for (int i = 0; i < gra.width; i++) {
      float val = 0;
      for (int k = 0; k < points.size (); k++) {
        PVector p = points.get(k);
        val += 255/(pow(i-p.x/scale, 2)+pow(j-p.y/scale, 2))*p.z;
      }
      if (val > 100) {
        if (val > 250) val = 250;
        else if (val > 140) val = 220;
        else val = 200;
        gra.set(i, j, color(val));
      }
    }
  }
  gra.endDraw();
  noSmooth();
  image(gra, 0, 0, width, height);
}

