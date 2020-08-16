import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 58621;//int(random(999999));

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

void generate() {

  blendMode(NORMAL);

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  int cc = int(random(2, 6))*2; 
  float ss = width*1.0/cc;
  int col1 = rcol();
  int col2 = rcol();
  while (col1 == col2) col2 = rcol();
  int col3 = rcol();
  int col4 = rcol();
  while (col3 == col4) col4 = rcol();

  noStroke();
  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      int val = (i+j);
      if (random(1) < 1) {
        //val += int(random(2));
      }
      if ((val+1)%2 == 0) fill(col1);
      if ((val+1)%2 == 1) fill(col2);
      //if ((val+1)%3 == 2) fill(col3);
      rect(xx, yy, ss, ss);

      fill((val%2)*255);
      //ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.8, ss*0.8);

      if ((val+0)%2 == 0) fill(col1);
      if ((val+0)%2 == 1) fill(col2);
      //if ((val+0)%3 == 2) fill(col3);
      //ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.2, ss*0.2);
    }
  }

  noFill();
  rectMode(CENTER);
  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      stroke(0);  
      noStroke();
      int val = (i+j);
      for (int k = 0; k < 9; k++) {
        if ((val+k)%2 == 0) fill(col1);
        if ((val+k)%2 == 1) fill(col2);
        float amp = (9-k)*0.1;
        rect(xx+ss*0.5, yy+ss*0.5, ss*amp, ss*amp);
      }
    }
  }
  rectMode(CORNER);

  noStroke();
  float amp1 = ss*0.3;//random(0.2, 0.5)*random(0.6, 1)*random(0.2, 1);
  float amp2 = ss*0.3;//*random(0.2, 0.5)*random(0.6, 1);
  if (random(1) < 0.5) {
    amp1 = amp2;
  }
  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      int val = (i+j);


      if ((val+0)%2 == 0) fill(col2);
      if ((val+)%2 == 1) fill(col1);
      ellipse(xx+ss*0.5, yy+ss*0.5, ss*0.05, ss*0.05);

      if ((val+2)%2 == 0) fill(col4);
      if ((val+2)%2 == 1) fill(col3);
      beginShape();
      vertex(xx+amp1, yy+amp1);
      vertex(xx, yy+amp2);
      vertex(xx-amp1, yy+amp1);
      vertex(xx, yy);
      endShape(CLOSE);


      beginShape();
      vertex(xx, yy);
      vertex(xx+amp1, yy-amp1);
      vertex(xx, yy-amp2);
      vertex(xx-amp1, yy-amp1);
      endShape(CLOSE);


      if ((val+1)%2 == 0) fill(col4);
      if ((val+1)%2 == 1) fill(col3);
      beginShape();
      vertex(xx, yy);
      vertex(xx+amp1, yy+amp1);
      vertex(xx+amp2, yy);
      vertex(xx+amp1, yy-amp1);
      endShape(CLOSE);


      beginShape();
      vertex(xx, yy);
      vertex(xx-amp1, yy+amp1);
      vertex(xx-amp2, yy);
      vertex(xx-amp1, yy-amp1);
      endShape(CLOSE);
      
      
      if ((val+1)%2 == 0) fill(col2);
      if ((val+1)%2 == 1) fill(col1);
      ellipse(xx, yy, ss*0.25, ss*0.25);
      if ((val+0)%2 == 0) fill(col2);
      if ((val+0)%2 == 1) fill(col1);
      ellipse(xx, yy, ss*0.125, ss*0.125);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
int colors[] = {#000000, #FFFFFF};//, #ED491C, #9B407D, #B48DC0, #E3E8EA};

//int colors[] = {#0A0B0B, #2E361E, #ACB2A4, #B66F3A, #B91A1B};
//int colors[] = {#F7E242, #425CBC, #E885EA};


//int colors[] = {#B85807, #FAC440, #F4C8BF, #A0B9A6, #A1B2EA};
//int colors[] = {#F4C8BF, #A0B9A6, #A1B2EA};

//int colors[] = {#9C0106, #8A8F32, #8277EE, #B58B17, #5F5542};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
