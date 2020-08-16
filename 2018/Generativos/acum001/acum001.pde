int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
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
  background(#D5DEE3);

  noiseSeed(seed);
  randomSeed(seed);

  int gg = 20;
  for (int y = 0; y < height; y+=gg) {
    for (int x = 0; x < width; x+= gg) {
      /*
      noFill();
       stroke(0, 0, 10, 10);
       rect(xx, yy, gg, gg);
       noStroke();
       fill(rcol(), 80);
       rect(xx+bb, yy+bb, gg-bb, gg-bb);
       fill(rcol(), 40);
       rect(xx, yy, gg-bb, gg-bb);
       */

      float yy = y;
      float xx = random(width);
      xx -= xx%gg;


      float ss = gg*int(random(1, 4));

      noStroke();
      rectShw(xx-ss*0.5, yy-ss*0.5, ss, ss, ss*0.2, 40);

      fill(rcol());
      rect(xx-ss*0.5, yy-ss*0.5, ss, ss);

      if (random(1) < 0.5) {
        fill(rcol());
        float b = ss*random(0.01, 0.08);
        int cc = int(random(2, 11));
        float s = (ss-b*2)/cc;
        float dx = xx-ss*0.5+b;
        float dy = yy-ss*0.5+b;
        noStroke();
        if (random(1) < .5) stroke(rcol());
        for (int j = 0; j < cc; j++) {
          for (int i = 0; i < cc; i++) {
            fill(rcol());
            rect(dx+s*i, dy+s*j, s, s);
          }
        }
      }
    }
  }

  //gg = 20;
  for (int yy = 0; yy < height; yy+=gg) {
    for (int xx = 0; xx < width; xx+= gg) {
      noFill();
      stroke(0, 0, 10, 2);
      rect(xx, yy, gg, gg);
    }
  }


  int cc = int(random(10, random(30, 80)));
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = gg*int(random(1, 6));
    xx -= xx%ss;
    yy -= yy%ss;
    float dx = int(random(2))*2-1;
    float dy = int(random(2))*2-1;

    float ic = random(colors.length);
    float dc = random(0.5)*random(1);
    int vv = gg*int(random(1, 5));
    noStroke();
    for (float j = 0; j < vv; j+=0.5) {
      int col = getColor(ic+dc*j);
      fill(col);
      rect(xx+dx*j, yy+dy*j, ss, ss);
    }
  }
}

void rectShw(float x, float y, float w, float h, float s, float shw) {
  beginShape();
  fill(0, shw);
  vertex(x, y);
  vertex(x+w, y);
  fill(0, 0);
  vertex(x+w+s, y-s);
  vertex(x-s, y-s);
  endShape();


  beginShape();
  fill(0, shw);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(0, 0);
  vertex(x+w+s, y+h+s);
  vertex(x+w+s, y-s);
  endShape();

  beginShape();
  fill(0, shw);
  vertex(x+w, y+h);
  vertex(x, y+h);
  fill(0, 0);
  vertex(x-s, y+h+s);
  vertex(x+w+s, y+h+s);
  endShape();

  beginShape();
  fill(0, shw);
  vertex(x, y+h);
  vertex(x, y);
  fill(0, 0);
  vertex(x-s, y-s);
  vertex(x-s, y+h+s);
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#100D93, #DF390C};
//int colors[] = {#F4C7B2, #F4E302, #13ACF4, #03813E, #E40088};
//int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};

//int colors[] = {#0F0F0F, #CCCCCC, #FEFBFF, #DAFB52};
int colors[] = {#191718, #1E4B78, #7F9DA3, #BAB7B0, #C50311, #AF1D53};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}