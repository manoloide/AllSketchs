int paleta[] = {
  #FF9900, 
  #424242, 
  #E9E9E9, 
  #BCBCBC, 
  #3299BB
};

PGraphics mask;

void setup() {
  size(800, 800);
  generar();
  image(mask, 0, 0);
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {

  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  for (int i = 0; i < 5; i++) {
    float x = width*random(0.2, 0.8);
    float y = height* random(0.2, 0.8);
    x += (width/2-x)*0.5;
    y += (height/2-x)*0.5;
    float s = pow(2, random(2, 8));
    mask.ellipse(x, y, s, s);
  }
  mask.endDraw();

  background(240);
  noStroke();
  int c = 400;
  for (int i = 0; i < c; i++) {
    color col = color(rcol());
    float x = random(width);
    float y = random(height);
    if (brightness(mask.get(int(x), int(y))) < 200) continue;
    float t = pow(2, int(map(i, 0, c, 9, 2)+random(1)));
    float s = t*0.04;
    strokeCap(SQUARE);
    strokeWeight(1);
    stroke(lerpColor(col, color(0), 0.05));
    fill(lerpColor(col, color(0), 0.05));
    ellipse(x-s, y-s, t, t);
    fill(col);
    ellipse(x, y, t, t);
    strokeWeight(s);
    s *= 2;
    line(x-s, y-s, x+s, y+s);
    line(x+s, y-s, x-s, y+s);
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

