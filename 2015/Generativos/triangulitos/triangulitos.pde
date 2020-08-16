int colors[] = {

  #F7F7F7, 
  #6C6B6B, 
  #FFED4B, 
  #51D8A1

  /*
  #F7F7F7, 
   #6C6B6B, 
   #FF0D2D, 
   #2F2843, 
   #FC546B
   */
};

PShader post;

void setup() {
  size(640, 640, P2D);
  post = loadShader("post.glsl");
  post.set("iResolution", float(width), float(height)); 
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(rcol());
  int ttt[] = { 
    5, 20, 40, 80
  };
  int tt = ttt[int(random(ttt.length))];
  int b = 2;
  int cw = width/tt-b-1;
  int ch = height/tt-b-1;
  int dx = tt*b;
  int dy = tt*b;
  noStroke();
  fill(255, 8);
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      ellipse(dx+i*tt, dy+j*tt, 3, 3);
    }
  }
  int cc = int(random(1, random(1, random(1, 1000))));
  float pos = random(1);
  for (int i = 0; i < cc; i++) {
    int t = int(random(1, random(1, cw/2)));
    int x = int(random(cw-t*2))+t;
    int y = int(random(ch-t*2))+t;
    int nx = (1-2*int(random(2)))*t;
    int ny = (1-2*int(random(2)))*t;
    noFill();
    stroke(0, 2);
    if (random(1) < pos) { 
      for (int s = 5; s >= 1; s--) {
        strokeWeight(s);
        beginShape();
        vertex(dx+x*tt, dy+y*tt);
        vertex(dx+(x+nx)*tt, dy+y*tt);
        vertex(dx+x*tt, dy+(y+ny)*tt);
        endShape(CLOSE);
      }
      beginShape();
      fill(rcol());
      vertex(dx+x*tt, dy+y*tt);
      fill(rcol());
      vertex(dx+(x+nx)*tt, dy+y*tt);
      fill(rcol());
      vertex(dx+x*tt, dy+(y+ny)*tt);
      endShape(CLOSE);
    } else {
      noFill();
      stroke(0, 2);
      for (int s = 5; s >= 1; s--) {
        strokeWeight(s);
        cross(dx+x*tt, dy+y*tt, tt*t, PI/4, random(0.1, 0.3));
      }
      fill(rcol());
      cross(dx+x*tt, dy+y*tt, tt*t, PI/4, random(0.1, 0.3));
    }
    //filter(post);
  }
}

void cross(float x, float y, float d, float a, float s) {
  float r = d*0.5;
  float sep = r*s;
  float r2 = dist(sep, 0, 0, sep);
  float da = TWO_PI/4;
  beginShape();
  for (int i = 0; i < 4; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang-PI/4)*r2, y+sin(ang-PI/4)*r2);
    float sx = cos(ang-PI/2)*sep; 
    float sy = sin(ang-PI/2)*sep;
    float xx = x+cos(ang)*r;
    float yy = y+sin(ang)*r;
    vertex(xx+sx, yy+sy);
    vertex(xx-sx, yy-sy);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int rcol() {
  return lerpColor(colors[int(random(colors.length))], colors[int(random(colors.length))], random(1));
}

