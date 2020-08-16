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
  //background(240);
  noStroke();
  fill(240, 230);
  rect(0, 0, width, height);

  noiseSeed(seed);
  randomSeed(seed);

  //lights();
  //ambientLight(120, 120, 120);
  rotateX(random(PI));
  rotateY(PI+random(PI));
  rotateZ(random(PI));

  for (int k = 0; k < 10; k++) {
    pushMatrix();
    float fov = PI/2.2;
    float cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), 
      cameraZ/100.0, cameraZ*100.0);
    translate(width*0.5, height*0.5, -300);


    for (int j = -1; j <= 1; j++) {
      for (int i = -1; i <= 1; i++) {
        pushMatrix();
        translate(i*5000, j*5000, 0);
        flower();
        popMatrix();
      }
    }
    popMatrix();
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#F76FC1, #FF7028, #AFE36B, #29a8cc, #100082}; //
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
