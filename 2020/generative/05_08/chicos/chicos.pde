//import org.processing.wiki.triangulate.*;
//import toxi.math.noise.SimplexNoise;

int seed = 169671;//int(random(999999));

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

float detCol, desCol;
void generate() {

  //hint(DISABLE_DEPTH_TEST);
  strokeCap(SQUARE);


  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());

  noStroke();
  fill(255);
  beginShape(TRIANGLES);
  int sub = int(random(60, 100)*2);
  float ar = random(0.25, 0.5);
  float rad = width*sqrt(2)*0.5;
  float cx = width*0.5;
  float cy = height*0.5;
  float da = TAU/sub;
  for (int i = 0; i < sub; i++) {
    float a1 = i*da; 
    float a2 = a1+da*ar;
    vertex(cx, cy);
    vertex(cx+cos(a1)*rad, cy+sin(a1)*rad);
    vertex(cx+cos(a2)*rad, cy+sin(a2)*rad);
  }
  endShape();

  float dc = 0.02;//random(2);


  for (int k = 0; k < 30; k++) {
    float x = width*random(-0.1, 0.1);
    float y = height*((30-k)*random(0.01, 0.015)-0.6)*0.8;

    x -= x%64;
    y -= y%64;

    float amp = k*0.0125;
    float ic = random(colors.length);
    int cc = int(random(7, 16));
    for (int j = 0; j < cc; j++) {
      fill(lerpColor(rcol(), color(255), 0.5), 180);
      int col = color(255);//getColor(ic+random(2)*random(1));
      if (random(1) < 0.95) col = color(0);
      beginShape();
      for (int i = 0; i < 5; i++) {
        float xx = x+random(0.2+amp, 0.8-amp)*width;
        float yy = y+random(0.2+amp, 0.8-amp)*height;
        int grid = (random(1) < 0.5)? (random(1) < 0.5)? 20 : 60 : 30;
        xx -= xx%grid;
        yy -= yy%grid;
        fill(col);
        curveVertex(xx, yy);
      }
      endShape();
    }
  }


  noStroke();
  for (int k = 0; k < 40; k++) {
    float x = width*random(-0.15, 0.15);
    float y = height*((40-k)*random(0.01, 0.015)*2-0.8)*0.8;

    x -= x%64;
    y -= y%64;

    float amp = k*0.015;
    float ic = random(colors.length);
    int cc = int(random(2, random(10, 30)));
    for (int j = 0; j < cc; j++) {
      fill(rcol(), 180);
      beginShape();
      for (int i = 0; i < 5; i++) {
        float xx = x+random(0.1+amp, 0.9-amp)*width;
        float yy = y+random(0.1+amp, 0.9-amp)*height;
        int grid = (random(1) < 0.5)? (random(1) < 0.5)? 20 : 60 : 30;
        xx -= xx%grid;
        yy -= yy%grid;
        fill(getColor(ic+dc*i+random(2)*random(1)));
        curveVertex(xx, yy);
      }
      endShape();
    }
  }

  for (int k = 0; k < 20; k++) {
    float x = width*random(-0.1, 1.1);
    float y = height*random(-0.1, 1.1);///*((400-k)*random(0.01, 0.015)*2-0.8)*0.8;

    x = lerp(x, width*0.5, random(0.7));
    y = lerp(y, height*0.5, random(0.7));

    x -= x%16;
    y -= y%16;

    fill(rcol(), 20);
    ellipse(x, y, 128, 128);

    noStroke();
    fill(rcol(), 50);
    ellipse(x, y, 96, 96);



    float amp = k*0.0015;
    float ic = random(colors.length);
    int cc = int(random(2, random(10, 20)));
    for (int j = 0; j < cc; j++) {
      fill(rcol(), 180);
      beginShape();
      for (int i = 0; i < 5; i++) {
        float xx = x+random(-0.1+amp, 0.1-amp)*width*0.4;
        float yy = y+random(-0.1+amp, 0.1-amp)*height*0.4;
        int grid = (random(1) < 0.5)? (random(1) < 0.5)? 16 : 4 : 8;
        xx -= xx%grid;
        yy -= yy%grid;
        fill(getColor(ic+dc*i+random(2)*random(1)));
        curveVertex(xx, yy);
      }
      endShape();
    }
  }


  PImage render = get();

  render.loadPixels();
  float r, g, b;
  for (int i = 0; i < render.pixels.length; i++) {
    int col = render.pixels[i];
    r = pow(red(col)/255.0, 1.1)*255;
    r = (r+r*0.4)*0.86;
    g = pow(green(col)/255.0, 0.68)*255;
    //g = (g+g)*0.52;
    b = pow(blue(col)/255.0, 0.6)*255;
    b = (b+b*0.6)*0.85;
    col = color(r, g, b);
    render.pixels[i] = col;
    float bri = brightness(col)/256.;
    render.pixels[i] = lerpColor(col, color(random(255*random(1))), pow(bri, 0.8)*0.4);
    render.pixels[i] = lerpColor(col, color(random(255*random(1)*random(0.6, 1))), (1-bri*0.6)*0.5);
    render.pixels[i] = lerpColor(col, color(random(255*random(1))), pow(bri, 1.2)*0.4);
    render.pixels[i] = lerpColor(col, color(random(255*random(1)*random(1))), (1-bri*0.6)*0.35+random(0.15));
  }
  render.updatePixels();


  blendMode(ADD);
  tint(255, 130);
  image(render, 0, 0);
  blendMode(NORMAL);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".jpg");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
int colors[] = {#07001C, #2e0091, #E2A218, #D61406, #FFFFFF};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#A1A7F4, #EA77BA, #EA0071, #F70D04, #301156};
//int colors[] = {#FE829C, #6AFFB8, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#FE829C, #000000, #BB6633, #3B382B, #DF9BFB};
//int colors[] = {#F7DA36, #A51515, #2B1F19, #1B44C1};//, #6BEFA4};
//int colors[] = {#edbc1c, #941313, #2B1F19, #1B44C1};//, #6BEFA4};
//int colors[] = {#FFDF2B, #B20E0E, #38251C, #1A4CAF, #1E6028};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
//int colors[] = {#EA2E73, #F7AA06, #1577D8};
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
  return lerpColor(c1, c2, pow(v%1, 0.8));
}
