int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("ToonFrag.glsl", "ToonVert.glsl");

  generate();
}

void draw() {
  //if (frameCount%60 == 0) seed = int(random(999999));
  //generate();
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

  background(240);

  noStroke();

  int cc = int(random(20, 80));
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int c = 0; c < cc; c++) {
    float ss = width*1./int(pow(2, int(random(3, 8))));
    float xx = random(width);
    float yy = random(height);
    xx -= xx%ss;
    yy -= yy%ss;

    points.add(new PVector(xx, yy, ss));
  }

  float mx = width*random(-2, 2)*random(1);
  float my = height*random(-2, 2)*random(1);
  float maxb = random(0.4, 1.5);

  for (int i =0; i < points.size(); i++) {
    float xx = points.get(i).x;
    float yy = points.get(i).y;
    float ss = points.get(i).z;

    float b = ss*maxb;//ss*random(0.5, 4);
    int col = rcol();
    float cx = xx+ss*0.5;
    float cy = yy+ss*0.5;
    float dis = dist(cx, cy, mx, my);
    float d = dis/200.;
    float ang = atan2(cy-my, cx-mx);

    PVector ps[] = {new PVector(xx, yy), new PVector(xx+ss, yy), new PVector(xx+ss, yy+ss), new PVector(xx, yy+ss)};

    shader(noi);



    float mix = map((ang+TWO_PI)%HALF_PI, 0, HALF_PI, 0.001, 0.999);
    mix = pow(mix, 1.2);
    float shd1 = lerp(220, 140, mix);
    float shd2 = lerp(140, 220, mix);

    int sel = int(6+ang/HALF_PI)%4;
    float dx = cos(ang)*b*d;
    float dy = sin(ang)*b*d;

    int i1 = (sel+3)%4;
    int i2 = (sel+4)%4;
    int i3 = (sel+5)%4;

    beginShape();
    fill(col, shd1);
    vertex(ps[i1].x, ps[i1].y);
    vertex(ps[i2].x, ps[i2].y);
    fill(col, 0);
    vertex(ps[i2].x+dx, ps[i2].y+dy);
    vertex(ps[i1].x+dx, ps[i1].y+dy);
    endShape(CLOSE);

    beginShape();
    fill(col, shd2);
    vertex(ps[i2].x, ps[i2].y);
    vertex(ps[i3].x, ps[i3].y);
    fill(col, 0);
    vertex(ps[i3].x+dx, ps[i3].y+dy);
    vertex(ps[i2].x+dx, ps[i2].y+dy);
    endShape(CLOSE);

    //resetShader();
    fill(col);
    rect(xx, yy, ss, ss);
    rect(xx, yy, ss, ss);
  }
  /*
  for (int i =0; i < points.size(); i++) {
   float xx = points.get(i).x;
   float yy = points.get(i).y;
   float ss = points.get(i).z;
   fill(200);
   rect(xx, yy, ss, ss);
   }
   */
}

/*
   translate(-ss, -ss);
 noStroke();
 beginShape();
 fill(0, 20);
 vertex(ss, 0);
 vertex(ss, ss);
 fill(0, 0);
 vertex(ss+b, ss+b);
 vertex(ss+b, b);
 endShape(CLOSE);
 beginShape();
 fill(0, 40);
 vertex(0, ss);
 vertex(ss, ss);
 fill(0, 0);
 vertex(ss+b, ss+b);
 vertex(b, ss+b);
 endShape(CLOSE);
 translate(ss, ss);
 
 rotate(PI);
 
 noStroke();
 beginShape();
 fill(c1, 200);
 vertex(ss, 0);
 vertex(ss, ss);
 fill(c2, 0);
 vertex(ss+b, ss+b);
 vertex(ss+b, b);
 endShape(CLOSE);
 beginShape();
 fill(c1, 240);
 vertex(0, ss);
 vertex(ss, ss);
 fill(c2, 0);
 vertex(ss+b, ss+b);
 vertex(b, ss+b);
 endShape(CLOSE);
 
 popMatrix();
 }
 }
 */

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};
int rcol() {
  return colors[int(random(colors.length))];
}
int[] rcols(int cc) {
  cc = constrain(cc, 1, colors.length);
  int[] aux = new int[cc];
  aux[0] = rcol();
  for (int i = 1; i < cc; i++) {
    boolean add = true;
    while (add) {
      add = false;
      aux[i] = rcol();
      for (int j = 0; j < i; j++) {
        if (aux[i] == aux[j]) {
          add = true;
        }
      }
    }
  }
  return aux;
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