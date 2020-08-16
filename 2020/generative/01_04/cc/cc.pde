import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 477503;//int(random(999999));
float nwidth =  960;//3000//5600/2;//1400; 
float nheight = 960;//3000//4000/2;//1000;
float swidth = 960; 
float sheight = 960; //1400
float scale = 1;

boolean export = true;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  pixelDensity(2);
  smooth(2);
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
  
  //println(seed);

  randomSeed(seed);
  noiseSeed(seed);
 

  scale(scale);
  back();  
  
}

void saveImage() {
  String timestamp = timestamp();
  //saveFrame(timestamp+"-"+seed+".png");
  saveFrame(timestamp+"-"+seed+".png");
}

String timestamp() {
  return year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
}
//int colors[] = {#0F1540, #EF3422, #E997E4, #F2F2F2, #FFF43B};
//int colors[] = {#0F1540, #F71DDB, #E997E4, #F2F2F2, #E3CA00};
//int colors[] = {#F9F2E3, #E5E5E5, #EADCE0};
int colors[] = {#080F1C, #3B2887, #EFDF51, #D7AAE0, #6EA8BF};
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
  return lerpColor(c1, c2, pow(v%1, 6));
}
