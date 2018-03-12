int colors [] = {
  #FE4365, 
  #FC9D9A, 
  #F9CDAD, 
  #C8C8A9, 
  #83AF9B
};

PFont helve;
PShader vintage;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  vintage = loadShader("frag.glsl");
  vintage.set("iResolution", float(width), float(height));
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  
  vintage = loadShader("frag.glsl");
  vintage.set("iGlobalTime", millis() / 1000.0);
  vintage.set("iResolution", float(width), float(height));
  clear();
  int seed = int(random(999999));
  noiseSeed(seed);
  background(rcol());

  hint(DISABLE_DEPTH_TEST);
  int sss = int(random(20, 80));
  stroke(255, 240);
  strokeWeight(sss*random(0.2, 0.6));
  for (int i = int (-random (sss)); i < width+height; i+=sss) {
    line(i, -sss, -sss, i);
  }
  strokeWeight(1);

  hint(ENABLE_DEPTH_TEST);


  //lights();
  //lightFalloff(1.0, 0.001, 0.0);
  pushMatrix();
  //noStroke();
  translate(width/2, height/2, random(-4000, 200)*random(1));
  rotateX(-PI*random(0, 0.5));
  rotateY(PI*random(0, 1));
  {
    stroke(0, 30);
    int cc = 300;
    float det = 0.002;
    float sep = 20;
    float h = 1000;
    fill(rcol());
    beginShape(QUADS);
    for (int j = -cc/2; j < cc/2; j++) {
      for (int i = -cc/2; i < cc/2; i++) {
        float x = i*sep, z = j*sep, y = noise(x*det, z*det)*h;
        vertex(x, y, z);
        x = (i+1)*sep; 
        z = j*sep;
        y = noise(x*det, z*det)*h;
        vertex(x, y, z);
        x = (i+1)*sep; 
        z = (j+1)*sep;
        y = noise(x*det, z*det)*h;
        vertex(x, y, z);
        x = i*sep; 
        z = (j+1)*sep;
        y = noise(x*det, z*det)*h;
        vertex(x, y, z);
      }
    }
    endShape();
  }
  int ccc = int(random(600, 2000));
  for (int cc = 0; cc < ccc; cc++) {
    pushMatrix();
    float xx = random(-2000, 2000);
    float yy = random(-2000, 2000);
    translate(xx, +500, yy);
    fill(rcol());
    float anc = random(100);
    float h = random(200, 1000)*random(0.5, 1);
    int ch = int(random(60)); 
    int sub = int(random(3, 10)); 
    float da = TWO_PI/sub;
    float mh = -h/ch;
    float amp = random(0.1, 1);
    beginShape(QUADS);
    anc /= 2;
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < sub; i++) {
        float a = anc-anc*amp*(j%2);
        float x = cos(da*i) * a;
        float z = sin(da*i) * a;
        float y = mh * j;

        vertex(x, y, z);
        a = anc-anc*amp*(j%2);
        x = cos(da*(i+1)) * a;
        z = sin(da*(i+1)) * a;
        y = mh * j;
        vertex(x, y, z);
        x = cos(da*(i+1)) * a;
        z = sin(da*(i+1)) * a;
        y = mh * (j+1);
        vertex(x, y, z);
        x = cos(da*i) * a;
        z = sin(da*i) * a;
        y = mh * (j+1);
        vertex(x, y, z);
      }
    } 
    endShape();

    popMatrix();
  }
  popMatrix();

  {
    int w = 2000;
    int h = 2000;
    for (int i = 0; i < 20; i++) {
      pushMatrix();
      rotateX(random(TWO_PI));
      rotateY(random(TWO_PI));
      rotateZ(random(TWO_PI));
      noStroke();
      fill(rcol(), random(20));
      beginShape(); 
      vertex(-w, -h);
      vertex(-w, h);
      vertex(w, h);
      vertex(w, -h); 
      endShape(CLOSE) ;

      popMatrix();
    }
  }
  filter(vintage);
}

int rcol() {
  return colors[int(random(colors.length))];
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  n -= 1;
  saveFrame(nf(n, 3)+".png");
}

