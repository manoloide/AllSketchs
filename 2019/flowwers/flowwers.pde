import peasy.PeasyCam;
PeasyCam cam;

int seed = int(random(999999));

void setup() {
  size(displayWidth, displayHeight, P3D);
  smooth(8);
  cam = new PeasyCam(this, 600);
}


void draw() {

  cam.beginHUD();
  //background(240);
  noStroke();
  fill(240, 230);
  rect(0, 0, width, height);
  cam.endHUD();

  noiseSeed(seed);
  randomSeed(seed);

  //lights();
  //ambientLight(120, 120, 120);


  float fov = PI/2.2;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  for (int j = -1; j <= 1; j++) {
    for (int i = -1; i <= 1; i++) {
      pushMatrix();
      translate(i*5000, j*5000, 0);
      flower();
      popMatrix();
    }
  }
}

void flower() {

  float time = millis()*0.001;
  float rad = 180*(1+cos(random(1000)+time*random(0.2))*0.06)*4;

  translate(0, 0, -rad*0.999);

  stroke(0, 60);
  {
    float da = TAU/6;
    for (int i = 0; i < 6; i++) {
      line(0, 0, -rad, cos(da*i)*rad*2, sin(da*i)*rad*2, -rad);
    }
  }

  {
    int div = 32;
    int sub = 24;

    float osc1 = cos(time*random(2.2)*random(1))*0.1;

    float da = random(0.1)*cos(time*random(2))*random(3)*random(1);

    noStroke();

    float osc = random(10, 100)*random(1)*random(1);
    float oscVel = time*random(3)*random(1);
    float oscAmp = random(1)*random(1)*0.4;

    beginShape(QUADS);
    for (int j = 0; j < sub; j++) {
      float a1 = map(j, 0, sub, 0, TAU);
      float a2 = map(j+1, 0, sub, 0, TAU);

      for (int i = 0; i < sub; i++) {
        float d1 = map(i, 0, sub, -rad, rad);
        float d2 = map(i+1, 0, sub, -rad, rad);

        float v1 = pow(map(i+0, 0, sub, 0, 1), 2.2+osc1);
        float v2 = pow(map(i+1, 0, sub, 0, 1), 2.2+osc1);

        float amp1 = sin(map(v1, 0, 1, 0, PI))*0.4*(1-sin(v1*osc+oscVel)*oscAmp);
        float amp2 = sin(map(v2, 0, 1, 0, PI))*0.4*(1-sin(v2*osc+oscVel)*oscAmp);

        float dda1 = da*(i+0);//da*(i+0);
        float dda2 = da*(i+1);//da*(i+1);


        fill(255);
        if ((i+j)%2 == 0) fill(0);
        if (i == sub-1) fill(255, 180, 0);
        vertex(cos(a1+dda1)*rad*amp1, sin(a1+dda1)*rad*amp1, d1);
        vertex(cos(a1+dda2)*rad*amp2, sin(a1+dda2)*rad*amp2, d2);
        vertex(cos(a2+dda2)*rad*amp2, sin(a2+dda2)*rad*amp2, d2);
        vertex(cos(a2+dda1)*rad*amp1, sin(a2+dda1)*rad*amp1, d1);
      }
    }        
    endShape(CLOSE);
  }

  stroke(255, 0, 0, 60);
  {
    float da = TAU/6;
    float ss = random(30, 50)*1.4;
    
    int cc = int(random(3, 8));
    float lar = rad*random(0.8, 1.0);
    
    for (int i = 0; i < cc; i++) {

      float dx = noise(2323, i*time*random(0.1))*ss-ss*0.5;
      float dy = noise(i*time*random(0.1), 2323)*ss-ss*0.5;
      float dz = noise(i*time*random(0.1), 233)*ss-ss*0.5;

      float x1 = cos(da*i+random(-0.5, 0.5))*lar*0.05+dx;
      float y1 = sin(da*i+random(-0.5, 0.5))*lar*0.05+dy;
      float z1 = rad*random(1.18, 1.24)+dz;
      stroke(0);
      strokeWeight(1);
      line(0, 0, +rad, x1, y1, z1);
      stroke(250, 80, 180);
      strokeWeight(random(2, 8)*1.6);
      point(x1, y1, z1);
    }
    strokeWeight(1);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}
