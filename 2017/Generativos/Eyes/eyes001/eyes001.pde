int seed = int(random(999999));

void setup() {
  size(960, 960);
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
  background(rcol());
  noStroke();
  /*
  float ss = width*random(0.02, 0.1);
   for (int i = 0; i < 100; i++) {
   float x = random(width+ss);
   float y = random(height+ss);
   float s = ss;//random(0.01, 0.2);
   eye(x, y, s);
   }
   */
  /*
  int cw = int(random(1, random(1, 40)));
   int ch = cw*2;
   float ww = width*1./cw;
   float hh = width*1./ch;
   float amp = random(0.3, 0.42);
   for (int j = 0; j < ch; j++) {
   for (int i = 0; i < cw; i++) {
   float x = ww*(i+0.5);
   float y = hh*(j+0.5);
   eye(x, y, ww*amp);
   }
   }
   */

  float x = width/2;
  float y = height/2;
  int cc = int(random(10, 200));
  float mdx = random(0.55, 0.64);
  float mdy = random(0.08, 0.13);
  float ic = random(colors.length);
  float dc = random(10)*random(1);
  float ss = random(50, 260);
  float rot = random(-PI, PI);
  x = 0; 
  y = 0; 

  for (int i = 0; i < cc; i++) {
    float s = map(i, 0, cc, width*1.5, ss);
    float mx = s*mdx;
    float my = s*mdy;
    pushMatrix();
    translate(width/2, height/2);
    rotate(map(i, 0, cc, rot, 0));
    fill(getColor(ic+dc*i));
    beginShape();
    vertex(x-s*1.1, y); // first point
    bezierVertex(x-s*1.1, y-my, x-mx, y-s*0.6, x, y-s*0.6);
    bezierVertex(x+mx, y-s*0.6, x+s*1.1, y-my, x+s*1.1, y);
    vertex(x+s*1.1, y); // first point
    bezierVertex(x+s*1.1, y+my, x+mx, y+s*0.6, x, y+s*0.6);
    bezierVertex(x-mx, y+s*0.6, x-s*1.1, y+my, x-s*1.1, y);
    endShape(CLOSE);
    popMatrix();
  }

  eye(width/2, height/2, ss);
}

void eye(float x, float y, float s) {
  float amp = random(0.5, random(0.5, 0.9));
  fill(#EADBC6);
  //ellipse(x, y, s*3, s*3);

  /*
    beginShape();
   vertex(x-s*1.1, y);
   vertex(x, y-s*0.6);
   vertex(x+s*1.1, y);
   vertex(x, y+s*0.6);
   endShape(CLOSE);
   */

  float mx = s*random(0.55, 0.64);
  float my = s*random(0.08, 0.13);

  beginShape();
  vertex(x-s*1.1, y); // first point
  bezierVertex(x-s*1.1, y-my, x-mx, y-s*0.6, x, y-s*0.6);
  bezierVertex(x+mx, y-s*0.6, x+s*1.1, y-my, x+s*1.1, y);
  vertex(x+s*1.1, y); // first point
  bezierVertex(x+s*1.1, y+my, x+mx, y+s*0.6, x, y+s*0.6);
  bezierVertex(x-mx, y+s*0.6, x-s*1.1, y+my, x-s*1.1, y);
  endShape(CLOSE);

  //ellipse(x, y, s*1.8, s*1.2);
  fill(rcol());
  ellipse(x, y, s, s);
  fill(10);
  ellipse(x, y, s*amp, s*amp);
}

//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
int colors[] = {#0795D0, #019C54, #F5230D, #DF5A48, #F1BF16, #F0C016, #F4850C, #E13E33, #746891, #623E86, #00A2C6, #EBD417};// #EADBC6};

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