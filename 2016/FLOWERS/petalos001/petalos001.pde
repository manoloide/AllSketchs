ArrayList<Petalo> petalos;

void setup() {
  size(960, 960); 
  generate();
}


void draw() {
  background(#EAE9E8);
  for (int i = 0; i < petalos.size(); i++) {
    petalos.get(i).show();
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  petalos = new ArrayList<Petalo>();
  for (int j = 0; j < 3; j++) {
    for (int i = 0; i < 3; i++) {
      float x = (width/3)*(i+0.5);
      float y = (height/3)*(j+0.5);
      float s = (width/4);
      petalos.add(new Petalo(x, y, s));
    }
  }
}

class Petalo {
  float x, y, s;
  Petalo(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
  }
  void show() {
    noStroke();
    fill(255, 60);
    ellipse(x, y, s, s);

    float yy = y+s*0.5;
    float w = s;
    stroke(0);
    while (w > 2) {
      //ellipse(x, yy-w/3, 2, 2);
      line(x, yy, x, yy-w/3+2);
      yy -= w/3;
      w = w-w/3;
    }
  }
}