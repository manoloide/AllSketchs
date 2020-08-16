import peasy.PeasyCam;
PeasyCam cam;
PShape man;

int seed = int(random(999999));

void setup() {
  size(800, 600, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 300);

  man = loadShape("man.obj");
}

void draw() {

  float time = millis()*0.001;

  randomSeed(seed);
  noiseSeed(seed);

  background(230);


  noFill();

  stroke(0, 40);
  box(800, 300, 800);
  //box(200, 300, 200);


  cilinder();

  float ax = 0; 
  float ay = 0;
  float az = 0;
  for (int i = 0; i <= 100; i++) {
    float x = random(-400, 400);
    float y = random(-150, 150);
    float z = random(-400, 400);
    if (random(3) < 1) {
      x = (random(1) < 0.5)? -400 : 400;
    } else {
      if (random(1) < 0.5) {
        y = (random(1) < 0.5)? -150 : 150;
      } else {
        z = (random(1) < 0.5)? -400 : 400;
      }
    }
    x -= x%50;
    y -= y%50;
    z -= z%50;
    if (i > 0) {
      stroke(rcol());
      line(ax, ay, az, x, y, z);
    }
    ax = x; 
    ay = y;
    az = z;
  }

  //lights();
  float amb = 200;
  ambientLight(amb, amb, amb);
  lightFalloff(1.0, 0.001, 0.0);
  pointLight(140, 130, 110, 0, 0, 0); 

  //floor
  noStroke();
  fill(250);
  beginShape();
  vertex(-400, +150, -400);
  vertex(+400, +150, -400);
  vertex(+400, +150, +400);
  vertex(-400, +150, +400);
  endShape();

  directionalLight(51, 102, 126, 0, 1, 0);

  for (int i = 0; i < 3; i++) {
    pushMatrix();
    float xx = random(-300, 300);
    float yy = random(-300, 300);

    while (abs(xx) < 130 || abs(yy) < 130) {
      xx = random(-300, 300);
      yy = random(-300, 300);
    }

    float rot = atan2(yy, xx)+PI;

    rotateX(PI);
    translate(xx, -63, yy);
    scale(0.36);
    rotateY(-rot);
    shape(man);
    popMatrix();
  }

  noLights();

  cam.beginHUD();

  for (int i = 0; i < colors.length; i++) {
    fill(getColor(i));
    rect(10+i*25, 10, 20, 20);
  }

  textAlign(LEFT, TOP);
  textSize(12);
  fill(40);
  String info = "METROS HILO: "+str(totalHilo*0.01)+"\n";
  info += "DIVISIONES: "+str(divisiones)+"\n";
  text(info, 10, 40);
  cam.endHUD();
}

void cilinder() {

  int divisiones = 256;//int(random(500));//2;//256;
  float a1 = random(-1, 1)*TAU;
  float a2 = random(-1, 1)*TAU;

  int ic = int(random(4, 28));

  float totalHilo = 0;

  float rad = 160/2;
  float da = TAU/divisiones;
  for (int i = 0; i < divisiones; i++) {
    float v = i*1./divisiones;
    float x1 = cos(a1+da*i)*rad;
    float y1 = sin(a1+da*i)*rad;
    float x2 = cos(a2+da*i)*rad;
    float y2 = sin(a2+da*i)*rad;
    stroke(getColor(v*colors.length*ic), 200);
    line( x1, -150, y1, x2, 150, y2);
    totalHilo += dist(x1, -150, y1, x2, 150, y2);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'g') {
    seed = int(random(999999));
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#A06CA9, #A86679, #63A6A0, #8093D3, #193FD4};
//int colors[] = {#F0A202, #F18805, #D95D39, #202C59, #581F18};
int colors[] = {#172782, #432F73, #91448C, #CA426B, #D34242, #D54639, #E1752C, #E5B93D, #EBDA31, #AEDC4D, #4CAF3A, #319283, #2F91BB};

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
  return lerpColor(c1, c2, pow(v%1, 0.05));
}
