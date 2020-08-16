import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  (960/2);
float nheight = (1280/2);
float swidth = 960; 
float sheight = 1280;
float scale  = 1;

boolean export = false;
boolean debugTextures = true;
boolean generated = true;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  //pixelDensity(2);
}

void setup() {
  generate();

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
}

void draw() {
  if (generated) {
    generate();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == '1') {
    view = 1;
    generated = true;
  } else if (key == '2') {
    view = 2;
    generated = true;
  } else if (key == '3') {
    view = 3;
    generated = true;
  } else if (key == '4') {
    view = 4;
    generated = true;
  } else if (key == 'd') {
    debugTextures = !debugTextures;
    generated = true;
  } else {
    seed = int(random(999999));
    generated = true;
  }
}
PGraphics renderCol, renderSize;
int view = 1;
void generate() {

  generated = false;

  randomSeed(seed);
  noiseSeed(seed);

  createPoints();
  gradColor();
  gradSize();

  background(0);
  blendMode(ADD);
  scale(scale);

  if (view == 1) {
    grid();
  }
  blendMode(NORMAL);

  if (view == 2) {
    image(renderCol, 0, 0, swidth, sheight);
  }

  if (view == 3) {
    image(renderSize, 0, 0, swidth, sheight);
  }
  if (view == 4) {
    render();
  }

  if (debugTextures) {
    blendMode(NORMAL);
    float bb = 5;
    image(renderCol, bb, bb, width*0.2, height*0.2);
    image(renderSize, bb, bb*2+height*0.2, width*0.2, height*0.2);
  }
}

void gradColor() {

  renderCol = createGraphics(width, height, P2D);
  renderCol.beginDraw();
  renderCol.noStroke();
  renderCol.background(0);
  for (int i = 0; i < 50; i++) {
    Point p1 = points.get(int(random(points.size()*random(1))));
    Point p2 = points.get(int(random(points.size()*random(1))));
    Point p3 = points.get(int(random(points.size()*random(1))));
    int c1 = getColor();
    int c2 = getColor();
    float alp1 = random(255)*random(random(1), 1);
    float alp2 = random(255)*random(random(1), 1);

    if (random(1) < 0.2) blendMode(ADD);
    renderCol.beginShape(TRIANGLE);
    renderCol.fill(c1, alp1);
    renderCol.vertex(p1.x, p1.y);
    renderCol.fill(c2, alp2);
    renderCol.vertex(p2.x, p2.y);
    renderCol.vertex(p3.x, p3.y);
    renderCol.endShape();
    renderCol.blendMode(NORMAL);
  }
  renderCol.endDraw();
}

void gradSize() {

  renderSize = createGraphics(width, height, P2D);
  renderSize.beginDraw();
  renderSize.noStroke();
  renderSize.background(0);
  for (int i = 0; i < 20; i++) {
    Point p1 = points.get(int(random(points.size()*random(1))));
    Point p2 = points.get(int(random(points.size()*random(1))));
    Point p3 = points.get(int(random(points.size()*random(1))));
    int c1 = color(255*int(random(2)));
    int c2 = color(255*int(random(2)));
    float alp1 = random(255)*random(1);
    float alp2 = random(255)*random(1);
    if (random(1) < 0.1) blendMode(ADD);
    renderSize.beginShape(TRIANGLE);
    renderSize.fill(c1, alp1);
    renderSize.vertex(p1.x, p1.y);
    renderSize.fill(c2, alp2);
    renderSize.vertex(p2.x, p2.y);
    renderSize.vertex(p3.x, p3.y);
    renderSize.endShape();
    renderSize.blendMode(NORMAL);
  }
  renderSize.endDraw();
}

void render() {

  blendMode(NORMAL);

  //println(renderCol.pixels.length);
  /*
  PImage maskCol = createImage(renderCol.width, renderCol.height, ARGB);
  arrayCopy(renderCol.pixels, maskCol.pixels);
  maskCol.updatePixels();
  */

  noStroke();
  for (int i = 0; i < 8000; i++) {
    float xx = random(width);
    float yy = random(height);
    int ix = int(xx);
    int iy = int(yy);
    int col = maskCol.get(ix, iy);
    float ss = random(20);//brightness(renderSize.get(ix, iy))*0.2;
    fill(col);
    ellipse(xx, yy, ss, ss);
  }

  //pointsss();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#251B19, #7F2A17, #995D38, #FFD192, #533632, #2A201E};
int rcol() {
  return colors[int(random(colors.length))];
}

int getColor() {
  return getColor(random(colors.length));
}

int getColor(float v) {
  v = abs(v); 
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 0.2));
}
