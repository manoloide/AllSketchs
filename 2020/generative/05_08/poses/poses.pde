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
  size(int(swidth*scale), int(sheight*scale), P2D);
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

  generate();
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(255);

  noStroke();
  float ss = width*0.1;
  for (int i = 0; i < 20; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%32;
    yy -= yy%32;
    noStroke();
    fill(rcol(), 50);
    ellipse(xx, yy, ss, ss);

    strokeWeight(random(1, 4));
    stroke(0);
    float ang1 = PI+random(PI);
    ang1 = lerp(ang1, PI*1.5, random(1));
    float hdx1 = xx+cos(ang1)*ss*0.32;
    float hdy1 = yy+sin(ang1)*ss*0.32;
    float bx1 = xx+cos(ang1)*ss*0.18;
    float by1 = yy+sin(ang1)*ss*0.18;
    float bx2 = xx+cos(ang1+PI)*ss*0.18;
    float by2 = yy+sin(ang1+PI)*ss*0.18;
    line(hdx1, hdy1, bx2, by2);

    float ang2 = ang1+random(-HALF_PI, HALF_PI);
    float amp1 = 0.1*random(1, 2);
    float hx1 = bx1+cos(ang2)*ss*amp1;
    float hy1 = by1+sin(ang2)*ss*amp1;
    float hx2 = bx1+cos(ang2+PI)*ss*amp1;
    float hy2 = by1+sin(ang2+PI)*ss*amp1;
    line(hx1, hy1, hx2, hy2);

    float amp3 = amp1*random(1.4, 2.6);
    float ang4 = random(TAU);
    float codo1x = hx1+cos(ang4)*ss*amp3;
    float codo1y = hy1+sin(ang4)*ss*amp3;
    line(hx1, hy1, codo1x, codo1y);

    float ang6 = random(TAU);
    float mano1x = codo1x+cos(ang6)*ss*amp3;
    float mano1y = codo1y+sin(ang6)*ss*amp3;
    line(codo1x, codo1y, mano1x, mano1y);


    float ang5 = random(TAU);
    float codo2x = hx2+cos(ang5)*ss*amp3;
    float codo2y = hy2+sin(ang5)*ss*amp3;
    line(hx2, hy2, codo2x, codo2y);


    float ang7 = random(TAU);
    float mano2x = codo2x+cos(ang7)*ss*amp3;
    float mano2y = codo2y+sin(ang7)*ss*amp3;
    line(codo2x, codo2y, mano2x, mano2y);


    float ang3 = ang1+random(-HALF_PI, HALF_PI);
    float amp2 = 0.07*random(1, 2);
    float cx1 = bx2+cos(ang3)*ss*amp2;
    float cy1 = by2+sin(ang3)*ss*amp2;
    float cx2 = bx2+cos(ang3+PI)*ss*amp2;
    float cy2 = by2+sin(ang3+PI)*ss*amp2;
    line(cx1, cy1, cx2, cy2);

    float amp8 = amp2*random(1.4, 2.6)*1.8;
    float ang8 = random(TAU);
    float rodilla1x = cx1+cos(ang8)*ss*amp8;
    float rodilla1y = cy1+sin(ang8)*ss*amp8;
    line(cx1, cy1, rodilla1x, rodilla1y);

    float ang9 = random(TAU);
    float pie1x = rodilla1x+cos(ang9)*ss*amp8;
    float pie1y = rodilla1y+sin(ang9)*ss*amp8;
    line(rodilla1x, rodilla1y, pie1x, pie1y);
    
    
    float ang10 = random(TAU);
    float rodilla2x = cx2+cos(ang10)*ss*amp8;
    float rodilla2y = cy2+sin(ang10)*ss*amp8;
    line(cx2, cy2, rodilla2x, rodilla2y);

    float ang11 = random(TAU);
    float pie2x = rodilla2x+cos(ang11)*ss*amp8;
    float pie2y = rodilla2y+sin(ang11)*ss*amp8;
    line(rodilla2x, rodilla2y, pie2x, pie2y);
    
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#DD1616, #72522A, #EDF4F9, #EA9FB6, #202DA3};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
