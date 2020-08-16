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

ArrayList<PVector> points;

void draw() {

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(0, 20);
    //ellipse(p.x, p.y, 20, 20);
  }
  
  rectMode(CENTER);
  noFill();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    p.z += 0.008;
    p.z *= 1.003;
    stroke(getColor(frameCount*0.2), random(120));
    rect(p.x, p.y, p.z, p.z);
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  background(190);

  points = new ArrayList<PVector>();

  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);

    fill(0);
    ellipse(x, y, 20, 20);

    points.add(new PVector(x, y, 2));
  }

  /*
  rectMode(CENTER);
   ArrayList<PVector> rects = new ArrayList<PVector>();
   for(int i = 0; i < 500; i++){
   float x = random(width);
   float y = random(height);
   float s = 16*int(random(1, 14*random(0.2, random(0.4, 1))));
   x -= x%s;
   y -= y%s;
   beginShape();
   fill(getColor(x+y), random(120, 250));
   vertex(x-s*0.5, y-s*0.5);
   vertex(x+s*0.5, y-s*0.5);
   fill(getColor(x+y+random(1)), random(20, 250));
   vertex(x+s*0.5, y+s*0.5);
   vertex(x-s*0.5, y+s*0.5);
   endShape(CLOSE);
   
   fill(rcol());
   ellipse(x, y, s*0.2, s*0.2);
   //rect(x, y, s, s);
   }
   */
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
int colors[] = {#000000, #0E1C00, #6D9100, #D61406, #E2A218};
//int colors[] = {#F6ED70, #EEABC0, #78C5B3, #0090D5, #F7F7F6};
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
  return lerpColor(c1, c2, pow(v%1, 1.8));
}
