import java.util.Random; 
import processing.pdf.*;

int WIDTH = 897;
int HEIGHT = 1497;

int colors[] = {#000000, #b49f55, #ffffff};

JSONObject settings;
PGraphics render;
UI ui;

int scale = 0;

void setup() {
  size(1280, 720);
  surface.setResizable(true);
  loadSettings();
  render = createGraphics(WIDTH, HEIGHT);
  smooth(8);
  createUI();
  randomAll();
  generate(render);
}

void loadSettings() {
  settings = loadJSONObject("data/settings.json");
}

void draw() {
  background(100);

  ui.update();
  updateUIValues();
  if (ui.change) generate(render);

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
  if (key == 'p') savePDF();
  if (key == 'g') randomAll();
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
  int m = (int)constrain(event.getCount(), -1, 1);
  scale -= m;
}

/*
void resized() {
 ui.h = height;
 }
 */

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  render.save("exports/"+timestamp+".png");
}

void savePDF() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  PGraphics pdf = createGraphics (WIDTH, HEIGHT, PDF, "exports/"+timestamp+".pdf");
  generate(pdf);
  render = createGraphics(WIDTH, HEIGHT);
  generate(render);
}

void randomAll() {

  back.select = int(1+random(3));
  forms.select = int(random(6));

  rndCircularBack(render);
  rndHexBack(render);
  rndTramaBack(render);
  rndCircularForm(render);

  generate(render);
}

void generate(PGraphics render) {
  render.beginDraw();
  render.smooth(8);
  render.background(colors[0]);
  back(render);
  frame(render);
  forms(render);
  render.dispose ();
  render.endDraw();
}

void back(PGraphics render) {
  if (back.select == 1) circularBack(render);
  if (back.select == 2) hexBack(render);
  if (back.select == 3) tramaBack(render);
}

