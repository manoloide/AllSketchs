import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
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
  for (int kk = 0; kk < 1000; kk++) {
    pushMatrix();
    float time = (kk*1./60)*random(0.1, 1);

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


      float fov = PI/random(1.2, 3);
      float cameraZ = (height/2.0) / tan(fov/2.0);
      perspective(fov, float(width)/float(height), 
        cameraZ/10.0, cameraZ*10.0);



      float rad = random(160, 200)*(1+cos(random(1000)+time*random(0.2))*0.9)*4;

      /*
    stroke(255, 0, 0, 60);
       {
       float da = TAU/6;
       for (int i = 0; i < 6; i++) {
       line(0, 0, -rad, cos(da*i)*rad*2, sin(da*i)*rad*2, -rad);
       }
       }
       */

      {
        int div = 32;
        int sub = 32;

        float osc1 = cos(time*random(2.2)*random(1))*0.5;

        float da = random(0.1)*cos(time*random(2))*1;

        noStroke();

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


            fill(255);
            if ((i+j)%2 == 0) fill(0);
            beginShape();
            vertex(cos(a1+dda1)*rad*amp1, sin(a1+dda1)*rad*amp1, d1);
            vertex(cos(a1+dda2)*rad*amp2, sin(a1+dda2)*rad*amp2, d2);
            vertex(cos(a2+dda2)*rad*amp2, sin(a2+dda2)*rad*amp2, d2);
            vertex(cos(a2+dda1)*rad*amp1, sin(a2+dda1)*rad*amp1, d1);
            endShape(CLOSE);
          }
        }
      }
    }
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#0C4BDB, #B673F6, #36F98E, #FCF52A, #FF89D2};
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
  return lerpColor(color(255), lerpColor(c1, c2, pow(v%1, 4.8)), random(0.96, 1));
}
