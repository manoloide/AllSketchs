int seed = int(random(999999));
PImage noise;

void setup() {
  //size(1280, 960, P3D);
  //size(640, 480, P3D);
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  textureMode(NORMAL);
  createNoise();

  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {

  seed = int(random(999999));
  color back = rcol(sky);
  background(back);
  randomSeed(seed);


  float uh = 1.1;
  float hh = height*uh;


  hint(DISABLE_DEPTH_TEST);

  noStroke();
  for (int c = 0; c < 4; c++) {
    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(lerpColor(back, rcol(colors), 0.5));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
    for (int i = 0; i < 2000; i++) {
      float x = random(width);
      float y = random(hh);
      float s = random(2 )*random(1);
      fill(rcol(colors), random(200, 256));
      ellipse(x, y, s, s);
    }

    for (int i = 0; i < 5; i++) {
      float s = width*random(0.1, 0.8)*random(1);
      float x = random(width);
      float y = random(-s, hh  +s);
      noStroke();
      arc2(x, y, s, s*2.6, 0, TWO_PI, color(0), 14, 0);
      int col = getColor(colors);
      fill(col);
      ellipse(x, y, s, s);
      arc2(x, y, s*0.4, s, 0, TWO_PI, color(0), 0, 20);
      arc2(x, y, s*0.0, s, 0, TWO_PI, color(0), 0, 30);
      arc2(x, y, s*0.8, s, 0, TWO_PI, color(col), 0, 80);
      arc2(x, y, s*1.1, s, 0, TWO_PI, color(col), 0, 40);
      //arc2(x, y, s*2, s, 0, TWO_PI, color(col), 0, 40);
    }

    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(back, random(40, 110));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
  }

  //stroke(0, 80);
  fill(lerpColor(color(0), back, 0.5), 250);
  float des = random(10000);
  float det = random(0.01);
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(hh);
    if (noise(des+x*det, des+y*det) < 0.6) continue;
    float r = random(2, 6)*random(0.1, 1);
    float ang = random(-0.3, 0.3);

    float hdx = cos(ang+0)*r;
    float hdy = sin(ang+0)*r;
    float vdx = cos(ang+HALF_PI)*r;
    float vdy = sin(ang+HALF_PI)*r;
    float dy = random(-0.2, 0.2);
    beginShape();
    vertex(x-hdx, y-hdy);
    vertex(x-hdx*0.5, y-hdy*0.5);
    vertex(x+vdx*(0.15+dy), y+vdy*(0.15+dy));
    vertex(x+hdx*0.5, y+hdy*0.5);
    vertex(x+hdx, y+hdy);
    vertex(x+hdx*0.5+vdx*0.05, y+hdy*0.5+vdy*0.05);
    vertex(x+vdx*(0.3+dy), y+vdy*(0.3+dy));
    vertex(x-hdx*0.5+vdx*0.05, y-hdy*0.5+vdy*0.05);
    //vertex(x, y-10);
    endShape(CLOSE);
  }


  pushMatrix();

  beginCamera();
  float fov = PI/random(1.4, 2.4);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*1000.0);

  hint(ENABLE_DEPTH_TEST);
  translate(random(width), height/2);
  rotateX(-PI*random(0.09, 0.11));
  rotateY(random(-0.1, 0.1));
  rotateZ(random(-0.1, 0.1));

  ambientLight(128, 128, 128);
  directionalLight(128, 128, 128, 0, 0.8, -1);
  lightFalloff(1, 0, 0);

  for (int c = 0; c < 80; c++) {
    int cw = int(random(4, 20)); 
    int ch = int(random(random(4, 10), 40)); 
    float dd = width*random(0.4, 1.2)/max(cw, ch);
    pushMatrix();
    translate(-cw*dd*0.5+random(-width*3, width*3), -ch*dd*0.5+random(-height*3, height*3), random(-2000, 1000)); 
    noStroke();
    float h = random(-100, 100);
    float amp = random(0.4, 0.9);
    for (int j = -ch; j <= 0; j++) {
      for (int i = 0; i <= cw; i++) {
        pushMatrix();
        translate(i*dd, h, j*dd);
        fill(rcol(colors));
        box(dd*amp);
        popMatrix();
      }
    }
    popMatrix();
  }
  popMatrix();
  endCamera();


  fov = PI/3;
  cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*1000.0);

  tint(255, 18);
  image(noise, 0, 0, width, height);
}

void createNoise() {
  noise = createImage(1920, 1920, RGB);
  noise.loadPixels();
  for (int i = 0; i < noise.pixels.length; i++) {
    noise.pixels[i] = color(random(140, 255));
  }
  noise.updatePixels();
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
//int colors[] = {#02A8D8, #CFB8D8, #BA001C, #EAC400, #101F20};
//int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int colors[] = {#312845, #81B4EB, #C16398, #FF433A, #FFB31D, #FFFFFF};
int sky[] = {#B4AFBD, #8D98B7, #4772A0, #2C5D92, #1D4C7C};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}
int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}