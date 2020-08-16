import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = 28910;//int(random(999999));

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
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  //generate();
  noiseSeed(seed);
  randomSeed(seed);

  background(0);

  float detSize = random(0.01)*random(1);
  float detDis = random(0.01);

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 60000; i++) {
    float x = width*random(0.1, 0.9); 
    float y = height*random(0.1, 0.9);
    float s = 1+pow(noise(x*detSize, y*detSize), 2)*5*random(0.8, 1);//random(1, random(1, 5));

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      float ss = (s+other.z)*(0.7+noise(x*detDis, y*detDis)*0.5)*0.8;
      if (abs(x-other.x) < ss && abs(y-other.y) < ss) {
        if (dist(x, y, other.x, other.y) < ss) {
          add = false;
          break;
        }
      }
    }

    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  noStroke();
  fill(#F5E184);

  float detAng = random(0.001);
  beginShape(LINES);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float a = noise(p.x*detAng, p.y*detAng)*TAU*2;
    float a2 = noise(a*0.8, p.x*detAng, p.y*detAng)*TAU*2;
    float dx = cos(a)*3;
    float dy = sin(a)*3;
    float s = p.z;
    float x = p.x+dx+random(-1, 1);
    float y = p.y+dy+random(-1, 1);
    //ellipse(x, y, s, s);
    stroke(getColor(a2+a*0.1+random(1)*random(1)), 120);
    vertex(x, y);
    vertex(x+cos(a2)*s*6, y+sin(a2)*s*6);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#7D7FD8, #F7AA06, #EA79B7, #FF0739, #12315E};
//int colors[] = {#354998, #D0302B, #F76684, #FCFAEF, #FDC400};
//int colors[] = {#F7F5E8, #F1D7D7, #6AA6CB, #3E4884, #E36446, #BBCAB1};
//int colors[] = {#6402F7, #F7A4EF, #F62C64, #00DACA};
//int colors[] = {#2B349E, #F57E15, #ED491C, #9B407D, #B48DC0, #E3E8EA};
//int colors[] = {#0A0B0B, #2E361E, #ACB2A4, #B66F3A, #B91A1B};
int colors[] = {#D7CEA9, #7E845A, #232319, #303B4D, #362D17};
//int colors[] = {#B2734B, #A69050, #897E6A, #5B6066, #292E31};
//int colors[] = {#FCB375, #FEAE02, #FED400, #F0EBBE, #B0DECE, #01B6D2, #18AD92, #90BC96};
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
