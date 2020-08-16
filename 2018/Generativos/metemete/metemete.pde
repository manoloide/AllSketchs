int seed = int(random(999999));
float det, des;

void setup() {
  size(960, 960);
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  background(255);

  pelos();

  int cc = int(random(6, random(12, 40)*random(0.5, 1)));
  float ss = width*1./cc;

  rectMode(CENTER);
  strokeWeight(1);

  float det = random(0.01);
  float des = random(1000);

  float det2 = random(0.01);
  float des2 = random(1000);

  float det3 = random(0.01);
  float des3 = random(1000);


  float det4 = random(0.01);
  float des4 = random(1000);

  noiseDetail(2);

  float pwr = random(1, 5);

  for (int j = -2; j < cc+2; j++) {
    for (int i = -2; i < cc+2; i++) {
      float xx = (i+0.5)*ss;
      float yy = (j+0.5)*ss;




      float sss = ss*(0.1+noise(des2+xx*det2, des+yy*det2)*0.9);

      float s = int(sss*0.5);
      float dd = int(pow(noise(des+xx*det, des+yy*det), pwr)*ss*3);

      noStroke();

      fill(0, 8);
      rect(xx-0.5, yy-0.5, s*1.2, s*1.2);


      noFill();
      stroke(240);
      rect(xx-0.5, yy-0.5, s*1.8, s*1.8);

      if (noise(des3+xx*det3, des3+yy*det3) < 0.2) continue;

      fill(0);
      noStroke();
      beginShape();
      vertex(xx+s*0.5-dd, yy-s*0.5-dd);
      vertex(xx+s*0.5, yy-s*0.5);
      vertex(xx+s*0.5, yy+s*0.5);
      vertex(xx-s*0.5, yy+s*0.5);
      vertex(xx-s*0.5-dd, yy+s*0.5-dd);
      endShape();

      fill(rcol());
      stroke(240, 10);
      rect(xx-dd-0.5, yy-dd-0.5, s, s);
    }
  }


  int ccc = int(cc*random(0.2, 2));
  for (int i = 0; i < ccc; i++) {
    float ww = ss*int(random(1, cc*0.3));
    float hh = ss*int(random(1, cc*0.3));
    float xx = random(-ww, width+ww+ss);
    float yy = random(-hh, width+hh+ss);

    xx -= xx%ss;
    yy -= yy%ss;
    
    
    stroke(0, 4);
    fill(0, 8);
    rect(xx+ww*0.5, yy+hh*0.5, ww, hh);
    
    float s = int(random(4, random(4, 16)));
    int dir = int(random(2));
    
    stroke(rcol(), 80);
    rectLines(xx+3, yy+3, ww-6, hh-6, s, dir, random(1));
    if(random(1) < 0.5) rectLines(xx+3, yy+3, ww-6, hh-6, s, (dir+1)%2, random(1));
  }
}

void pelos() {

  float des01 = random(1000);
  float det01 = random(0.01);
  float des02 = random(1000);
  float det02 = random(0.01);
  float des03 = random(1000);
  float det03 = random(0.01);
  float des04 = random(1000);
  float det04 = random(0.006);
  for (int i = 0; i < 300000; i++) {
    float xx = random(-20, width+20);
    float yy = random(-20, height+20);
    float anc = noise(des03+xx*det03, des03+yy*det03)*2;
    strokeWeight(anc);
    stroke(getColor(int(noise(des04+xx*det04, des04+yy*det04)*colors.length*3)), 60);
    float an = noise(des01+xx*det01, des01+yy*det01)*TAU*2;
    float dd = noise(des02+xx*det02, des02+yy*det02)*anc*40;
    line(xx, yy, xx+cos(an)*dd, yy+sin(an)*dd);
  }
}

void rectLines(float x, float y, float w, float h, float s, int dir, float tt) {
  float des = s*tt;
  //rect(x, y, w, h);
  if (dir == 0) {
    for (float i = des; i < max(w, h); i+=s) {
      float difw = constrain(i-w, 0, h);
      float difh = constrain(i-h, 0, w);
      line(x+i-difw, y+difw, x+difh, y+i-difh);
    }
    for (float i = s-(max(w, h)-des)%s; i < min(w, h); i+=s) {
      float dw = constrain(w-h, 0, h+w);
      float dh = constrain(h-w, 0, h+w);
      line(x+dw+i, y+h, x+w, y+dh+i);
    }
  }
  if (dir == 1) {
    for (float i = des; i < max(w, h); i+=s) {
      float difw = constrain(i-w, 0, h);
      float difh = constrain(i-h, 0, w);
      line(x+w-i+difw, y+difw, x+w-difh, y+i-difh);
    }
    for (float i = s-(max(w, h)-des+s)%s; i < min(w, h); i+=s) {
      float dh = constrain(h-w, 0, h+w);
      float dw = constrain(w-h, 0, h+w);
      line(x+w-dw-i, y+h, x, y+dh+i);
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


int colors[] = {#E80707, #FAD647, #2F8145, #182395};
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
  return lerpColor(c1, c2, v%1);
}