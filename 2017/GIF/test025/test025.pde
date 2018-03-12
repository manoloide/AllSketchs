int fps = 30;
float seconds = 10;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  frameRate(fps);
  background(255);
}

void draw() {
  if (export) time = map((frameCount-1), 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    saveFrame("export/f####.gif");
  }
}

void keyPressed() {
  seed = int(random(9999999));
  println(seed);
}

int seed = 1271405; 
void render() {
  background(0);

  {
    float fov = PI/3;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 
      cameraZ/10.0, cameraZ*10.0);
  }

  float tt = time%1;
  if (time < 0.6) {
    float time = map(tt, 0, 0.6, 0, 1);
    int cc = 11; 
    float ss = width*1./cc; 
    noStroke();
    rectMode(CENTER);
    translate(width/2, height/2);
    //translate(0, ss*time*2);
    rotate(PI*time);
    float sca = Easing.LinearOut(map(cos(time*PI), -1, 1, 0, 1), 0, 1, 1);
    scale(1+sca*4);
    //stroke(255, 0, 0);
    for (int j = -4; j <= cc+4; j++) {
      for (int i = -4; i <= cc+4; i++) {
        if ((i+j)%2 == 0) continue;
        pushMatrix();
        translate((i+0.5-cc*0.5)*ss, (j+0.5-cc*0.5)*ss);
        float tm = constrain(map(time, 0.0, 0.4, 0, 1), 0, 1);
        tm = Easing.ExpoOut(tm, 0, 1, 1);
        rotate(-tm*PI);
        if (time < 0.4) {
          rect(0, 0, ss*tm, ss*tm);
        } else {
          if (time < 0.8) {
            float rx = constrain(map(time, 0.42, 0.57, 0, 1), 0, 1);
            float ry = constrain(map(time, 0.62, 0.77, 0, 1), 0, 1);
            rx = Easing.QuadInOut(rx, 0, 1, 1);
            ry = Easing.QuadInOut(ry, 0, 1, 1);
            rotateX(rx*PI);
            rotateY(ry*PI);
            rect(0, 0, ss, ss);
          } else if (time < 0.97) {
            //rotate((((i-j)/2)%2)*HALF_PI);
            rectMode(CORNER); 
            float ry = map(time, 0.8, 0.97, 0, 1);
            ry = Easing.CubicOut(ry, 0, 1, 1);
            //ry = Easing.BounceOut(ry, 0, 1, 1);
            float rs = constrain(map(time, 0.9, 0.97, 1, 0), 0, 1);
            pushMatrix();
            rotateX(ry*HALF_PI);
            rect(-ss*0.5, 0, ss, -ss*0.5*rs);
            popMatrix();
            pushMatrix();
            rotateX(ry*-HALF_PI);
            rect(-ss*0.5, 0, ss, ss*0.5*rs);
            popMatrix();
          }
        }
        popMatrix();
      }
    }
  } else {
    float time = map(tt, 0.6, 1, 0, 1);

    background(0);
    pushMatrix();
    translate(width/2, height/2); 

    rectMode(CENTER);
    noFill();
    stroke(255);
    int cc = 16; 
    float sep = 800; 
    float ss = 800;
    float r = ss*0.5;
    noStroke();
    fill(255);

    float fov = PI/map(time, 0, 1, 6, 1.2);
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 
      cameraZ/100.0, cameraZ*100.0);


    translate(0, 0, -cc*sep*1*time);
    scale(map(time, 0, 1, 1, 0.1));
    rotate(time*PI);
    for (int i = 0; i < cc; i++) {
      pushMatrix(); 
      translate(0, 0, i*sep);
      for (int j = 0; j < 4; j++) {
        float a1 = HALF_PI*j;
        float a2 = HALF_PI*(j+1);
        beginShape();
        vertex(cos(a1)*r, sin(a1)*r, 0);
        vertex(cos(a1)*r, sin(a1)*r, ss*0.5);
        vertex(cos(a2)*r, sin(a2)*r, ss*0.5);
        vertex(cos(a2)*r, sin(a2)*r, 0);
        endShape(CLOSE);
      }
      //rect(0, 0, ss, ss);
      popMatrix();
    }
    popMatrix();
  }
}