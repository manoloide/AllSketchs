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

  stroke(0);
  noFill();


  strokeWeight(1);

  /*
  int div = 32;
   stroke(0, 30);
   float ss = width*(1./div);
   for (int j = 0; j < div; j++) {
   for (int i = 0; i < div; i++) {
   rect(i*ss, j*ss, ss, ss);
   }
   }
   
   div = 64;
   ss = width*(1./div);
   for (int j = 0; j < div; j++) {
   for (int i = 0; i < div; i++) {
   rect(i*ss, j*ss, ss, ss);
   }
   }
   */

  /*
  noStroke();
   fill(0);
   for (int j = 0; j < div; j++) {
   for (int i = 0; i < div; i++) {
   float amp = (((i+j)*.5)/div);
   float amp2 = 1-amp*0.4;
   rect((i+amp*0.2)*ss, (j+amp*0.2)*ss, ss*amp2, ss*amp2, ss*amp);
   }
   }
   */

  noFill();


  strokeWeight(2.5);
  stroke(0, 180);

  for (int i = 0; i < 96; i+=2) {
    float ss = map(i, 0, 64, 0, width);
    ellipse(width*0.5, height*0.5, ss, ss);
  }


  int div = 8;
  float ss = width*(1./div);
  float dd = ss/4.;
  for (int j = -1; j < div; j++) {
    for (int i = -1; i < div; i++) {
      //rect(i*ss, j*ss, ss, ss);
      float x = ss*i;
      float y = ss*j;

      line(x, y, x+dd, y+dd);
      line(x+ss, y, x+ss-dd, y+dd);
      line(x+ss, y+ss, x+ss-dd, y+ss-dd);
      line(x, y+ss, x+dd, y+ss-dd);

      line(x, y, x+dd, y);
      line(x, y, x, y+dd);

      line(x+ss, y+ss, x+ss-dd, y+ss);
      line(x+ss, y+ss, x+ss, y+ss-dd);

      line(x, y+dd, x+dd, y+dd*2);
      line(x, y+dd*3, x+dd, y+dd*2);
      line(x+ss, y+dd, x+dd*3, y+dd*2);
      line(x+ss, y+dd*3, x+dd*3, y+dd*2);

      line(x+dd, y, x+dd*2, y+dd);
      line(x+dd*3, y, x+dd*2, y+dd);
      line(x+dd, y+ss, x+dd*2, y+dd*3);
      line(x+dd*3, y+ss, x+dd*2, y+dd*3);

      //fill(getColor(i+j+9));
      rect(x+dd, y+dd, dd*2, dd*2);

      //fill(getColor(i+j+10));
      ellipse(x+dd*2, y+dd*2, dd, dd);

      float mul = ((i+j+1)%2+1)*0.5;
      // fill(getColor(i+j+11));
      ellipse(x+ss, y+dd*2, dd*mul, dd*mul);
      mul = ((i+j+j%2)%2+1)*0.5;
      //fill(getColor(i+j+12));
      ellipse(x+dd*2, y+ss, dd*mul, dd*mul);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #82023B};
int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404};
//int colors[] = {#FFFFFF, #000000};//, #02B59E, #DCE404, #82023B};
//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
