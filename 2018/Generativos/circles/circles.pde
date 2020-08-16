int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(255);

  noStroke();

  for (int c = 0; c < 60; c++) {
    float ss = width*random(0.3)*random(1)*random(0.5, 1);
    float xx = random(width);
    float yy = random(height);
    int[] cols = rcols(4);
    float ang = random(TWO_PI);
    //ang = PI*0.5;

    pushMatrix();
    translate(xx, yy);
    rotate(ang);

    int res = 60;
    float r1 = ss*0.5;
    float r2 = r1*random(0.5, 10);
    float amp = random(0.1)*random(1);
    float shw = random(200)*random(1);
    shw = 200;
    shader(noi);
    for (int i = 0; i < res; i++) {
      float a1 = map(i, 0, res, -HALF_PI, HALF_PI);
      float a2 = map(i+1, 0, res, -HALF_PI, HALF_PI);
      float x1 = cos(a1)*r1;
      float y1 = sin(a1)*r1;
      float x2 = cos(a2)*r1;
      float y2 = sin(a2)*r1;
      beginShape();
      fill(cols[0], shw);
      vertex(x2, y2);
      vertex(x1, y1);
      fill(cols[0], 0);
      vertex(x1+cos(a1*amp)*r2, y1+sin(a1*amp)*r2);
      vertex(x2+cos(a2*amp)*r2, y2+sin(a2*amp)*r2);
      endShape(CLOSE);
    }

    resetShader();
    fill(cols[0]);
    ellipse(0, 0, ss, ss);
    float s2 = ss*random(0.1, 0.8);
    fill(cols[1]);
    ellipse(0, 0, s2, s2);

    /*
    fill(cols[0]);
     ellipse(-ms, 0, ss, ss);
     fill(cols[1]);
     ellipse(+ms, 0, ss, ss);
     fill(cols[2]);
     float s2 = ss*random(0.1, 0.8);
     if (random(1) < 0.5) ellipse(+ms, 0, s2, s2);
     */
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};
int rcol() {
  return colors[int(random(colors.length))];
}
int[] rcols(int cc) {
  cc = constrain(cc, 1, colors.length);
  int[] aux = new int[cc];
  aux[0] = rcol();
  for (int i = 1; i < cc; i++) {
    boolean add = true;
    while (add) {
      add = false;
      aux[i] = rcol();
      for (int j = 0; j < i; j++) {
        if (aux[i] == aux[j]) {
          add = true;
        }
      }
    }
  }
  return aux;
}

int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}