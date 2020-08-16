int seed = int(random(99999999)); 

//https://ar.pinterest.com/pin/460985711850841261/

void setup() {
  size(528, 280);
  smooth(8);
  frameRate(30);
  pixelDensity(2);
  strokeCap(SQUARE);
}

void draw() {
  background(#020001);

  randomSeed(seed);
  noiseSeed(seed);

  float time = millis()*0.01;
  float alp = 245+cos(time*10)*10;

  blendMode(ADD);
  stroke(#FF7C00, alp);
  fill(#FF7C00, alp);
  strokeWeight(1);
  textSize(9);
  textAlign(LEFT, TOP);
  for (int i = 0; i < 12; i++) {
    float dy = height-42-i*20;
    line(4, dy, 6, dy); 
    line(12, dy, 14, dy);
    text(nfp((i+1), 2), 17, dy-6.5);
  }
  strokeWeight(2.5);
  line(9.5, 0, 9.5, height-23);
  line(0, height-20, width, height-20);
  strokeWeight(1);
  meter(44, 0, 44, height-22);
  meter(0, height-16, width, height-16);

  stroke(#8AC89C, alp);
  for (int i = 0; i < 5; i++) {
    float xx = 48+120*i;
    line(xx, 0, xx, height-24);
    for (int j = 0; j < 6; j++) {
      if ((i == 0 || i == 3) && j == 5) continue;
      float yy = height-42-j*40;
      line(xx+2, yy, xx+5, yy);
      line(xx+115, yy, xx+118, yy);
      line(xx+2, yy-4, xx+2, yy+4);
      line(xx+118, yy-4, xx+118, yy+4);
      line(xx+57, yy, xx+63, yy);
      line(xx+60, yy-4, xx+60, yy+4);
    }
  }

  if (frameCount%1 == 0) {
    noiseDetail(2);
    noFill();
    stroke(#FF7C00);
    strokeWeight(1);
    beginShape();
    float det = random(0.02, 0.04);
    float tt = time*random(100, 200);

    float det2 = random(2, 10);
    float tt2 = time*random(0.1);//random(100, 200);

    float det3 = random(10);
    float tt3 = time*random(0.1, 1);
    float des = random(1000);
    for (float x = 0; x <= width; x+=0.1) {
      float xx = x;
      float val = 1;
      float amp = 1;
      //noi = cos(x*0.1-tt)*0.5+0.5;
      int sel = int(x-50)/120;
      if (x < 50) sel = -1;
      if (sel == -1) amp = 0.002;
      if (sel == 0) amp = pow(sin(map(x, 50, 170, 0, HALF_PI*0.5))*1.41, 3);

      amp += noise(det*x, tt)*0.03;
      float yy = map(val*amp, 0, 1, height-21, 20);

      if (sel > 1) {
        float sep = 40;
        float nx = int((x-10)/sep);
        float mx = (xx-10)%sep;
        float des1 = 0.2+pow(noise((nx-1)*det2+tt2), 0.5)*0.8;
        float des2 = 0.2+pow(noise((nx)*det2+tt2), 0.5)*0.8;
        float amp1 = pow(1-sin(map(x-mx, 290, width, 0, HALF_PI)), 0.4);
        float amp2 = pow(1-sin(map(x-mx+sep, 290, width, 0, HALF_PI)), 0.4);
        amp1 += noise(det*x, tt)*0.03;
        amp2 += noise(det*x, tt)*0.03;
        float y1 = map(des1*amp1, 0, 1, height-21, 20);
        float y2 = map(des2*amp2, 0, 1, height-21, 20);

        if (mx <= sep/2) {
          xx = xx-mx+mx*2;
          yy = y1;
        } else {
          xx = xx-mx+sep;
          yy = map(mx, sep*0.5, sep, y1, y2);
        }
      }

      if (sel == 1) {
        amp += noise(det*x, tt)*0.03;

        float vv = map(x, 50+120, 50+240, 0, 1);
        xx = (sin(vv*TWO_PI*1.5-HALF_PI)*0.5+0.5)*120;
        yy = cos(vv*TWO_PI*2.125+tt*0.1)*0.5+0.5;

        float dt = det*2.1;
        yy = noise(xx*dt+tt*0.001, yy*dt, x*dt+tt*0.01);
        if (yy < 0.5) yy = pow(yy, 1.3);
        else yy = pow(yy, 0.4);
        //yy = noise(vv*det2*40.1, tt)*mm;

        xx = 48+120+xx;
        yy = map(yy, 0, 1, height-21, 20);
      }

      if (sel > 1) {
        float na = noise(time)*1.5;
        if (na < 0.3) na = 0;
        else na = pow(map(na, 0.3, 1, 0, 1), 4);
        float dd = (pow(noise(x*det2*0.03+tt2*1000), 1)*2-1)*na*50;
        xx += cos(PI*1.6)*dd;
        yy += sin(PI*1.6)*dd;
      }

      vertex(xx, yy);
    }
    endShape();
    strokeWeight(1);
  }

  noFill();
  strokeWeight(1.5);
  stroke(#FF7C00, alp);
  rect(53, 20, 111, 28, 4);
  rect(413, 20, 111, 36, 4);
  stroke(#B62119, alp);
  rect(413, 170, 111, 20, 4);
  rect(413, 170, 111, 20, 4);

  noStroke();
  fill(#FF7C00, cos(time*10)*255);
  rect(56, 23, 105, 22, 3);
  rect(416, 23, 105, 30, 3);
  fill(#B62119, cos(time*10)*255);
  rect(416, 173, 106, 14, 3);
  rect(416, 173, 106, 14, 3);


  strokeWeight(1);
}

void keyPressed() {
  seed = int(random(99999999));
}

void meter(float x1, float y1, float x2, float y2) {
  float ang = atan2(y1-y2, x1-x2);
  float dis = dist(x1, y1, x2, y2);
  float dx = cos(ang-HALF_PI);
  float dy = sin(ang-HALF_PI);
  float sep = 4;
  float dd, xx, yy;
  for (int i = 1; i <= dis/sep; i++) {
    xx = x2+cos(ang)*i*sep;
    yy = y2+sin(ang)*i*sep;
    dd = 3;
    if (i%5 == 0) dd = 6;
    line(xx, yy, xx+dx*dd, yy+dy*dd);
  }
}