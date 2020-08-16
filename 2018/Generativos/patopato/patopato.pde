import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  int back = rcol();
  //back = colors[1];

  randomSeed(seed);
  noiseSeed(seed);
  background(back);


  float ax = 0;
  float ay = 0;

  ArrayList points = new ArrayList();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);

    points.add(new PVector(x, y));

    x -= x%5;
    y -= y%5;

    float s = random(width)*random(1);

    boolean add = true;
    float ia = (TAU*int(16))/16;
    float aa = ia;

    while (add) {
      float na = aa+(PI*int(random(8)))/16;
      if (na > ia+TAU) { 
        add = false;
        na = ia+TAU;
      }

      noStroke();
      stroke(255, 18);
      float alp = random(255);
      arc2(x, y, s*0.1, s, aa, na, rcol(), alp*0.9, alp);

      aa = na;
    }

    noFill();
    float str = s*random(0.1);
    strokeWeight(str);
    stroke(rcol());
    ellipse(x, y, s, s);
    fill(rcol());
    ellipse(x, y, s*0.1, s*0.1);

    int cc = int(random(100)*random(1));
    float da = TAU/cc;
    noStroke();
    for (int j = 0; j < cc; j++) {
      arc2(x, y, s-str, s+str, da*j, da*(j+1), rcol(), 120, 200);
      arc2(x, y, s+str*0.4, s+str, da*j, da*(j+1), color(255), 0, random(200*random(1)));
    }

    noFill();
    strokeWeight(1);
    stroke(rcol());
    wire(x, y, ax, ay);
    ax = x;
    ay = y;

    //arc2(x, y, s*0.8, s, 0, TAU, color(255), 0, 20);
  }

  ArrayList triangles = Triangulate.triangulate(points);

  // draw the mesh of triangles
  stroke(0, 4);
  beginShape(TRIANGLES);

  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(255, random(30));
    vertex(t.p1.x, t.p1.y);
    fill(255, random(30));
    vertex(t.p2.x, t.p2.y);
    fill(255, random(30));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}


void wire(float x1, float y1, float x2, float y2) {
  float dy = abs(y1-y2)+abs(x1-x2)*0.2;
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5+dy*0.5;
  /*
  noFill();
   stroke(rcol());
   strokeWeight(0.5);
   beginShape();
   curveVertex(x1, y1);
   curveVertex(x1, y1);
   curveVertex(cx, cy);
   curveVertex(x2, y2);
   curveVertex(x2, y2);
   endShape();
   */


  strokeWeight(1);
  noStroke();
  int steps = int(dist(x1, y1, cx, cy)*3);
  float pwr = 1;//random(0.1, 2);
  for (int i = 0; i <= steps; i++) {
    float t = i / float(steps);
    float x = curvePoint(x1, x1, cx, x2, t);
    float y = curvePoint(y1, y1, cy, y2, t);
    float s = map(t, 0, 1, 0.2, 0.5);
    s = map(pow(cos(i*0.2), pwr), 0, 1, 0.5*s, 1.8*s);
    noStroke();
    fill(getColor(t*colors.length));
    ellipse(x, y, s, s);
    if (random(100) < 0.1) {
      stroke(rcol());
      noFill();
      ellipse(x, y, s*20, s*20);
    }
  }
  for (int i = 0; i <= steps; i++) {
    float t = i / float(steps);
    float x = curvePoint(x1, cx, x2, x2, t);
    float y = curvePoint(y1, cy, y2, y2, t);
    float s = map(t, 0, 1, 0.5, 1);
    s = map(pow(cos(i*0.2), pwr), 0, 1, 0.5*s, 1.8*s);
    noStroke();
    fill(getColor(t*colors.length));
    ellipse(x, y, s, s);
    if (random(100) < 0.1) {
      stroke(rcol());
      noFill();
      ellipse(x, y, s*20, s*20);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
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
  return lerpColor(c1, c2, v%1);
}
