import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

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
  //cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

float time;
void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  back();
  
  form();
}


void back() {
  int cc = int(random(120, 180));
  cc /= 10;
  float ss = width*1./cc;
  noStroke();
  float det = random(0.004);
  float osc1 = random(1)*random(1);
  float osc2 = random(0.2)*random(1);
  float pwr1 = random(8, 12);
  float ampNoi = random(10);
  for (int i = 1; i < cc; i+=1) {

    //fill((i%2)*255);
    fill(rcol());
    beginShape(QUAD_STRIP);
    for (int j = 0; j < width; j+=1) {
      float n1 = ((float) SimplexNoise.noise(j*det, i*det)*2-1)*ss*ampNoi;
      float n2 = ((float) SimplexNoise.noise(j*det, i*det)*2-1)*ss*ampNoi;
      //float y1 = i*ss+n1;
      //float y2 = (i+1)*ss+n2;
      float y1 = (cos(i*osc1+j*osc2+n1)*0.5+0.5)*height;
      float y2 = (cos(i*osc1+(j+1)*osc2+n2)*0.5+0.5)*height;
      float v = abs((j*2./width)-1);
      y1 = lerp(y1, height*0.5, pow(v, pwr1));
      y2 = lerp(y2, height*0.5, pow(v, pwr1));
      vertex(j, y1);
      vertex(j, y2);
    }
    endShape();
  }
}

void form() {
  int cc = int(random(120, 180));
  cc = 20;
  //cc /= 50;
  float ss = width*1./cc;
  noStroke();
  float det = random(0.001);
  float osc1 = random(1)*random(1);
  float osc2 = random(0.2)*random(1);
  float pwr1 = random(8, 12);
  float ampNoi = random(10);
  for (int i = 1; i < cc; i+=1) {

    //fill((i%2)*255);
    fill(rcol());
    beginShape(QUAD_STRIP);
    for (int j = 0; j < width; j+=1) {
      float n1 = ((float) SimplexNoise.noise(j*det, i*det)*2-1)*ss*ampNoi;
      float n2 = ((float) SimplexNoise.noise(j*det, i*det)*2-1)*ss*ampNoi;
      //float y1 = i*ss+n1;
      //float y2 = (i+1)*ss+n2;
      float y1 = (cos(i*osc1+j*osc2+n1)*0.5+0.5)*height;
      float y2 = (cos(i*osc1+(j+1)*osc2+n2)*0.5+0.5)*height;
      float v = abs((j*2./width)-1);
      y1 = lerp(y1, height*0.5, pow(1-v, pwr1));
      y2 = lerp(y2, height*0.5, pow(1-v, pwr1));
      vertex(j, y1);
      vertex(j, y2);
    }
    endShape();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
