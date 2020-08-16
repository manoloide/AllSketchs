int seed = int(random(999999));

void setup() {
  size(640, 640);
}

void keyPressed() {
  if (key == 's') saveImage();
  else seed = int(random(999999));
  //saveFrame("####.png");
}

void draw() {
  randomSeed(seed);
  background(234);
  float cx = width/2;
  float cy = height/2;
  float r1 = width*random(0.3, 0.4);
  float r2 = r1*random(0.2, random(0.5, 0.9));
  float v1 = random(TWO_PI);//frameCount*random(0.03);
  float v2 = frameCount*random(-0.03, 0.03);
  v2 = v1;
  int cc = 2*int(random(4, 34));
  float da = TWO_PI/cc;
  fill(60);
  stroke(210);
  strokeWeight(2);
  for (int i = 0; i <= cc; i++) {
    float a1 = i*da+v1;
    float a2 = i*da+v2;
    ellipse(cx+cos(a1)*r1, cy+sin(a1)*r1, 6, 6);
    ellipse(cx+cos(a2)*r2, cy+sin(a2)*r2, 6, 6);
  }
  noFill();
  for (int i = 0; i <= cc*random (0.1, 40); i++) {
    int c1 = int(random(cc+1));
    int c2 = c1+int(random(-4, 4));
    float dd = 2;

    float a1 = c1*da+v1;
    float a2 = c2*da+v2;

    float aa = a2-a1;
    float dr = r1-r2;
    dr = dist(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a2)*r2, cy+sin(a2)*r2);

    float amp = random(0.1, 0.9);

    stroke(0, 22);
    strokeWeight(3);
    bezier(cx+cos(a1)*r1, cy+sin(a1)*r1+dd, cx+cos(a1)*(r1-dr*amp), cy+sin(a1)*(r1-dr*amp)+dd, cx+cos(a2)*(r2+dr*amp), cy+sin(a2)*(r2+dr*amp)+dd, cx+cos(a2)*r2, cy+sin(a2)*r2+dd);
    stroke(rcol());
    strokeWeight(2);
    bezier(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a1)*(r1-dr*amp), cy+sin(a1)*(r1-dr*amp), cx+cos(a2)*(r2+dr*amp), cy+sin(a2)*(r2+dr*amp), cx+cos(a2)*r2, cy+sin(a2)*r2);

    //line(cx+cos(a1)*r1, cy+sin(a1)*r1, cx+cos(a2)*r2, cy+sin(a2)*r2); 
    /*
    stroke(0, 16);
     strokeWeight(3);
     bezier(x, y+dy*c1+dd, x+w*0.5, y+dy*c1+dd, x+w*0.5, y+dy*c2+dd, x+w, y+dy*c2+dd);
     stroke(200, 255, 20);
     strokeWeight(2);
     bezier(x, y+dy*c1, x+w*0.5, y+dy*c1, x+w*0.5, y+dy*c2, x+w, y+dy*c2);
     */
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

color rcol() {
  return (random(1) < 0.4)?  color(200, 255, 20) : (random(1) < 0.5)? color(20, 255, 200) : color(255, 20, 200);
}

