import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

  hint(DISABLE_DEPTH_TEST);

  background(0);

  blendMode(ADD);

  for (int i = 0; i < 60; i++) {
    float x = width*random(1);
    float y = height*random(1);
    float z = 20*int(random(5));

    x -= x%20;
    y -= y%20;

    float s = pow(2, int(random(7)))*10;
    float r = s*0.5;

    int col = rcol();

    float a1 = 90;
    float a2 = 10;
    if (random(1) < 0.5) {
      float aux = a1;
      a1 = a2;
      a2 = aux;
    }

    pushMatrix();
    //translate(0, 0, z-100);

    fill(col, random(a2, a1));
    ellipse(x, y, s, s);
    fill(col, random(a2, a1));
    ellipse(x, y, s*0.1, s*0.1);
    /*
    beginShape();
     if (random(1) < 0.5) {
     fill(col, a1);
     vertex(x+r, y-r);
     vertex(x+r, y+r);
     fill(col, a2);
     vertex(x-r, y+r);
     vertex(x-r, y-r);
     } else {
     
     fill(col, a1);
     vertex(x-r, y-r);
     vertex(x+r, y-r);
     fill(col, a2);
     vertex(x+r, y+r);
     vertex(x-r, y+r);
     }
     */
    popMatrix();
    endShape();
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

//int colors[] = {#F71630, #3A6B58, #82B754, #E8DD4C, #CE7B0E};
//int colors[] = {#38684E, #D11D02, #BC9509, #5496A8};
//int colors[] = {#FFDED3, #FCBDCB, #FF7614, #018CC7};
int colors[] = {#BF9F95, #BC848E, #BF4305, #005E87};
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
  return lerpColor(c1, c2, pow(v%1, 3.8));
} 
