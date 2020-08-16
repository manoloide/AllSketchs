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

  randomSeed(seed);
  noiseSeed(seed);

  background(rcol());
  //background(220);

  noStroke();
  int cc = int(random(6, 12));
  float ss = width*1./(cc);

  rectMode(CENTER);


  //for (int j = -1; j <= cc; j++) {
  //for (int i = -1; i <= cc; i++) {
  for (int i = 0; i < cc*cc*2; i++) {
    float xx = ss*(int(random(1, cc*1-1))+0.5); 
    float yy = ss*(int(random(1, cc*1-1))+0.5); 
    fill(rcol());
    //rect(xx, yy, ss, ss);
    fill(rcol());
    //ellipse(xx, yy, ss, ss);


    if (random(1) < 0.4) {
      int dir = int(random(4));
      float ang = dir*HALF_PI;
      fill(rcol());

      float dx = 0;
      float dy = 0;

      if (dir == 0) {
        dx = -ss*0.5;
        dy = -ss*0.5;
      }
      if (dir == 1) {
        dx = +ss*0.5;
        dy = -ss*0.5;
      }
      if (dir == 2) {
        dx = +ss*0.5;
        dy = +ss*0.5;
      }
      if (dir == 3) {
        dx = -ss*0.5;
        dy = +ss*0.5;
      }
      arc(xx+dx, yy+dy, ss*2, ss*2, ang, ang+HALF_PI);
      arc2(xx+dx, yy+dy, ss*0, ss*2, ang, ang+HALF_PI, rcol(), 120, 0);

      arc2(xx+dx, yy+dy, ss*2, ss*4, ang, ang+HALF_PI, rcol(), 120, 0);
    }

    fill(rcol());
    //ellipse(xx, yy, ss*0.05, ss*0.05);


    if (random(1) < 0.5) {
      fill(rcol());
      float ddx = int(random(-2, 2))*ss*0.5;
      float ddy = int(random(-2, 2))*ss*0.5;
      if (random(1) < 0.05) {
        fill(rcol());
        int c = int(random(4));
        arc(xx, yy, ss*2, ss*2, HALF_PI*c, HALF_PI*(c+1));
        arc2(xx, yy, ss*2, ss*4, HALF_PI*c, HALF_PI*(c+1), rcol(), 50, 0);
      }
      if (random(1) < 0.1) {
        ellipse(xx+ddx, yy+ddy, ss, ss);
        fill(rcol()); 
        arc2(xx+ddx, yy+ddy, ss, ss*2, 0, TAU, rcol(), 50, 0);
      }
      ellipse(xx, yy, ss*0.2, ss*0.2);
      /*
      if (random(1) < 0.1) {
       fill(rcol());
       ellipse(xx, yy, ss*2, ss*2);
       arc2(xx+ddx, yy+ddy, ss*2, ss*4, 0, TAU, rcol(), 60, 0);
       }
       */
    }
  }
}




void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(2, PI*max(s1, s2)*0.1);
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
