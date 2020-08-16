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
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (keyCode == LEFT) {
    seed--;
    generate();
  } else if (keyCode == RIGHT) {
    seed++;
    generate();
  } else {
    seed = int(random(999999));
    generate();
  }
}



void generate() { 

  println(seed);
  randomSeed(seed);
  scale(scale);


  background(200);



  int sw = int(random(4, 12));
  float ww = width*1./sw;
  int sh = int(random(4, 12));
  float hh = height*1./sh;

  int s1 = int(random(2, 10)*random(0.8, 1));
  int s2 = int(random(2, 10)*random(0.8, 1));
  
  float aw = random(0.2);
  float ah = random(0.9);

  for (int j = -3; j < sh+2; j++) {
    for (int i = -3; i < sw+2; i++) {

      //if ((i+j)%2 < 1) continue;

      float x = (i+0.5)*ww;
      float y = (j+0.5)*hh;

      noStroke();
      
      stroke(0, 20);


      float s = 1; //constrain(noise(des+x*det, des+y*det)*3-0.5, 0.5, 1);
      int ind = abs((i+j+j/2)%4);//+j%2;
      int c1 = lerpColor(getColor(ind), color(0), ((i+j)%2)*0.08);
      int c2 = lerpColor(getColor(ind+2), color(0), ((i+j)%2)*0.08);
      //fill(rcol());
      drawMosaic(x, y, ww*s, hh*s, ((abs(i)%2) >= 1), ((abs(j)%2) >= 1), s1, s2, aw, ah, c1, c2);
    }
  }
}

void drawMosaic(float x, float y, float w, float h, boolean i1, boolean i2, int s1, int s2, float aw, float ah, int c1, int c2) {
  x -= w*0.5;
  y -= h*0.5;

  float dx = w*aw;
  float dy = h*ah;//h*0.5;

  if (i1) {
    float dw = 1;
    if (i2) dw = -1;
    float dh = 1;
    grid(x-dx*dw, y-dy*dh, x+dx*dw, y+h-dy*dh, x+w+dx*dw, y+h+dy*dh, x+w-dx*dw, y+dy*dh, s1, s2, c1, c2);
  } else {
    float dir = +1;
    if (i2) dir = -1;
    float dh = 1;
    grid(x-dx*dir, y+dy*dh, x+w-dx*dir, y-dy*dh, x+w+dx*dir, y+h-dy*dh, x+dx*dir, y+h+dy*dh, s2, s1, c1, c2);
  }

  /*
  beginShape();
   if (inv) {
   vline(x, y, x+dx, y+h, line2, false, true);
   vline(x, y+dy, x+w, y, line1, false, false);
   vline(x+w, y+dy, x+w+dx, y+h+dy, line2, false, false);
   vline(x+w+dx, y+h+dy, x+dx, y+h, line1, true, false);
   } else {
   dx *= -1;
   vline(x+w-dx, y, x-dx, y, line1, true, false);
   vline(x-dx, y, x, y+h, line2, true, false);
   vline(x, y+h, x+w, y+h, line1, false, false);
   vline(x+w-dx, y, x+w, y+h, line2, true, true);
   }
   endShape();
   */
}

void grid(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int subW, int subH, int c1, int c2) {
  
  PVector ps[][] = new PVector[subW+1][subH+1];
  for (int j = 0; j <= subH; j++) {
    float v1 = pow(j*1./subH, 1);
    float nx1 = lerp(x1, x2, v1); 
    float ny1 = lerp(y1, y2, v1); 
    float nx2 = lerp(x4, x3, v1); 
    float ny2 = lerp(y4, y3, v1); 
    for (int i = 0; i <= subW; i++) {
      float v2 = pow(i*1./subW, 1);
      float xx = lerp(nx1, nx2, v2); 
      float yy = lerp(ny1, ny2, v2);
      ps[i][j] = new PVector(xx, yy);
    }
  }
  //noStroke(); 
  for (int j = 0; j < subH; j++) {
    for (int i = 0; i < subW; i++) {
      fill(((i+j)%2 == 0)? c1 : c2);
      beginShape();
      vertex(ps[i][j].x, ps[i][j].y); 
      vertex(ps[i+1][j].x, ps[i+1][j].y); 
      vertex(ps[i+1][j+1].x, ps[i+1][j+1].y); 
      vertex(ps[i][j+1].x, ps[i][j+1].y); 
      endShape(CLOSE);
    }
  }
  
  //quad(x1, y1, x2, y2, x3, y3, x4, y4);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#B0E7FF, #143585, #5ACAA2, #F98FC0, #D08714};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
  return lerpColor(c1, c2, v%1);
}