void rndCircularBack(PGraphics render) {
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


  //circularBack(render, cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}


void circularBack(PGraphics render) {
  int cc = (int) circularAmount.getValue();
  float dx = circularDesxAmount.getValue();
  float dy = circularDesyAmount.getValue();
  float amp = circularAmplitud.getValue();
  int sub = (int)circularSub.getValue();
  float subAmp = circularSubAmplitud.getValue();
  boolean halo =  circularHalo.getValue();
  float haloAmp = circularHaloAmplitud.getValue();
  float haloAlp =  circularHaloAlpha.getValue();

  circularBack(render, cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}

void circularBack(PGraphics render, int cc, float dx, float dy, float amp, int sub, float subAmp, boolean halo, float haloAmp, float haloAlp) {
  float cx = render.width*0.5;
  float cy = render.height*0.5;
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

void rndHexBack(PGraphics render) {  
  float ss = random(60, 320);
  boolean triangles = (random(1) < 0.5);
  boolean second = (random(1) < 0.5);
  float amp = random(0.4, 1);
  float amp2 = random(0.4, 1);

  hexSize.setValue(ss);
  hexAmplitud.setValue(amp);
  hexAmplitud2.setValue(amp2);
  hexTriangles.setValue(triangles);
  hexSecond.setValue(second);

  //hexBack(render, ss, triangles, second, amp, amp2);
}


void hexBack(PGraphics render) {
  float ss = hexSize.getValue();
  float amp = hexAmplitud.getValue();
  float amp2 = hexAmplitud2.getValue();

  boolean triangles = hexTriangles.getValue();
  boolean second = hexSecond.getValue();

  hexBack(render, ss, triangles, second, amp, amp2);
}

void hexBack(PGraphics render, float ss, boolean triangles, boolean second, float amp, float amp2) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;

  float dx = ss * 2 * (3./4);
  float dy = (sqrt(3)*ss)/4;
  int cw = int(render.width/dx)+2;
  int ch = int(render.height/dy)+2;

  render.noFill();
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = cx+((j%2==0)? i : i+0.5)*dx;
      float y = cy+j*dy;
      render.strokeWeight(1);
      render.stroke(#b49f55);
      //fill(0);
      //hex(x, y, ss);
      if (triangles) hexTri(render, x, y, ss);
      render.strokeWeight(ss*0.025);
      render.noFill();
      hex(render, x, y, ss*amp);

      if (second) {
        float ang = PI/3;
        float x1 = x+ss*cos(ang)*0.5;
        float y1 = y+ss*sin(ang)*0.5;
        render.strokeWeight(ss*0.025);
        render.stroke(#b49f55);
        hex(render, x1, y1, ss*amp);
        render.strokeWeight(ss*0.01);
        hex(render, x1, y1, ss*amp2);
      }
    }
  }
}

void hex(PGraphics render, float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  render.beginShape();
  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    render.vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  render.endShape(CLOSE);
}

void hexTri(PGraphics render, float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    float ang2 = da*(i+1);  
    render.beginShape();
    render.vertex(x, y);
    render.vertex(x+cos(ang)*r, y+sin(ang)*r);
    render.vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    render.endShape(CLOSE);
  }
}

void rndTramaBack(PGraphics render) {  
  int cc = int(random(1, 7));
  float sep = random(4, random(60));
  float ia = random(TWO_PI);
  float minStr = random(0.4)*random(1)*random(1);
  float maxStr = random(0.4)*random(1);

  float bw = random(-0.1, 0.2);
  float bh = random(-0.1, 0.2);
  float bb = random(0.5, 1);

  int ps = int(random(1, random(6)));

  tramaAmount.setValue(cc);
  tramaSeparation.setValue(sep);
  tramaAngle.setValue(ia);
  tramaMinStroke.setValue(minStr);
  tramaMaxStroke.setValue(maxStr);

  tramaBorderWidth.setValue(bw);
  tramaBorderHeight.setValue(bh);
  tramaBorder.setValue(bb);
  tramaPISub.setValue(ps);

  //tramaBack(render, cc, sep, ia, minStr, maxStr, bw, bh, bb, ps);
}

void tramaBack(PGraphics render) {
  int cc = (int)tramaAmount.getValue();
  float sep = tramaSeparation.getValue();
  float ia = tramaAngle.getValue();
  float minStr = tramaMinStroke.getValue();
  float maxStr = tramaMaxStroke.getValue();

  float bw = tramaBorderWidth.getValue();
  float bh = tramaBorderHeight.getValue();
  float bb = tramaBorder.getValue();

  int ps = (int)tramaPISub.getValue();

  tramaBack(render, cc, sep, ia, minStr, maxStr, bw, bh, bb, ps);
}

void tramaBack(PGraphics render, int cc, float sep, float ia, float minStr, float maxStr, float bw, float bh, float bb, int ps) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;
  float diag = dist(0, 0, render.width, render.height);
  float da = (TWO_PI/ps)/cc;

  bw *= render.width;
  bh *= render.height;
  minStr *= sep;
  maxStr *= sep;

  for (int j = 0; j < cc; j++) {
    float ang = ia+da*j;
    render.stroke(colors[1]);
    float sx = cos(ang+HALF_PI);
    float sy = sin(ang+HALF_PI);
    float dx = cos(ang)*diag;
    float dy = sin(ang)*diag;
    for (float i = -diag/2.; i < diag/2; i+=sep) {
      float x1 = cx-dx-sx*i;
      float y1 = cy-dy-sy*i;
      float x2 = cx+dx-sx*i;
      float y2 = cy+dy-sy*i;
      Line line = lineIntersectionRect(new PVector(x1, y1), new PVector(x2, y2), new PVector(bw, bh), new PVector(render.width-bw*2, render.height-bh*2));
      if (line != null) {
        render.strokeWeight(map(abs(i), 0, diag/2, minStr, maxStr));
        render.line(line.p1.x, line.p1.y, line.p2.x, line.p2.y);
      }
    }
  }


  render.noFill();
  render.strokeWeight(sep*bb);
  render.rect(bw, bh, render.width-bw*2, render.height-bh*2);
}

class Line {
  PVector p1, p2;   
  Line(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  Line(float x1, float y1, float x2, float y2) {
    this(new PVector(x1, y1), new PVector(x2, y2));
  }
}

PVector segmetnsIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float A1 = y2-y1;
  float B1 = x1-x2;
  float C1 = A1*x1+B1*y1;

  float A2 = y4-y3;
  float B2 = x3-x4;
  float C2 = A2*x3+B2*y3;

  float delta = A1*B2 - A2*B1;
  if (delta == 0)
    return null;

  float nx = (B2*C1 - B1*C2)/delta;
  float ny = (A1*C2 - A2*C1)/delta;

  //if (abs(dist(nx, ny, x1, y1)+dist(nx, ny, x2, y2)-dist(x1, y1, x2, y2)) < 0.000001 && abs(dist(nx, ny, x3, y3)+dist(nx, ny, x4, y4)-dist(x3, y3, x4, y4)) < 0.000001) {
  if (((abs(x1-nx)+abs(nx-x2))-abs(x1-x2) < 0.001) && ((abs(y1-ny)+abs(ny-y2))-abs(y1-y2) < 0.001)) {
    //if (pointInRect(nx, ny, min(x1, x2), min(y1, y2), abs(x1-x2), abs(y1-y2)) && pointInRect(nx, ny, min(x3, x4), min(y3, y4), abs(x3-x4), abs(y3-y4))) {
    return new PVector(nx, ny);
  }
  return null;
}

