scrollH s1, s2, s3;
PFont font;

void setup() {
  size(200, 265);
  background(80);
  noStroke();
  frameRate(60);
  
  font = loadFont("font.vlw");
  textFont(font); 

  s1 = new scrollH(15, 200, 170, 10, 0, 255, 0, "s1");
  s2 = new scrollH(15, 220, 170, 10, 0, 255, 0, "s2");
  s3 = new scrollH(15, 240, 170, 10, 0, 255, 0, "s3");
}

void draw() {
  s1.act();
  s2.act();
  s3.act();

  fill(s1.val, s2.val, s3.val);
  rect(15, 15, 170, 170);
}

class scrollH {
  float x, y, width, height, max, min, val;
  String name;
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x + height/2 && mouseX - 8 <= x + width - height/2+ 8) {
        if ( mouseY >= y  && mouseY <= y + height )
          val = min + (max-min) * ((mouseX- height/2 - x )/(width - height));
        if (val < min) {
          val = min;
        }
        else if (val > max) {
          val = max;
        }
      }
    } 
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, width, height);

    fill(150);
    float pos = x + ((width-height) * (val-min)/(max-min));
    rect(pos, y, height, height);
    fill(255);
    text(name+" "+val, x+2, y+8);
  }
}
