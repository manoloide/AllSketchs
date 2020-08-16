
import peasy.PeasyCam;


PeasyCam cam;

int seed = int(random(999999));
float time;

float openTime = 0;
boolean open = true;

void setup() {
  size(960, 540, P3D);
  smooth(8);
  pixelDensity(2);
  
  
  cam = new PeasyCam(this, 400);
  cam.setWheelScale(0.02);

  generate();
}

void draw() {

  float actTime = millis()*0.001;
  float difTime = actTime-time;
  time = actTime;
  
  if(open){
    if(openTime < 1) openTime+=difTime;
  }
  else {
    if(openTime > 0) openTime-=difTime;
  }
  

  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void generate() { 

  randomSeed(seed);

  background(#07194B);


  float fov = PI/random(2, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  //translate(width*0.5, height*0.5);
  float maxRot = random(0.1, 0.2);
  /*
  rotateX(PI*random(-maxRot, maxRot));
  rotateY(PI*random(-maxRot, maxRot));
  rotateZ(PI*random(-maxRot, maxRot));
  */

  blendMode(ADD);
  hint(DISABLE_STROKE_PERSPECTIVE);

  noFill();
  stroke(255, 180);
  int cc = int(random(200, 900));
  for (int i = 0; i < cc; i++) {
    pushMatrix();
    translate(0, 0, width*random(0.05));
    rotate(time*random(-1, 1)*random(0.1));
    float ss = width*random(2.2);
    int rnd = int(random(40));
    noFill();
    if (rnd == 0) {
      ellipse(0, 0, ss, ss);
    }
    if (rnd == 1) {
      float a1 = 0;
      float a2 = TAU;
      if (random(1) < 0.3) {
        a1 = random(TAU);
        a2 = a1+random(TAU)*random(0.4, 1);
      }
      int sub = int(ss*(a2-a1)*random(0.2, 1)*0.2*random(1));
      float da = (a2-a1)/sub;
      float amp = random(0.1, 0.9);
      for (int j = 0; j < sub; j++) {
        arc(0, 0, ss, ss, a1+da*j, a1+da*(j+amp));
      }
    } 
    if (rnd == 2) {
      float a1 = 0;
      float a2 = TAU;
      if (random(1) < 0.8) {
        a1 = random(TAU);
        a2 = a1+random(TAU)*random(0.4, 1);
      }
      int sub = int(ss*(a2-a1)*random(0.2, 1)*0.2*random(1));
      float da = (a2-a1)/sub;
      float det = random(100)*random(1);
      float des = random(1000);
      float r = ss*0.5;
      float alp = random(255);
      for (int j = 0; j < sub; j++) {
        float x = cos(a1+j*da);
        float y = sin(a1+j*da);
        float h = noise(des+x*det, des+y*det)*ss*0.2;
        stroke(rcol(), alp);
        line(x*r, y*r, 0, x*r, y*r, h);
      }
    }  

    if (rnd == 3) {
      float ang = random(TAU);
      float dis = random(ss);
      float cir = ss*random(0.01, 0.2);
      ellipse(0, 0, cir, cir);
      line(cos(ang)*cir*0.5, sin(ang)*cir*0.5, cos(ang)*(dis-cir*0.2), sin(ang)*(dis-cir*0.2));

      ellipse(cos(ang)*(dis-cir*0.1), sin(ang)*(dis-cir*0.1), cir*0.1, cir*0.1);
    }  

    if (rnd == 4) {
      float a1 = random(TAU);
      float a2 = a1+random(TAU)*random(0.4, 1)*0.5;
      int sub = int(ss*(a2-a1)*random(0.2, 1)*0.1*random(1));
      float da = (a2-a1)/sub;
      float r = ss*0.5;
      float alp = random(200, 255);
      float amp = 1-random(0.1);
      for (int j = 0; j < sub; j++) {
        float x = cos(a1+j*da);
        float y = sin(a1+j*da);
        stroke(rcol(), alp);
        line(x*r*amp, y*r*amp, x*r, y*r);
      }
    }
    
    
    if (rnd == 4) {
      float a1 = random(TAU);
      float a2 = a1+random(TAU)*random(0.4, 1)*random(0.5);
      int sub = int(ss*(a2-a1)*random(0.2, 1)*0.1);
      float da = (a2-a1)/sub;
      float r1 = ss*0.5;
      float r2 = r1*random(0.6, 0.94);
      if(random(1) < 0.2) r2 = 0;
      stroke(255, 4);
      int col1 = rcol();
      int col2 = rcol();
      if(random(1) < 0.2) col1 = col2;
      float alp1 = random(200);
      float alp2 = random(200);
      for (int j = 0; j < sub; j++) {
        float aa1 = a1+j*da;
        float aa2 = a1+j*da+da;
        beginShape();
        fill(col1, alp1);
        vertex(cos(aa1)*r1, sin(aa1)*r1);
        vertex(cos(aa2)*r1, sin(aa2)*r1);
        fill(col2, alp2);
        vertex(cos(aa2)*r2, sin(aa2)*r2);
        vertex(cos(aa1)*r2, sin(aa1)*r2);
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

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#34302E, #72574C, #9A4F7D, #488753, #D9BE3A, #D9CF7C, #E2DFDA, #CF4F5C, #368886};
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