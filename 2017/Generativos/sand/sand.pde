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
  else generate();
}

void generate() {
  background(255);

  /*
  for (int i = 0; i <= height; i+=5) {
   float v = i*1./height;
   fill(getColor(v*colors.length));
   rect(0, i, width, 5);
   }
   */

  float io = random(1);
  float mo = random(1, 3.5);
  float ia = random(1);
  float ma = random(0, 3);
  float amp = random(0.1, 0.3);
  float aa = amp*random(1)*random(0.5, 1);

  float mx1 = random(0.4, 0.6);
  float mx2 = random(0.4, 0.6);
  //float det = random(0.01)*random(1);
  noFill();
  stroke(0, 10);
  int dy = 2;
  for (int i = 0; i <= height; i+=dy) {
    float v1 = i*1./height;
    float a1 = amp+cos(ia+ma*v1)*aa;
    float x1 = width*(lerp(mx1, mx2, v1)+cos(io+v1*TWO_PI*mo)*a1);
    float v2 = (i*1.+dy)/height;
    float a2 = amp+cos(ia+ma*v2)*aa;
    float x2 = width*(lerp(mx1, mx2, v2)+cos(io+v2*TWO_PI*mo)*a2);
    float y1 = i;
    float y2 = i+dy;
    noStroke();
    beginShape();
    fill(getColor(colors.length*0.2));
    vertex(x1, y1);
    vertex(x2, y2);
    fill(getColor(colors.length-1));
    vertex(width, y2);
    vertex(width, y1);
    endShape(CLOSE);


    beginShape();
    fill(getColor(colors.length*0.0));
    vertex(x1, y1);
    vertex(x2, y2);
    fill(getColor(colors.length*0.4));
    vertex(0, y2);
    vertex(0, y1);
    endShape(CLOSE);


    beginShape();
    fill(0, 0);
    vertex(x2, y2);
    fill(0, 10);
    vertex(width, y2);
    fill(0, 20);
    vertex(width, y1);
    fill(0, 10);
    vertex(x1, y1);
    endShape(CLOSE);

    beginShape();
    fill(0, 0);
    vertex(x2, y2);
    fill(0, 10);
    vertex(0, y2);
    fill(0, 20);
    vertex(0, y1);
    fill(0, 10);
    vertex(x1, y1);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#F79832, #F18315, #DB6B01, #9C3702, #AD4B02};

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