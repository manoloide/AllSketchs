void setup() {
  size(960, 960);
  generate();
}

void draw() {
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
  background(240);

  float str = random(12, 180);
  float des = random(str);

  strokeWeight(str*0.4);
  stroke(20);
  for (float i = -des; i <= width*2.5+str; i+=str*2) {
    line(-90, i, i, -90);
  }
  /*
  fill(240, 80, 40);
   noStroke();
   for (int i = 0; i < 5; i++) {
   float ang = random(TWO_PI);
   float dis = width*random(0.4);
   float x = width/2+cos(ang)*dis;
   float y = height/2+sin(ang)*dis;
   float s = random(800)*random(0.2, 1);
   ellipse(x, y, s, s);
   }*/
  drawCircle(random(0.3, 0.6), int(random(4, random(10, 50))));

  strokeWeight(str*0.4);
  stroke(20);
  for (float i = -des+str; i <= width*2.5+str; i+=str*2) {
    line(-90, i, i, -90);
  }

  int div = int(random(2, 40*random(1)));
  float ss = width*1./div;

  stroke(rcol());
  strokeWeight(1.5);
  for (int i = 0; i <= div; i++) {
    line(i*ss, 0, i*ss, height);
    line(0, i*ss, width, i*ss);
  }

  noStroke();
  fill(240);
  for (int j = 0; j<= div; j++) {
    for (int i = 0; i <= div; i++) {
      rect((i+0.45)*ss, (j+0.45)*ss, ss*0.1, ss*0.1);
    }
  }

  int cc = int(random(0.05)*div*div);
  for (int i = 0; i < cc; i++) {
    float w = int(random(1, 5));
    float h = int(random(1, 5));
    w = h = min(w, h);
    float x = int(random(-w, div+1-w))*ss-ss*0.1;
    float y = int(random(-h, div+1-h))*ss-ss*0.1;
    fill(rcol());
    rect(x, y, ss*(w+0.2), ss*(h+0.2));
  }

  drawCircle2(random(0.3, 0.8), int(random(20)));
}

void drawCircle(float maxDist, int cc) {
  ArrayList<PVector> circles = new ArrayList<PVector>();

  for (int i = 0; i < cc; i++) {
    float ang = random(TWO_PI);
    float dis = width*random(maxDist);
    float x = width/2+cos(ang)*dis;
    float y = height/2+sin(ang)*dis;
    float s = random(width)*random(0.2, 1.2);
    //ellipse(x, y, s, s);
    circles.add(new PVector(x, y, s));
  }

  noStroke();
  for (int i = 0; i < circles.size(); i++) {
    PVector act = circles.get(i);
    for (int j = i+1; j < circles.size(); j++) {
      PVector aux = circles.get(j);
      float[] points = pointsCircle(act, aux); 
      if (points != null) {
        float ss = (aux.z+act.z)*0.12;
        fill(rcol());
        ellipse(points[0], points[1], ss, ss);
        fill(rcol());
        ellipse(points[2], points[3], ss, ss);
      }
    }
  }
}

void drawCircle2(float maxDist, int cc) {
  ArrayList<PVector> circles = new ArrayList<PVector>();

  stroke(240);
  noFill();
  for (int i = 0; i < cc; i++) {
    float ang = random(TWO_PI);
    float dis = width*random(maxDist);
    float x = width/2+cos(ang)*dis;
    float y = height/2+sin(ang)*dis;
    float s = random(width)*random(0.2, 1.2);
    strokeWeight(s*0.02);
    ellipse(x, y, s, s);
    circles.add(new PVector(x, y, s));
    strokeWeight(s*0.01);
    line(x-s*0.02, y, x+s*0.02, y); 
    line(x, y-s*0.02, x, y+s*0.02);
  }

  for (int i = 0; i < circles.size(); i++) {
    PVector act = circles.get(i);
    for (int j = i+1; j < circles.size(); j++) {
      PVector aux = circles.get(j);
      float[] points = pointsCircle(act, aux); 
      if (points != null) {
        float ss = (aux.z+act.z)*0.05;
        strokeWeight(max(1, ss*0.02));
        ellipse(points[0], points[1], ss, ss);
        ellipse(points[2], points[3], ss, ss);
      }
    }
  }
}

int rcol() {
  if (random(1) < 0.5) {
    if (random(1) < 0.5) {
      return color(240, 80, 40);
    } else { 
      return color(240, 10, 200);
    }
  } else {   
    if (random(1) < 0.5) {
      return color(200, 240, 10);
    } else { 
      return color(10, 240, 200);
    }
  }
}

public float[] pointsCircle(PVector c1, PVector c2) {
  float x1 = c1.x;
  float y1 = c1.y;
  float x2 = c2.x;
  float y2 = c2.y;
  float r1 = c1.z*0.5;
  float r2 = c2.z*0.5;
  float a = x2 - x1;
  float b = y2 - y1;
  float ds = a*a + b*b;
  float d = sqrt(ds);

  if (r1 + r2 <= d)
    return null;
  if (d <= abs( r1 - r2 ))
    return null;
  float t = sqrt( (d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (-d + r1 + r2) );

  float sx1 = 0.5 * (a + (a*(r1*r1 - r2*r2) + b*t)/ds);
  float sx2 = 0.5 * (a + (a*(r1*r1 - r2*r2) - b*t)/ds);

  float sy1 = 0.5 * (b + (b*(r1*r1 - r2*r2) - a*t)/ds);
  float sy2 = 0.5 * (b + (b*(r1*r1 - r2*r2) + a*t)/ds);

  sx1 += x1;
  sy1 += y1;

  sx2 += x1;
  sy2 += y1;

  float[] r = new float[4];
  r[0] = sx1;
  r[1] = sy1;
  r[2] = sx2;
  r[3] = sy2;

  return r;
}