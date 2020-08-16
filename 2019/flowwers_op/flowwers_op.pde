import peasy.PeasyCam;
PeasyCam cam;

int seed = int(random(999999));
PShader blur;

void setup() {
  size(1920, 1080, P3D);
  smooth(4);
  blur = loadShader("blur.glsl");
  cam = new PeasyCam(this, 800);
}


void draw() {

  float time = millis()*0.001*random(0.1, 1);

  //background(240);

  noiseSeed(seed);
  randomSeed(seed);

  //lights();
  //ambientLight(120, 120, 120);

  for (int k = 0; k < 5; k++) {

    float vr = time*random(1)*random(1)*0.2;

    translate(width*random(-0.4, 0.4), height*random(-0.4, 0.4), width*random(-0.4, 0.4));

    rotateX(vr*random(-1, 1));
    rotateY(vr*random(-1, 1));
    rotateZ(vr*random(-1, 1));

    scale(random(0.8, 1));


    float fov = PI/random(1.2, 3);
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 
      cameraZ/10.0, cameraZ*10.0);



    float rad = random(160, 200)*(1+cos(random(1000)+time*random(0.2))*0.9)*6;

    /*
    stroke(255, 0, 0, 60);
     {
     float da = TAU/6;
     for (int i = 0; i < 6; i++) {
     line(0, 0, -rad, cos(da*i)*rad*2, sin(da*i)*rad*2, -rad);
     }
     }
     */


    float col = random(colors.length);
    float ic = random(0.1)*random(20);

    col += ic*time;

    {
      int div = 32;
      int sub = 32;

      float osc1 = cos(time*random(2.2)*random(1))*0.5;

      float da = random(0.1)*cos(time*random(2))*1;

      noStroke();

      beginShape(QUADS);
      for (int j = 0; j < sub; j++) {
        float a1 = map(j, 0, sub, 0, TAU);
        float a2 = map(j+1, 0, sub, 0, TAU);

        for (int i = 0; i < sub; i++) {
          float d1 = map(i, 0, sub, -rad, rad);
          float d2 = map(i+1, 0, sub, -rad, rad);

          float v1 = pow(map(i+0, 0, sub, 0, 1), 1.8+osc1);
          float v2 = pow(map(i+1, 0, sub, 0, 1), 1.8+osc1);

          float amp1 = sin(map(v1, 0, 1, 0, PI))*0.4;
          float amp2 = sin(map(v2, 0, 1, 0, PI))*0.4;

          float dda1 = da*(i+0);//da*(i+0);
          float dda2 = da*(i+1);//da*(i+1);


          fill(getColor(col), 120);
          if ((i+j)%2 == 0) fill(getColor(col+2), 160);
          vertex(cos(a1+dda1)*rad*amp1, sin(a1+dda1)*rad*amp1, d1);
          vertex(cos(a1+dda2)*rad*amp2, sin(a1+dda2)*rad*amp2, d2);
          vertex(cos(a2+dda2)*rad*amp2, sin(a2+dda2)*rad*amp2, d2);
          vertex(cos(a2+dda1)*rad*amp1, sin(a2+dda1)*rad*amp1, d1);
        }
      }
      endShape(CLOSE);
    }
  }

  float blurAmp = 0.001;
  blur.set("time", time*0.01+random(1000));
  for (int i = 0; i < 5; i++) {
    blur.set("direction", blurAmp, 0);
    filter(blur); 
    blur.set("direction", 0, blurAmp);
    filter(blur);
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

//int colors[] = {#F94F00, #F9BD18, #4646EA, #1E1E1E, #EDEDED};
//int colors[] = {#0C4BDB, #B673F6, #FA4638, #FDE216};
//int colors[] = {#0C4BDB, #B673F6, #36F98E, #FCF52A, #FF89D2};
int colors[] = {#ffffff, #000000, #ffffff, #000000};
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
  return lerpColor(color(255), lerpColor(c1, c2, pow(v%1, 1.8)), random(0.96, 1));
}
