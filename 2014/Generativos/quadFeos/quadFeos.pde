int paleta[] = {
  #A92477, 
  #C42366, 
  #F32645, 
  #FF4F01, 
  #FFBF17
};

void setup() {
  size(800, 800);
  thread("generar");
}

void draw() {
}

void generar() {
  background(rcol());

  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, width));
  while (quads.size () < 200) {
    for (int i = 0; i < quads.size (); i++) {
      if (random(1) < 0.3) {
        PVector quad = quads.get(i);
        float x = quad.x;
        float y = quad.y;
        float t = quad.z/2;
        quads.remove(i);
        quads.add(new PVector(x, y, t));
        quads.add(new PVector(x+t, y, t));
        quads.add(new PVector(x, y+t, t));
        quads.add(new PVector(x+t, y+t, t));
      }
    }
  }
  for (int i = 0; i < quads.size (); i++) {
    PVector quad = quads.get(i);
    float x = quad.x;
    float y = quad.y;
    float t = quad.z;
    rectMode(CENTER);
    x += t/2;
    y += t/2;
    noFill();
    stroke(0, 8);
    noStroke();
    int cc = 50; 
    int col = rcol();
    int col2 = rcol();
    fill(col);
    for (int j = 0; j <= cc; j++) {
      fill(lerpColor(color(col), color(col2), map(j, 1, cc, 0, 1)));
      float tt = t-(j*(1./cc))*t;
      rect(x, y, tt, tt);
    }
  }
  noisee();

  fill(250, 20);
  noStroke();
  rect(width/2, height/2, width, height);
  for (int i = 0; i < 500; i++) {
    filter(BLUR, 0.3);
    if (i < 40) {
      fill(rcol());
      float t = random(3, 10);
      ellipse(random(width), random(height), t, t);
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage(); 
  else generar();
}

void noisee() {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = get(i, j);
      float bri = random(5);
      set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
    }
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1; 
  saveFrame(nf(n, 3)+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}
