void grid001() {

  background(#FF4116);

  int cc = int(random(2, random(20, random(40, 90)*random(0.1, 1)*random(1))*random(0.1, 1)));
  float des = width*1./(cc+1.5);
  float bb = (width-des*cc)*0.5;

  int form = int(random(2));

  boolean dots = random(1) < 0.3;

  noStroke();
  fill(0);
  rectMode(CENTER);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {

      float ff = int(random(4));
      if (random(1) < 0.9) ff = form;


      float xx = bb+(i+0.5)*des;
      float yy = bb+(j+0.5)*des;

      float ss = des;
      if (random(1) < 0.5) ss *= 0.5;
      if (random(1) < 0.25) ss *= 0.5;
      if (random(1) < 0.04) ss = des*0.08;
      if (random(1) < 0.5) continue;


      if (random(1) < 0.04) ss = des*0.08;

      if (random(1) < 0.1) {
        float shd = ss*0.1;
        fill(0, 20);
        if (form == 0) ellipse(xx+shd, yy+shd, ss, ss);
        if (form == 1) rect(xx+shd, yy+shd, ss, ss);
      }


      boolean col = random(1) < 0.5;
      noStroke();
      if (col) fill(0);
      else fill(255);

      float sss = ss;
      if (random(1) < 0.01) {
        if (col) stroke(0);
        else stroke(255);
        strokeWeight(3);
        sss = ss-3;
        noFill();
      }

      boolean bor = random(1) < 0.09;

      if (form == 0) {
        if (bor) {
          if (col) fill(0, 120);
          else fill(255, 120);
          ellipse(xx, yy, sss, sss);
          if (col) fill(0);
          else fill(255);
          ellipse(xx, yy, sss-10, sss-10);
        } else {
          if (col) fill(0);
          else fill(255);
          ellipse(xx, yy, sss, sss);
        }
      }
      if (form == 1) {
        if (bor) {
          if (col) fill(0, 120);
          else fill(255, 120);
          rect(xx, yy, sss, sss);
          if (col) fill(0);
          else fill(255);
          rect(xx, yy, sss-10, sss-10);
        } else {
          if (col) fill(0);
          else fill(255);
          rect(xx, yy, sss, sss);
        }
      }

      noStroke();
      if (dots) {
        if (!col) fill(0);
        else fill(255);
        if (form == 0) ellipse(xx, yy, ss*0.1, ss*0.1);
        if (form == 1) rect(xx, yy, ss*0.1, ss*0.1);
      }
    }
  }
}
