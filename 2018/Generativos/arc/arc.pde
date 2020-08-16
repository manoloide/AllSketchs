import org.processing.wiki.triangulate.*;

int seed = int(random(999999));



void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
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

  int back = rcol();

  ambientLight(120, 120, 60);
  directionalLight(2, 60, 128, 0, -1, 1);
  directionalLight(200, 60, 128, 0, 1, 0);
  directionalLight(40, 60, 40, 1, 1, 0);
  lightFalloff(0, 1, 0);
  lightSpecular(0, 0, 0);

  randomSeed(seed);
  noiseSeed(seed);
  background(back);

  float fov = PI/random(1.4, 1.9);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);


  translate(width*0.5, height*0.5, 500);
  rotateX(random(-0.1, 0.1));
  rotateY(random(-0.1, 0.1));
  rotateZ(random(-0.1, 0.1));

  int c = int(random(18, 45));
  float sc = random(4);
  float sw = width*sc*1./c;
  float sh = height*sc*1./c;
  for (int i = 0; i < c; i++) {
    line(-width*sc*0.5, i*sh-height*sc*0.5, +width*sc*0.5, i*sh-height*sc*0.5);
    line(i*sw-width*sc*0.5, -height*sc*0.5, i*sw-width*sc*0.5, +height*sc*0.5);
  }


  for (int j = 0; j < 12; j++) {
    int cc = int(random(38, 90)*4);
    float size = width*0.3*random(2);
    float da = TAU/cc;
    float ic = random(1);
    float dc = (1./cc)*int(random(1, random(4, 30)));

    float ampAngX = random(1.2);
    float iteAngX = int(random(1, 4));
    float ampAngY = random(1.8);
    float iteAngY = int(random(1, 5));

    float iteScl = int(random(1, 5));

    float w = random(30, 60)*0.6;
    float h = random(2, 5)*0.125;
    float d = random(20, 60)*0.6;
    float sca = random(1, 40);
    
    float des = random(-400, 200);

    stroke(0, 60);
    noStroke();
    for (int i = 0; i < cc; i++) {
      float val = map(i, 0, cc, 0, 1);
      fill(getColor(ic+dc*i));
      pushMatrix();
      translate(cos(da*i)*size, sin(da*i)*size, des);
      rotateZ(da*i);
      rotateX(ampAngX*cos(val*iteAngX*TAU));
      rotateY(ampAngY*cos(val*iteAngY*TAU));
      float ss = sca*cos(val*iteScl*TAU)*0.2+0.8;
      box(w*ss, h*ss, d*ss);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#E6E7E9, #F0CA4B, #F07148, #EECCCB, #2474AF, #107F40, #231F20};
//int colors[] = {#2B00BE, #2B00BE, #F73859, #9896F1, #D59BF6, #EDB1F0};
int colors[] = {#012698, #51267F, #BA1E76, #FD3251, #FE9D60, #EDB1F0, #FAD0F4, #A39DC9};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
