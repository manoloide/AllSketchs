import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

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

void generate() {

  background(0);
  lights();

  int cc = int(random(20, 40));
  float ss = width*1./cc;

  translate(width*0.5, height*0.5);

  noFill();
  fill(255);
  //stroke(255, 200);
  noStroke();
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        if (random(1) < 0.9) continue;
        pushMatrix();
        translate(ss*(i-cc*0.5), ss*(j-cc*0.5), ss*(k-cc*0.5));
        //box(ss*0.9);
        int sub = 8;
        float sss = ss/sub;
        int type = int(random(3));
        fill(rcol());
        boolean invI = random(1) < 0.5;
        boolean invJ = random(1) < 0.5;
        boolean invK = random(1) < 0.5;
        for (int kk = 0; kk < sub; kk++) {
          for (int jj = 0; jj < sub; jj++) {
            for (int ii = 0; ii < sub; ii++) {
              int iii = ii;
              int jjj = jj;
              int kkk = kk;
              if (invI) iii = sub-1-iii;
              if (invJ) jjj = sub-1-jjj;
              if (invK) kkk = sub-1-kkk;
              if (type == 0 && iii != jjj)  continue;
              if (type == 1 && jjj != kkk)  continue;
              if (type == 2 && kkk != iii)  continue;
              pushMatrix();
              translate((iii+0.5)*sss, (jjj+0.5)*sss, (kkk+0.5)*sss);
              box(sss*0.94);
              popMatrix();
            }
          }
        }
        popMatrix();
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#F582DA, #8187F4, #F2F481, #81F498, #81E1F4};
int colors[] = {#E65EC9, #5265E8, #F2F481, #81F498, #52D8E8};
//int colors[] = {#B2354A, #3A48A5, #D69546, #683910, #46BCC9};
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
  return lerpColor(c1, c2, pow(v%1, 0.9));
}
