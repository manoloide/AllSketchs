int WIDTH = 897;
int HEIGHT = 1497;

int colors[] = {#000000, #b49f55, #ffffff};

PGraphics render;
UI ui;

int scale = 0;

void setup() {
  size(1280, 720);
  render = createGraphics(WIDTH, HEIGHT);
  smooth(8);
  createUI();
  generate();
}

void draw() {
  background(100);

  ui.update();
  updateUIValues();
  if (ui.change) generate();

  pushMatrix();
  imageMode(CENTER);
  translate((width+ui.w)/2, height/2);
  scale(pow(2, scale));
  image(render, 0, 0);
  popMatrix();
  ui.show();
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'g') generate();
  if (key == '+') scale++;
  if (key == '-') scale--;
}

void mousePressed() {
  ui.input.pressed();
}

void mouseReleased() {
  ui.input.released();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scale -= (int)e;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save(timestamp+".png");
}

void generate() {

  render.beginDraw();
  render.background(colors[0]);
  back();
  frame();
  render.endDraw();
}

void back() {
  circularBack();
}

void rndCircularBack() {
  int cc = int(random(4, 38*random(1)))*2;
  float dx = (random(1) < 0.8)? 0 : random(-0.6, 0.6);
  float dy = (random(1) < 0.6)? 0 : random(-0.6, 0.6);
  float amp = random(0.5-random(0.3), 0.5+random(0.3));
  int sub = int(random(1, random(-4, 6)));
  float subAmp = random(0.4, 1);
  boolean halo = (random(1) < 1);
  float haloAmp = random(1.1, 1.5);
  float haloAlp = random(256*random(0.5, 0.9));

  circularAmount.setValue(cc);
  circularDesxAmount.setValue(dx);
  circularDesyAmount.setValue(dy);
  circularAmplitud.setValue(amp);

  circularSub.setValue(sub);
  circularSubAmplitud.setValue(subAmp);
  circularHalo.setValue(halo);
  circularHaloAmplitud.setValue(haloAmp);
  circularHaloAlpha.setValue(haloAlp);


  circularBack(cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}


void circularBack() {
  int cc = (int) circularAmount.getValue();
  float dx = circularDesxAmount.getValue();
  float dy = circularDesyAmount.getValue();
  float amp = circularAmplitud.getValue();
  int sub = (int)circularSub.getValue();
  float subAmp = circularSubAmplitud.getValue();
  boolean halo =  circularHalo.getValue();
  float haloAmp = circularHaloAmplitud.getValue();
  float haloAlp =  circularHaloAlpha.getValue();

  circularBack(cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}

void circularBack(int cc, float dx, float dy, float amp, int sub, float subAmp, boolean halo, float haloAmp, float haloAlp) {
  float cx = render.width*1./2;
  float cy = render.height*1./2;
  float dd = max(render.width, render.height);

  dx *= render.width;
  dy *= render.height;
  float da = TWO_PI/cc;
  float ma = amp/2;
  if (sub == 1) subAmp = 1;

  render.noStroke();
  render.fill(colors[1]);
  for (int i = 0; i < cc; i++) {

    if (halo) {
      render.fill(colors[1], haloAlp);
      float a1 = da*(i-ma*haloAmp);
      float a2 = da*(i+ma*haloAmp);
      render.beginShape();
      render.vertex(cx+dx, cy+dy);
      render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
      render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
      render.endShape(CLOSE);
    }

    if (sub == 1) {
      render.fill(colors[1]);
      float a1 = da*(i-ma);
      float a2 = da*(i+ma);
      render.beginShape();
      render.vertex(cx+dx, cy+dy);
      render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
      render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
      render.endShape(CLOSE);
    } else {
      float ia = da*(i-ma);
      float fa = da*(i+ma);
      float ta = fa-ia;
      float sd = ta/sub;
      float sa = sd*subAmp;
      sd += ((sd-sa)/(sub-1));
      render.fill(colors[1]);
      for (int j = 0; j < sub; j++) {
        float a1 = ia+sd*j;
        float a2 = ia+sd*j+sa;
        render.beginShape();
        render.vertex(cx+dx, cy+dy);
        render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
        render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
        render.endShape(CLOSE);
      }
    }
  }
}


void frame() {
  simpleBorder();
}


void simpleBorder() {
  float s = min(render.width, render.height)*random(0.01, 0.1);
  float b = (random(1) < 0.5)? 0 : random(s);
  s = 50;
  b = 25;
  render.noFill();
  render.stroke(colors[0]);
  render.strokeWeight(s);
  render.rect(0, 0, render.width, render.height, s);
}