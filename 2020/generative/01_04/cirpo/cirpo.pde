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

  background(rcol());

  int cc = int(random(12, 18)*0.3)*2;
  float ss = width*1./(cc);

  float det = random(0.008);

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i)*ss;
      float yy = (j)*ss;
      fill(rcol());
      rect(xx, yy, ss, ss);

      if (random(1) < 0.5) {
        fill(rcol());
        ellipse(xx+ss*0.5, yy+ss*0.5, ss, ss);
      }

      if (random(1) < 0.5) {
        fill(rcol());
        ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.5, ss*0.5);
      }


      float noi = noise(xx*det, yy*det)*8;
      //noi = 0;
      int rnd = int(noi+i%2+j*2)%4;//int(random(4));
      if (random(1) < 0.25) rnd = -1;
      if (rnd == 3) {    
        fill(rcol());
        arc(xx, yy, ss*2, ss*2, 0, HALF_PI);
        fill(rcol());
        arc(xx, yy, ss*1, ss*1, 0, HALF_PI);
        fill(rcol());
        arc(xx, yy, ss*0.5, ss*0.5, 0, HALF_PI);
        fill(rcol());
        arc(xx, yy, ss*0.25, ss*0.25, 0, HALF_PI);
      }
      if (rnd == 2) {
        fill(rcol());
        arc(xx+ss, yy, ss*2, ss*2, HALF_PI, PI);
        fill(rcol());
        arc(xx+ss, yy, ss*1, ss*1, HALF_PI, PI);
        fill(rcol());
        arc(xx+ss, yy, ss*0.5, ss*0.5, HALF_PI, PI);
        fill(rcol());
        arc(xx+ss, yy, ss*0.25, ss*0.25, HALF_PI, PI);
      }
      if (rnd == 1) {
        fill(rcol());
        arc(xx, yy+ss, ss*2, ss*2, PI*1.5, TAU);
        fill(rcol());
        arc(xx, yy+ss, ss*1, ss*1, PI*1.5, TAU);
        fill(rcol());
        arc(xx, yy+ss, ss*0.5, ss*0.5, PI*1.5, TAU);
        fill(rcol());
        arc(xx, yy+ss, ss*0.25, ss*0.25, PI*1.5, TAU);
      }
      if (rnd == 0) {
        fill(rcol());
        arc(xx+ss, yy+ss, ss*2, ss*2, PI, PI*1.5);
        fill(rcol());
        arc(xx+ss, yy+ss, ss*1, ss*1, PI, PI*1.5);
        fill(rcol());
        arc(xx+ss, yy+ss, ss*0.5, ss*0.5, PI, PI*1.5);
        fill(rcol());
        arc(xx+ss, yy+ss, ss*0.25, ss*0.25, PI, PI*1.5);
      }
    }
  }


  for (float j = 0; j <= cc*2; j++) {
    for (float i = 0; i <= cc*2; i++) {
      //for (int k = 0; k < 4; k++) {
      if (random(1) < 0.4) continue;
      float xx = (i)*ss*0.5;
      float yy = (j)*ss*0.5;
      float sca = 1+(i+j+1)%2;
      float s = ss*0.125*sca*0.5;
      //s *= 4-k;
      s *= 2;
      fill(rcol()); 
      ellipse(xx, yy, s, s);

      s *= 0.5;
      fill(rcol()); 
      ellipse(xx, yy, s, s);
    }
    //}
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #82023B};
int colors[] = {#F3B2DB, #518DB2, #02B59E, #DCE404, #000000, #ffffff};
//int colors[] = {#F3B2DB, #518DB2, #02B59E};
//int colors[] = {#F4EFA1, #E8E165, #DC4827, #5779A2, #031A01};
//int colors[] = {#D9BCBC, #CAB4B0, #3E87B2, #1E4F42, #F37C0A};
//int colors[] = {#152425, #1D3740, #06263E, #074B7D, #094D88, #1D6C9E, #ff2000, #1D6C9E, #ff2010};

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
  return lerpColor(c1, c2, pow(v%1, 1.2));
}
