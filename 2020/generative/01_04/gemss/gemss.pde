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

  /*
  if (export) {
   saveImage();
   exit();
   }
   */
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
  randomSeed(seed);
  noiseSeed(seed);
  background(0);

  blendMode(ADD);

  ortho(-width/2, width/2, -height/2, height/2); // Same as ortho()
  translate(width/2, height/2, 0);
  rotateX(-PI/6);
  rotateY(PI/3);
  float size = 600;
  int cc = 100;
  float ss = size/cc;
  float dd = ss*(-0.5+cc*0.5);
  float det = random(0.0016, 0.002)*random(1);
  float des = random(1000);
  noStroke();
  float dc = random(4);
  float detCol = random(0.001);
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        int tot = i+j+k;
        //if ((tot%16 == 0)) continue;
        //if ((tot%64 == 0)) continue;
        float x = -dd+i*ss;
        float y = -dd+j*ss;
        float z = -dd+k*ss;
        float noi = (float) SimplexNoise.noise(des+x*det, y*det, z*det);
        noi = constrain(pow(noi, 1.2)*5.2-0.6, 0, 1);
        if (noi <= 0) continue;
        float desCol = noise(x*detCol, y*detCol, z*detCol);
        pushMatrix();
        translate(x, y, z);
        fill(getColor(noi*3+dc+desCol*15), random(16, 19));
        box(ss*noi);
        popMatrix();
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #0c1cad};
//int colors[] = {#04EDC2, #FFED93, #F9F9F9, #000000, #062FAA};
//int colors[] = {#ED4715, #FFA3EC, #B0A8FF, #0D110F, #FFB951};
int colors[] = {#8A8DE2, #F9C827, #F2DEE4, #0A1835};
//int colors[] = {#00FF6F, #FF002C, #FFE74A, #ff6eec};
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
