void setup() {
  size(960, 960);
  smooth(8);
  rectMode(CENTER);
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
  background(#1E211C);
  blendMode(ADD);
  //blendMode(LIGHTEST); 

  stroke(255, 5);
  for (int i = 0; i <= width; i+=8) {
    line(i, 0, i, height);
    line(0, i, width, i);
  }


  for (int k = 0; k < 1; k++) {
    float det = random(0.01);
    float det2 = random(0.01, 0.1)*random(1);
    float des = random(100);

    int cc = int(random(180, 480));
    for (int j = 0; j <= cc; j++) {
      fill(rcol(), 6);
      stroke(rcol(), 22);
      beginShape();
      for (int i = -2; i <= width+2; i++) {
        float y = noise(i*det+des, j*det2)*(height/2)+map(j, 0, cc, -width, width);
        vertex(i, y);
      }
      vertex(width+2, height);
      vertex(-2, height);
      endShape(CLOSE);
    }
  }
  /*
  {
   float maxR = width*random(0.2, 0.4);
   float minR = maxR*random(0.2, 0.8);
   float det = random(0.2);
   float des = random(100);
   
   int c = int(random(50, 200));
   float da = TWO_PI/c;
   
   int cc = int(random(40, 100));
   for (int j = 0; j < cc; j++) {
   fill(rcol(), 16);
   stroke(rcol(), 32);
   beginShape();
   for (int i = 0; i < 
   c; i++) {
   float a = da*i;
   float r = map(noise(i*det+des, j*det), 0, 1, minR, maxR);
   float x =  width/2+cos(a)*r;
   float y =  height/2+sin(a)*r;
   vertex(x, y);
   }
   endShape(CLOSE);
   }
   }
   */
}


int colors[] = {#A60000, #00A600, #0000A6};

int rcol() {
  return colors[int(random(colors.length))];
}