void setup() {
  size(960, 960);
  smooth(8);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
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
  background(20);

  int cc = int(random(8, 40));
  float ss = width*1./(cc+1);
  float dd = ss*random(0.1, 0.2);
  float size = dd*random(0.2, 1);
  strokeWeight(1);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x = (i+0.5)*ss;
      float y = (j+0.5)*ss;
      //rect(x, y, ss, ss);
      stroke(255, 40);
      line(x+dd, y, x+ss-dd, y);
      if (j == cc-1) line(x+dd, y+ss, x+ss-dd, y+ss);
      line(x, y+dd, x, y+ss-dd);
      if (i == cc-1) line(x+ss, y+dd, x+ss, y+ss-dd);

      noStroke();
      fill(200);
      if (i == cc-1) rectt(x+ss, y, size);
      if (j == cc-1) rectt(x, y+ss, size);
      if (i == cc-1 && j == cc-1) rectt(x+ss, y+ss, size); 
      rectt(x, y, size);
    }
  }


  for (int i = 0; i < 10; i++) {
    int x = int(cc*random(0.2, 0.8));
    int y = int(cc*random(0.2, 0.8));
    int mm = int(random(1, 10));
    stroke(rcol(), 200);
    for (int j = 0; j < mm; j++) {
      int nx = constrain(x+int(random(-3, 3)), 0, cc);
      int ny = constrain(y+int(random(-3, 3)), 0, cc);
      line((x+0.5)*ss, (y+0.5)*ss, (nx+0.5)*ss, (ny+0.5)*ss);
      x = nx;
      y = ny;
    }
  }

  /*
  for (int i = 0; i < cc*5; i++) {
   float x = (0.5+int(random(cc)))*ss;
   float y = (0.5+int(random(cc)))*ss;
   int sub = int(random(1, 20));
   float sss = ss/sub;
   float s2 = random(0.8);
   float d = sss*random(1)*(1-s2);
   for (int j = 0; j < sub; j++) {
   rect(x, y+j*sss+d, ss, sss*s2);
   }
   }
   */
  /*
  for (int i = 0; i < cc*3; i++) {
   int cs = int(random(0, 6));
   if (cs == 0) cs = 1;
   float x = ss*(1+int(random(cs/2, cc-cs/2)));
   float y = ss*(1+int(random(cs/2, cc-cs/2))); 
   float s = ss*cs;
   if (s == 0) s = ss;
   noFill();
   stroke(255, random(180, 200));
   fill(255, random(-60, 20));
   strokeWeight(random(0.5, 3));
   if (random(1) < 0.1) {
   ellipse(x, y, s, s);
   ellipse(width-x, y, s, s);
   //ellipse(width-x, height-y, s, s);
   //ellipse(x, height-y, s, s);
   } else {
   rectt(x, y, s);
   rectt(width-x, y, s);
   //rectt(width-x, height-y, s);
   //rectt(x, height-y, s);
   }
   }
   */
}

void rectt(float x, float y, float s) {
  float r = s*0.5; 
  beginShape();
  vertex(x-r, y);
  vertex(x, y-r);
  vertex(x+r, y);
  vertex(x, y+r);
  endShape(CLOSE);
}

int colors[] = {#f6dbc1, #009aaf, #ff799f, #ff1d39, #f6c350, #8f498d};

int rcol() {
  return colors[int(random(colors.length))];
}