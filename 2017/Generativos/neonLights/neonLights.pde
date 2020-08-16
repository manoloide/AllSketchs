int seed = int(random(999999));

void setup() {
  size(920, 920);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  /*
  randomSeed(seed);
   stroke(255, 3);
   drawWave(20, 20, width-40, height-40, random(1)*random(1), random(1));
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);
  seed = int(random(999999));
  randomSeed(seed);

  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < 1; i++) {
    float x = width/2;// random(width);
    float y = height/2;//random(height);
    float s = random(width*0.5, width); //500
    float dir = random(TWO_PI);//atan2(y-height*0.5, x-height*0.5);//PI*1.5;
    float rot = random(TWO_PI);
    float vel = random(1.0)*random(0.2, 1);
    float ms = random(0.986, 0.999);
    float mr = random(-0.02, 0.02);
    float wave = random(10);
    float freq = random(10);
    float mw = random(-0.1, 0.1)*random(1);
    float mf = random(-0.1, 0.1)*random(1.2)*random(1);
    float mdr = random(0.02);
    int form = int(random(2));

    /*
    if (random(1) < 0.1) {
     dir = 0; 
     rot = PI*0.25;
     mdr = 0;
     mr = 0;
     form = 0;
     ms = random(0.99, 0.999);
     s *= 0.1;
     }
     */
    while (s > 0.5) {
      x += cos(dir)*vel;
      y += sin(dir)*vel;
      s *= ms;
      rot += mr;
      dir += random(-mdr, mdr);
      wave += mw;
      freq += mf;
      pushMatrix();
      translate(x, y);
      rotate(rot);
      fill(getColor(waveShape(wave, freq)*colors.length+4), 120);
      if (form == 0) rect(0, 0, s, s);
      else ellipse(0, 0, s, s);
      popMatrix();
    }
  }
}

void drawWave(float x, float y, float w, float h, float vel, float dd) {
  noFill();
  beginShape();
  float wave = (millis()/1000.0)*vel;
  float des = wave*dd;
  for (float i = x; i <= x+w; i++) {
    float xx = i;
    float yy = y+(1-waveShape(wave, map(i, x, x+w, 0, 1)+des))*h;
    vertex(xx, yy);
  }
  endShape();
}

float waveShape(float wave, float freq) {
  if (freq < 0) freq = 1-abs(freq);
  wave = abs(wave);
  int form = int(wave%4);
  float mix = wave%1.0;
  float aux = 0;
  if (form == 0) {
    float sine = sin(freq*TWO_PI)*0.5+0.5;
    float quad = floor((freq+0.5)%1*2.0);
    aux = lerp(sine, quad, mix);
  }
  if (form == 1) {
    float quad = floor((freq+0.5)%1*2.0);
    float tri = abs(1-((freq+0.75)%1.0)*2.0);
    aux = lerp(quad, tri, mix);
  }
  if (form == 2) {
    float tri = abs(1-((freq+0.75)%1.0)*2.0);
    float saw = (freq+0.5)%1.0;
    aux = lerp(tri, saw, mix);
  }
  if (form == 3) {
    float saw = (freq+0.5)%1.0;
    float sine = sin(freq*TWO_PI)*0.5+0.5;
    aux = lerp(saw, sine, mix);
  }
  return aux;
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#000000, #FFFFFF, #FF7700, #000000, #15FF4A, #000000, #000000, #BBBBFF};

int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}