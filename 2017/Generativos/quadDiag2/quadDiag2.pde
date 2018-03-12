void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  generate();
}


void draw() {
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
  background(200);
  translate(width/2, height/2);

  float diag = dist(0, 0, width, height);

  ArrayList<Quad> quads = new ArrayList<Quad>();
  quads.add(new Quad(0, 0, width, 0));


  noStroke();
  for (int i = 0; i < 1000; i++) {
    int ind = int(random(quads.size()*random(1)));
    Quad q = quads.get(ind);
    if (random(1) < 0.2) {
      Quad n = new Quad(q.x, q.y, q.s*sqrt(2)*0.5, q.a+HALF_PI/2);
      quads.add(n);
      q.show();
    } else {
      float ms = q.s*0.5;
      for (int j = 0; j < 4; j++) {  
        float ang = HALF_PI*(j+0.5)+q.a;
        float dx = cos(ang)*ms*0.5*sqrt(2);
        float dy = sin(ang)*ms*0.5*sqrt(2);
        Quad n = new Quad(q.x+dx, q.y+dy, ms, q.a);
        quads.add(n);
      }
    }
    quads.remove(ind);
  } 
  for (int i = 0; i < quads.size(); i++) {
    Quad q = quads.get(i); 
    q.show();
  }
}

int colors[] = {#f7bd37, #ffe50c, #db1922, #d9366d, #b41c59, #542462, #272f7a, #1d5468, #82cb9d};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}


class Quad {
  float x, y, s, a;
  Quad(float x, float y, float s, float a) {
    this.x = x;
    this.y = y;
    this.s = s;
    this.a = a;
  }
  void show() {
    pushMatrix(); 
    translate(x, y);
    rotate(a);
    float ss = s*0.5;
    beginShape();
    fill(getColor(random(colors.length)));
    vertex(-ss, -ss);
    fill(getColor(random(colors.length)));
    vertex(+ss, -ss);
    fill(getColor(random(colors.length)));
    vertex(+ss, +ss);
    fill(getColor(random(colors.length)));
    vertex(-ss, +ss);
    endShape(CLOSE);
    //rect(0, 0, s, s);
    popMatrix();
  }
}