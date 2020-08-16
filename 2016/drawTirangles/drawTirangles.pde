int colors[] = {
  #FAF4E1, 
  #FABC41, 
  #EC9454, 
  #C72767
};

void setup() {
  size(960, 960);
  background(30);
}

void draw() {
}

int ss = 40;
int px;
int py;
int l;

void mouseMoved() {
  int ax = mouseX/ss;
  int ay = mouseY/ss;

  int al = 1;
  if (mouseX%ss < ss-mouseY%ss) {
    al = 0;
  }

  if (ax != px || ay != py || al != l) {
    noStroke();
    fill(rcol());
    if (al == 0) {
      triangle(ax*ss, ay*ss, ax*ss+ss, ay*ss, ax*ss, ay*ss+ss);
      triangle(width-ax*ss, ay*ss, width-ax*ss+ss, ay*ss, width-ax*ss, ay*ss+ss);
    } else {
      triangle(ax*ss+ss, ay*ss+ss, ax*ss+ss, ay*ss, ax*ss, ay*ss+ss);
      triangle(width-ax*ss+ss, ay*ss+ss, width-ax*ss+ss, ay*ss, width-ax*ss, ay*ss+ss);
    }
  }

  px = ax;
  py = ay;
  l = al;
}

int rcol() {
  return colors[int(random(colors.length))];
}