int seed = int(random(999999));

float SCALE = 1;
float swidth, sheight;

void settings() {
  swidth = 960;
  sheight = 960;
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
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

  scale(SCALE);

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  float fov = PI/random(1.1, 2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);


  translate(swidth*0.5, sheight*0.5);


  for (int k = 0; k < 10; k++) {
    float maxRot = random(0.2);
    pushMatrix();
    translate(random(-1000, 1000), random(-1000, 1000), random(200));
    rotateX(random(-maxRot, maxRot));
    rotateY(random(-maxRot, maxRot));
    rotateZ(random(-maxRot, maxRot));

    int cc = int(random(8, 45));
    float sep = swidth*1./cc;
    float size = 1800;
    float sub = size/cc;
    noStroke();
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        float xx = (i+0.5-cc*0.5)*sub;
        float yy = (j+0.5-cc*0.5)*sub;
        float mw = sub*0.5*random(0.8, 1);
        float mh = sub*0.5*random(0.8, 1);
        int col = rcol();
        beginShape();
        fill(lerpColor(col, rcol(), random(random(1))));
        vertex(xx-mw*random(0.6, 1), yy-mh*random(0.6, 1));
        fill(lerpColor(col, rcol(), random(random(1))));
        vertex(xx+mw*random(0.6, 1), yy-mh*random(0.6, 1));
        fill(lerpColor(col, rcol(), random(random(1))));
        vertex(xx+mw*random(0.6, 1), yy+mh*random(0.6, 1));
        fill(lerpColor(col, rcol(), random(random(1))));
        vertex(xx-mw*random(0.6, 1), yy+mh*random(0.6, 1));
        endShape();
      }
    }
    popMatrix();
  }
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FFFEF8, #FAE0E0, #E66B85, #AFE9E5, #64B9DA, #427FAD, #3C5A81, #252B22, #539A6D, #ADBF83};
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