PVector segmetnsIntersection(PVector li1, PVector lf1, PVector li2, PVector lf2) {
  return segmetnsIntersection(li1.x, li1.y, lf1.x, lf1.y, li2.x, li2.y, lf2.x, lf2.y);
}

Line lineIntersectionRect(PVector p1, PVector p2, PVector rp, PVector s) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  if (p1.x >= rp.x && p1.x < rp.x+s.x && p1.y >= rp.y && p1.y < rp.y+s.y) {
    points.add(p1);
  }
  if (p2.x >= rp.x && p2.x < rp.x+s.x && p2.y >= rp.y && p2.y < rp.y+s.y) {
    points.add(p2);
  }

  if (points.size() < 2) {
    Line lines[] = new Line[4];
    lines[0] = new Line(rp.x, rp.y, rp.x+s.x, rp.y);
    lines[1] = new Line(rp.x+s.x, rp.y, rp.x+s.x, rp.y+s.y);
    lines[2] = new Line(rp.x+s.x, rp.y+s.y, rp.x, rp.y+s.y);
    lines[3] = new Line(rp.x, rp.y+s.y, rp.x, rp.y);

    for (int i = 0; i < 4; i++) {
      PVector aux = segmetnsIntersection(lines[i].p1, lines[i].p2, p1, p2);
      if (aux != null) {
        points.add(aux);
      }
    }
  }

  if (points.size() >= 2) {
    return new Line(points.get(0), points.get(1));
  }

  return null;
}

void frame(PGraphics render) {
  simpleBorder(render);
}


void simpleBorder(PGraphics render) {
  float s = min(render.width, render.height)*random(0.01, 0.1);
  float b = (random(1) < 0.5)? 0 : random(s);
  s = 50;
  b = 25;
  render.noFill();
  render.stroke(colors[0]);
  render.strokeWeight(s);
  render.rect(0, 0, render.width, render.height, s);
}

void forms(PGraphics render) {
  if (forms.select == 1) circularForm(render);
}


void rndCircularForm(PGraphics render) { 

  int cc = int(random(random(2, 10), 33));
  float r = random(0.3, 0.44);
  float s = random(0.01, 1);
  int sub = int(random(3, random(10, 25)));
  int seed = int(random(9999999));

  circularFormAmount.setValue(cc);
  circularFormRadius.setValue(r);
  circularFormSize.setValue(s);
  circularFormSub.setValue(sub);

  //circularForm(render, cc, r, s, sub, seed);
}

void circularForm(PGraphics render) {
  int cc = (int)circularFormAmount.getValue();
  float r = circularFormRadius.getValue();
  float s = circularFormSize.getValue();
  int sub = (int)circularFormSub.getValue();
  int seed = (int)circularFormSeed.getValue();

  circularForm(render, cc, r, s, sub, seed);
}

void circularForm(PGraphics render, int cc, float r, float s, int sub, int seed) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;

  r *= max(render.width, render.height);
  s = (s*0.1)*r;

  float dr = r/sub;
  float da = TWO_PI/cc;

  Random rand = new Random();
  rand.setSeed(seed);

  render.noStroke();
  for (int j = 0; j < sub; j++) {
    float rr = dr*j;
    int dj = int(cc*rand.nextFloat()*rand.nextFloat()*map(j, 0, sub, 1, -0.2));
    if (j%2 == 0) {
      float ss = s*rand.nextFloat()*(rand.nextFloat()*0.5+0.5);
      for (int i = 0; i < cc; i++) {
        float x = cx+cos(da*i)*rr;
        float y = cy+sin(da*i)*rr;
        render.noStroke();
        render.fill(colors[1]);
        render.ellipse(x, y, ss, ss);

        if (j > 0 && dj >= 0) {
          render.strokeWeight(1);
          render.stroke(colors[1]);

          float r2 = dr*(j-2);
          float x1 = cx+cos(da*(i+dj))*r2;
          float y1 = cy+sin(da*(i+dj))*r2;
          render.line(x, y, x1, y1);
          float x2 = cx+cos(da*(i-dj))*r2;
          float y2 = cy+sin(da*(i-dj))*r2;
          render.line(x, y, x2, y2);
        }
      }
    } else {
      render.noFill();
      render.stroke(colors[1]);
      render.strokeWeight(1+rand.nextFloat()*3);
      render.ellipse(cx, cy, rr, rr);
    }
  }
}