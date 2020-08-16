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

void draw() {
  if (frameCount%360 == 0) generate();
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
  rectMode(CENTER);

  float desBor = random(10000);
  float detBor = random(0.001);

  float grid = 60*pow(2, int(random(6)));
  grid = 60;
  float dx = grid*random(-1, 1);
  float dy = grid*random(-1, 1);

  dx = dy = 8;

  noStroke();
  for (int i = 0; i < 600; i++) {
    float xx = random(width+grid); 
    float yy = random(height+grid);

    float s = grid*int(pow(2, int(random(5))));

    xx -= xx%(grid*0.5);
    yy -= yy%(grid*0.5);

    float noi = (float) SimplexNoise.noise(desBor+xx*detBor, desBor+yy*detBor);
    float ss = s-2*int(noi*10);
    pushMatrix();
    if (random(1) < 0.4) translate(dx, dy);

    fill(0, 40); 
    rect(xx+dx, yy+dy, ss, ss);

    if (random(1) < 0.2) { 
      int col = rcol();
      beginShape();
      float ang = PI*((random(1) < 0.5)? 0.75 : 1.75);
      if (random(1) < 0.5) {
        fill(col, 50);
        vertex(xx, yy);
        vertex(xx+s, yy+s);
        fill(col, 0);
        vertex(xx+s+cos(ang)*s*5, yy+s+sin(ang)*s*5);
        vertex(xx+cos(ang)*s*5, yy+sin(ang)*s*5);
      } else {
        ang += HALF_PI;
        fill(col, 50);
        vertex(xx+s, yy);
        vertex(xx, yy+s);
        fill(col, 0);
        vertex(xx+cos(ang)*s*5, yy+s+sin(ang)*s*5);
        vertex(xx+s+cos(ang)*s*5, yy+sin(ang)*s*5);
      }
      endShape(CLOSE);
    }

    if (random(1) < 0.4) {
      fill(rcol());
      rect(xx, yy, ss, ss);
    } else {
      beginShape();
      fill(rcol(), random(120, 255));
      vertex(xx, yy);
      vertex(xx+s, yy);
      fill(rcol(), random(120, 255));
      vertex(xx+s, yy+s);
      vertex(xx, yy+s);
      endShape();
    }


    noStroke();
    fill(rcol(), 250);
    ellipse(xx, yy, ss*0.1, ss*0.1);

    popMatrix();
  }

  grid = 30; 
  for (int i = 0; i < 20; i++) {
    float x = random(width+grid); 
    float y = random(height+grid); 
    float ss = (grid*0.5)*int(random(1, 5));

    x -= x%ss;
    y -= y%ss;

    if (random(1) < 0.2) {
      x += dx; 
      y += dy;
    }

    noStroke(); 
    if (random(1) < 0.04) {
      fill(rcol(), 40); 
      rect(x, y, ss, ss);
    }

    float s = random(24)*pow(random(0.2, 1), 1.2);
    fill(rcol()); 
    rect(x, y, s, s);

    if (random(1) < 0.1) {
      stroke(rcol(), 240);
      noFill();
      rect(x, y, ss*4, ss*4);
      noStroke();
      fill(rcol(), 40);
      rect(x, y, ss*4-5, ss*4-5);
      fill(rcol());
      ellipse(x, y, ss*0.5, ss*0.5);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
int colors[] = {#FEFDFD, #ffa6c5, #FC818F, #A8BAFC, #6398FE, #2656D8, #021D86, #1F1D3E};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
