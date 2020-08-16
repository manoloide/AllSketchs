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

  background(0);
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

  randomSeed(seed);
  noiseSeed(seed);

  background(240);

  rectMode(CENTER);
  noStroke();
  for (int i = 0; i < 400; i++) {
    float x = random(-200, width+230); 
    float y = random(-200, height+230);
    float s = 5;

    x -= x%30;
    y -= y%30;

    if (random(1) < 0.2) {
      fill(250);
      rect(x, y, s*5, s*5);
    }

    fill(220);
    rect(x, y, s, s);
    fill(240);
    rect(x, y, s*0.2, s*0.2);
  }

  ArrayList<PVector> points = new ArrayList<PVector>();


  noStroke();
  fill(0, 50);
  for (int i = 0; i < 60; i++) {
    float x = random(-0.8, 0.8)*random(1.4)*(width*0.5+30)+width*0.5;
    float y = random(-0.8, 0.8)*random(1.4)*(height*0.5+30)+height*0.5;
    float s = width*random(0.08, 0.1)*0.8;

    x -= x%30;
    y -= y%30;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      float dis = dist(x, y, p.x, p.y);
      if (dis < 2) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y));

    s *= 1+int(random(0, 10)*random(1)*random(0.7, 1));

    int col = rcol((random(1) < 0.0)? colors1 : colors2);

    if (random(1) < 0.6) {
      fill(col, 240);
      ellipse(x, y, s, s);

      arc2(x, y, s, s*0.4, 0, TAU, rcol(colors2), 20, 0);
      arc2(x, y, s, s*1.6, 0, TAU, 0, 22, 0);
    }


    float ang = random(TAU);
    float des = s*random(0.1)*random(1);
    float dx = cos(ang)*des;
    float dy = cos(ang)*des;
    arc2(x+dx, y+dy, s*0.0, s*0.6, 0, TAU, 0, 60, 0); 
    fill(rcol(colors2));
    ellipse(x, y, s*0.4, s*0.4); 
    arc2(x, y, s*0.4, s*0.4*0.4, 0, TAU, rcol(colors2), 20, 0);


    fill(0, 200);
    ellipse(x, y, s*0.1, s*0.1);
    fill(255);
    ellipse(x, y, s*0.02, s*0.02);
  }

  ArrayList triangles = Triangulate.triangulate(points);

  stroke(0, 14);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle) triangles.get(i);
    fill(255, random(60)*random(1));
    vertex(t.p1.x, t.p1.y);
    fill(255, random(60)*random(1));
    vertex(t.p2.x, t.p2.y);
    fill(255, random(60)*random(1));
    vertex(t.p3.x, t.p3.y);
  }
  endShape(CLOSE);



  float det1 = random(0.001)*10;
  float des1 = random(10000);
  float det2 = random(0.001)*10;
  float des2 = random(10000);

  for (int i = 0; i < 10; i++) {
    PVector p1 = points.get(int(random(points.size()))).copy();
    PVector p2 = points.get(int(random(points.size()))).copy();


    int c1 = rcol(colors2);//lerpColor(rcol(colors2), color(0), random(0.1));
    int c2 = rcol(colors2);//lerpColor(rcol(colors2), color(0), random(0.1));
    int cc = int(random(80, 200)*random(0.5, 1)*3);

    float vel = random(1, 4)*random(0.5, 1);
    //vel = 2;
    float alp = random(60, 220);

    alp = 200;


    for (int j = 0; j < cc; j++) {
      float ang1 = noise(des1+p1.x*det1, des1+p1.y*det1)*PI*2;
      float ang2 = noise(des2+p2.x*det2, des2+p2.y*det2)*PI*2;

      /*
        beginShape(LINES);
       stroke(c1, map(j, 0, cc, alp, 0));
       vertex(p1.x, p1.y);
       stroke(c2, map(j, 0, cc, alp, 0));
       vertex(p2.x, p2.y);
       line(p1.x, p1.y, p2.x, p2.y);
       endShape();
       */

      stroke(c1, map(j, 0, cc, alp, 0));
      line(p1.x, p1.y, p2.x, p2.y);

      p1.x += cos(ang1)*vel;
      p1.y += sin(ang1)*vel;
      p2.x += cos(ang2)*vel;
      p2.y += sin(ang2)*vel;
    }
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*pow(max(s1, s2)*0.2, 2));
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);

    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
    endShape();
  }
}



//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
//int colors1[] = {#02142A, #063449, #18BEAD, #CFFDDA};
int colors1[] = {#0D0A18, #192E24, #5C8B55, #BCCEA8, #FFEE00};

//int colors1[] = {#000000, #000000, #000000};
//int colors2[] = {#FCF2C9, #FFD79C, #F98847};
int colors2[] = {#F76AE2, #F4251A, #EAEAEA, #1BC6C1, #1D38AF, #FFCC00};
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length), colors);
}
int getColor(float v, int colors[]) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
