import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

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

  /*
  if (frameCount%120 == 0) {
   seed = int(random(999999));
   generate();
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  //blendMode(ADD);
  randomSeed(seed);
  noiseSeed(seed);
  background(0);

  noStroke();
  int cc = int(random(18, 26));
  float ss = width*1./cc;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(255);
      rect(i*ss+1, j*ss, ss-2, ss-2, 2);
      if (random(1) < 0.1) {
        fill(0);
        ellipse((i+0.5)*ss, (j+0.5)*ss-1, ss*0.25, ss*0.25);
      }
    }
  }

  boolean used[][] = new boolean[cc][cc];

  for (int j = 0; j < 90; j++) {
    ArrayList<PVector> lines = new ArrayList<PVector>();
    int x = int(random(cc));
    int y = int(random(cc));
    int lar = int(random(60)*random(1));
    for (int i = 0; i < lar; i++) {
      for (int k = 0; k < 4; k++) {
        int nx = x;
        int ny = y;
        if (random(1) < 0.5) {
          if (random(1) < 0.5) nx -= 1;
          else nx += 1;
        } else {
          if (random(1) < 0.5) ny -= 1;
          else ny += 1;
        }
        if (nx >= 0 && nx < cc && ny >= 0 && ny < cc && !used[nx][ny]) {
          used[nx][ny] = true;
          x = nx;
          y = ny;
          lines.add(new PVector(x, y));
          break;
        }
      }
    }

    float ns = ss*random(random(random(0.2, 0.5), 0.9), 0.9);

    noFill();
    strokeCap(SQUARE);
    strokeWeight(ns);
    stroke(0, 20);
    beginShape();
    for (int i = 0; i < lines.size(); i++) {
      PVector p = lines.get(i);
      vertex((p.x+0.5)*ss+4, (p.y+0.5)*ss+3);
    }
    endShape();
    stroke(0);
    beginShape();
    for (int i = 0; i < lines.size(); i++) {
      PVector p = lines.get(i);
      vertex((p.x+0.5)*ss, (p.y+0.5)*ss-1);
    }
    endShape();
    stroke(255);
    strokeWeight(ns*0.05);
    beginShape();
    for (int i = 0; i < lines.size(); i++) {
      PVector p = lines.get(i);
      stroke(255);
      if (i == 0 || i == lines.size()-1) 
        stroke(255, 0, 0);
      vertex((p.x+0.5)*ss, (p.y+0.5)*ss-1);
    }
    endShape();

    if (lines.size() < 2) continue;

    PVector p = lines.get(0);
    noStroke();
    fill(255, 0, 0);
    ellipse((p.x+0.5)*ss, (p.y+0.5)*ss-1, ns*0.5, ns*0.5);    
    noFill();
    stroke(255, 0, 0);
    if (random(1) < 0.1) ellipse((p.x+0.5)*ss, (p.y+0.5)*ss-1, ss*2, ss*2);    
    p = lines.get(lines.size()-1);
    noStroke();
    fill(255, 0, 0);
    ellipse((p.x+0.5)*ss, (p.y+0.5)*ss-1, ns*0.5, ns*0.5);
    noFill();
    stroke(255, 0, 0);
    if (random(1) < 0.1) ellipse((p.x+0.5)*ss, (p.y+0.5)*ss-1, ss*2, ss*2);
  }

  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      fill(255*int(random(2)));
      ellipse((i+0.5)*ss, (j+0.5)*ss-1, ss*0.08, ss*0.08);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/f76fc1-ff9129-afe36b-29a8cc-100082

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#F76FC1, #FF7028, #AFE36B, #29a8cc, #100082}; //
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
