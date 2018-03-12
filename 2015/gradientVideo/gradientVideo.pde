color c1, c2, c3, c4;
int size;
PGraphics render;
float vc = 0.01;
PFont helve, helveMono;
String scolor = "";
void setup() {
  size(1280, 600);
  frameRate(30);
  render = createGraphics(width, height);
  helve = createFont("Helvetica Neue Bold", 120, true);
  helveMono = createFont("Helvetica Neue Bold", 12, true);
  //textMode(SHAPE);
  size = int(pow(2, int(random(5, 10))));
  c1 = color(random(256), random(256), random(256));
  c2 = color(random(256), random(256), random(256));
  c3 = color(random(256), random(256), random(256));
  c4 = color(random(256), random(256), random(256));
  scolor = "#"+hex(c1)+" #"+hex(c2)+" #"+hex(c3)+" #"+hex(c4);
}

void draw() {
  c1 = lerpColor(c1, color(random(256), random(256), random(256)), vc);
  c2 = lerpColor(c2, color(random(256), random(256), random(256)), vc);
  c3 = lerpColor(c3, color(random(256), random(256), random(256)), vc);
  c4 = lerpColor(c4, color(random(256), random(256), random(256)), vc);
  if (frameCount%30 == 0) {
    size = int(pow(2, int(random(5, 8))));
    c1 = color(random(256), random(256), random(256));
    c2 = color(random(256), random(256), random(256));
    c3 = color(random(256), random(256), random(256));
    c4 = color(random(256), random(256), random(256));
    scolor = "#"+hex(c1)+" #"+hex(c2)+" #"+hex(c3)+" #"+hex(c4);
  }
  drawRender();
  image(render, 0, 0);
  textFont(helve);
  textAlign(LEFT, TOP);
  noStroke();
  fill(230, 210+cos(frameCount*0.05)*40);
  text("Gradient", 80, 140);
  textFont(helveMono);
  textMono(scolor, 84, 260);
  textFont(helve);
  float tt = (textWidth("Gradient")-4)*((frameCount%30)/30.);
  rect(84, 248, tt, 6);
  fill(230, 160);
  rect(84+tt, 248, (textWidth("Gradient")-4)-tt, 6);

  //saveFrame("####.png");
  if (80*30 < frameCount) {
    exit();
  }
}

void textMono(String str, int x, int y) {
  for (int i = 0; i < str.length (); i++) {
    text(str.charAt(i), x+i*12, y);
  }
}

void drawRender() {
  render.beginDraw();
  render.noStroke();
  for (int j = 0; j < height; j+=size) { 
    color ch1 = lerpColor(c1, c2, j*1./height);
    color ch2 = lerpColor(c3, c4, j*1./height);
    for (int i = 0; i < width; i+=size) {
      color col = lerpColor(ch1, ch2, i*1./width); 
      render.fill(col);
      render.rect(i, j, size, size);
    }
  }
  render.endDraw();
}
