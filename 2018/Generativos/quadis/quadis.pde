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

class Rect {
  float x, y, w, h; 
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
  void draw() {
    beginShape();
    vertexCol(x, y);
    vertexCol(x+w, y);
    vertexCol(x+w, y+h);
    vertexCol(x, y+h); 
    endShape(CLOSE);
  }
}


float des = random(1000);
float det = random(0.01);

void vertexCol(float x, float y) {
  fill(getColor(noise(des+x*det, des+y*det)*colors.length));
  vertex(x, y);
}

void generate() {
  ArrayList<Rect> rects = new ArrayList<Rect>();

  rects.add(new Rect(0, 0, width, height));

  des = random(1000);
  det = random(1);


  int sub = int(random(300*random(1)));
  float scl = random(0.2, 0.5);
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);

    float nw = r.w*scl;
    float nh = r.h*scl;
    float dw = r.w-nw;
    float dh = r.h-nh;
    float nx = r.x+dw*0.5;
    float ny = r.y+dh*0.5;

    background(0);

    float dx1, dx2, dy1, dy2;

    if (random(1) < 0.5) {
      dx1 = 0;
      dx2 = -dw*0.5;
      dy1 = -dh*0.5;
      dy2 = 0;
    } else {
      dx1 = -dw*0.5;
      dx2 = 0;
      dy1 = 0;
      dy2 = -dh*0.5;
    }

    rects.add(new Rect(r.x, ny+dy1, dw*0.5, nh+dh*0.5));
    rects.add(new Rect(r.x+r.w-dw*0.5, ny+dy2, dw*0.5, nh+dh*0.5));

    rects.add(new Rect(nx+dx1, r.y, nw+dw*0.5, dh*0.5));
    rects.add(new Rect(nx+dx2, r.y+r.h-dh*0.5, nw+dw*0.5, dh*0.5));

    rects.add(new Rect(nx, ny, nw, nh));
    rects.remove(ind);
  }

  noFill();
  //stroke(255);
  noStroke();
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    fill(getColor(random(colors.length)));
    rect(r.x, r.y, r.w, r.h);
    //r.draw();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#B14027, #476086, #659173, #9293A2, #262A2C, #D38644};

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

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}