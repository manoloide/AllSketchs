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

  randomSeed(seed);
  noiseSeed(seed);
  background(250);


  ArrayList<PVector> castles = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    float x = random(-0.5, 1.5)*width;
    float y = random(-0.5, 1.5)*height; 
    x -= x%10;
    y -= y%10;
    float s = width*random(0.8);
    boolean add = true;
    for (int j = 0; j < castles.size(); j++) {
      PVector p = castles.get(j);
      float dis = dist(x, y, p.x, p.y);
      if (dis < (s+p.z)*0.5) {
        add = false;
      }
    }
    if (add) {
      castles.add(new PVector(x, y, s));
    }
  }



  noStroke();
  float det = random(0.008, 0.01)*0.4;
  float des = random(1000);
  float amp = random(0.6, 1);

  float rad1 = 0.8;
  float rad2 = 1.1;

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  fill(rcol());
  for (int i = 0; i < 10000; i++) {
    float s = width*random(0.008, 0.01);
    float x = random(1)*(width+s)-s*0.5;
    float y = random(1)*(height+s)-s*0.5;
    s *= pow(noise(des+x*det, des+y*det), amp);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      float dis = dist(x, y, p.x, p.y);
      if (dis < (s+p.z)*0.5) {
        add = false;
      }
    }
    if (add) {
      float ss = s*0.5;

      for (int j = 0; j < castles.size(); j++) {
        PVector c = castles.get(j);
        float dis = dist(x, y, c.x, c.y)-ss;
        if (dis < c.z*rad2) {
          float ampDis = constrain(map(dis, c.z*rad1*0.5, c.z*rad2*0.5, 0, 1), 0, 1);
          ss *= ampDis;
        }
        if (ss <= 0) add = false;
      }


      if (add) {
        points.add(new PVector(x, y, s));
        ellipse(x, y, ss, ss);
      }
    }
  }



  for (int i = 0; i < castles.size(); i++) {
    PVector c = castles.get(i);
    float x = c.x;
    float y = c.y;
    float s = c.z;
    /*
    stroke(255);
     noFill();
     ellipse(x, y, s, s);
     ellipse(x, y, s*rad2, s*rad2);
     noStroke();
     fill(255);
     ellipse(x, y, s*rad1, s*rad1);
     */

    int sub = 30;
    float ss = int(s*0.5/(sub-2));
    fill(0);
    for (int k = 0; k < sub; k++) {
      for (int j = 0; j < sub; j++) {
        if (random(1) < 0.1) continue;
        float xx = x+(j-sub*0.5-0.5)*ss;
        float yy = y+(k-sub*0.5-0.5)*ss;
        float dis = constrain(dist(x, y, xx, yy)/(s*0.5), 0, 1);
        if(dis > 0.8) {
          rect(xx, yy, ss*0.1, ss*0.1);
          continue;
        }
          rect(xx, yy, ss*0.8, ss*0.8);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#1A1312, #3C333B, #A84257, #D81D37, #D81D6E};
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
