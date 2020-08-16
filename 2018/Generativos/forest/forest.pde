int seed = int(random(999999));
float time;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {

  time = millis()*0.001;

  generate();
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

  sky();



  int ch = 20;
  stroke(0, 200);
  noStroke();
  for (int j = -1; j <= ch; j++) {  
    float ss = width*1.2/(ch+2-j);
    int cc = int(width*1.4/ss)+1;
    float dy = pow(map(j, 0, 20, 0.1, .6), 3);
    for (int i = 0; i < cc; i++) {
      fill(rcol());
      plant(width*0.5+ss*(i-cc*0.5), height*0.4+ss*j*dy, ss*(1+dy*4)*random(0.8, 1.5));
    }
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(width*0.5, height*0.5, width-20, height-20));

  int sub = int(random(1000));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    float mw = r.w*random(0.4, 0.6);
    float mh = r.h*random(0.4, 0.6);
    if (min(mw, mh) < 40) continue;
    if (mw > mh) {
      rects.add(new Rect(r.x+mw*0.5-r.w*0.5, r.y, mw, r.h));
      rects.add(new Rect(r.x-(r.w-mw)*0.5+r.w*0.5, r.y, r.w-mw, r.h));
    } else {
      rects.add(new Rect(r.x, r.y+mh*0.5-r.h*0.5, r.w, mh));
      rects.add(new Rect(r.x, r.y-(r.h-mh)*0.5+r.h*0.5, r.w, r.h-mh));
    }
    rects.remove(ind);
  }
  
  /*
  float det = random(0.0001, 0.002);
  float des = random(10000);
  noiseDetail(4);
  strokeWeight(1);
  for (int i = 0; i < 30000; i++) {
    float xx = random(width);
    float yy = random(height);
    stroke(rcol(), 8);
    for (int j = 0; j < 10; j++) {
      float a = (noise(des+xx*det, des+yy*det)+random(-0.0005, 0.0005))*TAU*50;
      float nx = xx+cos(a)*1;
      float ny = yy+sin(a)*1;
      if (j%10 < 8) line(xx, yy, nx, ny);
      xx = nx;
      yy = ny;
    }
  }
  */
  

  rectMode(CENTER);
  stroke(0);
  for (int i = 0; i < rects.size(); i++) {
    
    if(random(1) > 0.8) continue;
    
    Rect r = rects.get(i);
    float x1 = r.x;
    float y1 = r.y;
    float w1 = r.w-20;
    float h1 = r.h-20;
    fill(rcol(), random(255));
    rect(x1, y1, w1, h1, 2);
    
    float w2 = r.w*0.2;
    float h2 = r.h*0.2;

    float tt = time*random(2);
    float x2 = x1+(w1-w2)*(noise(x1, y1, tt)-0.5);
    float y2 = y1+(h1-h2)*(noise(y1, x1, tt)-0.5);
    fill(rcol());
    rect(x2, y2, w2, h2);//, ss*rou);

    beginShape();
    fill(0, 40);
    vertex(x1-w1*0.5, y1-h1*0.5);
    vertex(x1+w1*0.5, y1-h1*0.5);
    fill(0, 0);
    vertex(x2+w2*0.5, y2-h2*0.5);
    vertex(x2-w2*0.5, y2-h2*0.5);
    endShape(CLOSE);

    beginShape();
    fill(0, 20);
    vertex(x1-w1*0.5, y1+h1*0.5);
    vertex(x1+w1*0.5, y1+h1*0.5);
    fill(0, 80);
    vertex(x2+w2*0.5, y2+h2*0.5);
    vertex(x2-w2*0.5, y2+h2*0.5);
    endShape(CLOSE);
  }
  
  
     noStroke();
  for(int i = 0; i < 14; i++){
     float xx = random(width);
     float yy = random(height);
     float ss = width*random(0.2);
     arc2(xx, yy, ss, ss*3, 0, TAU, rcol(), 80, 0);
  }
}

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void plant(float x, float y, float s) {
  float r = s*0.5;
  int res = int(PI*r);
  float da = TAU/res;

  float det = random(4);
  float des = random(10);
  beginShape();
  noiseDetail(2);
  for (int j = 0; j < res; j++) {
    float ang = da*j;
    float dx = cos(ang);
    float dy = sin(ang);
    //float rr = r*(1-pow(abs(cos(ang)*(0.5)), 1.8));
    float rr = (0.8+noise(des+dx*det, des+dy*det, time*0.3)*0.2)*r;
    vertex(x+dx*rr*0.9, y+dy*rr);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

//int colors[] = {#EC629E, #E85237, #ED7F26, #C28A17, #114635, #000000};
int colors[] = {#34302E, #72574C, #9A4F7D, #488753, #D9BE3A, #D9CF7C, #E2DFDA, #CF4F5C, #368886};
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