int seed = int(random(999999));
import processing.pdf.*;


//18 x 2.5
// 36 x 5
// 360 x 50
//1440, 200


void setup() {
  size(1440, 200);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
}

void keyPressed() {
  if (key == 's') {
    beginRecord(PDF, getTimestamp()+".pdf"); 
    generate();
    endRecord();
  } else {
    seed = int(random(999999));
    generate();
  }
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  background(colors[0]);

  int cw = int(random(70, 210));
  int ch = int(cw/int(random(7, 12)));

  float ww = width*1./cw;
  float hh = height*1./ch;

  noStroke();
  for (int dy = 0; dy <= ch; dy++) {
    for (int dx = 0; dx <= cw; dx++) {
      float xx = dx*ww;
      float yy = dy*hh;
      fill(getColor(random(1, colors.length*0.93)), random(130));
      rombo(xx, yy, ww, hh);
    }
  }

  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    float s = min(width, height)*random(0.2)*random(1);
    int rnd = int(random(2));
    noStroke();
    int col = getColor(random(colors.length*0.93));
    if (rnd == 0) {
      fill(col, 50);
      float amp = pow(random(1, 1.5), random(1, 8));
      ellipse(x, y, s*amp, s*amp);
      amp *= random(1, 1.05);
      ellipse(x, y, s*amp, s*amp);
    }
  }
  /*
      
   */
  /*
    } else {
   fill(col, 80);
   float amp = 0.8;
   rombo(x, y, s*amp, s);
   }
   }
   */

  for (int i = 0; i < 1000; i++) {
    float x = random(width); 
    float y = random(height);
    float s = random(1)*random(1);
    fill(getColor(random(colors.length)), random(200));
    ellipse(x, y, s, s);
  }


  /*
  for (int i = 0; i < 1000; i++) {
   float x = random(width); 
   float y = random(height);
   float s = random(200);
   stroke(getColor(map(y, 0, height, 0, colors.length)));
   line(x-s, y, x+s, y);
   }
   */
}

void rombo(float x, float y, float w, float h) {
  beginShape();
  vertex(x-w*0.5, y);
  vertex(x, y-h*0.5);
  vertex(x+w*0.5, y);
  vertex(x, y+h*0.5);
  endShape();
}


int colors[] = {#513000, #633800, #894D0B, #CE6A0C, #eeaa66};
//#373A89, 
//int colors[] = {#D9146C, #FF1E41, #FC6231, #FD7D44, #FD7A69};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}