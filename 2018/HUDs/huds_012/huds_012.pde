import java.util.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  rectMode(CENTER);

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
  background(#190A33);

  ortho();
  translate(width/2, height/2, -1000);
  rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateZ(-HALF_PI*0.5);

  randomSeed(seed);

  List<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width*2.3));
  int sub = int(random(200));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float ms = r.z*0.5;
    float mm = ms*0.5;
    rects.add(new PVector(r.x-mm, r.y-mm, ms));
    rects.add(new PVector(r.x+mm, r.y-mm, ms));
    rects.add(new PVector(r.x+mm, r.y+mm, ms));
    rects.add(new PVector(r.x-mm, r.y+mm, ms));
    rects.remove(ind);
  }

  Collections.sort(rects, new Comparator<PVector>() {
    @Override
      public int compare(PVector p2, PVector p1) {
      int val = 0;
      if ((p2.x-p2.y) < (p1.x-p1.y)) val = -1;
      if ((p2.x-p2.y) > (p1.x-p1.y)) val = -1;
      return val;
    }
  }
  );

  for (int c = 0; c < rects.size(); c++) {
    PVector r = rects.get(c);
    float x = r.x;
    float y = r.y;
    float s = r.z;

    noFill();
    int col = rcol();
    stroke(col, 250);
    rect(x, y, s, s);

    int rnd = int(random(7));

    if (rnd == 0) {
      float ss = s*random(1);
      noStroke();
      fill(rcol());
      ellipse(x, y, ss, ss);

      int cc = int(random(4, random(4, 32)));
      float sss = s/cc;
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          ellipse(-s*0.5+x+sss*(i+0.5), -s*0.5+y+sss*(j+0.5), sss*0.2, sss*0.2);
        }
      }
    }

    if (rnd == 1) {
      int cc = int(random(1, 12));
      for (int k = 0; k < cc; k++) {
        float r1 = s*random(0.2, 0.5);
        float r2 = r1*random(random(0.8, 0.92), 0.98);
        float h = s*random(0.2);

        int ccc = int(random(16, 200));
        float da = TWO_PI/ccc;
        for (int j = 0; j < ccc; j++) {
          float dx = cos(j*da);
          float dy = sin(j*da);
          line(x+dx*r1, y+dy*r1, h, x+dx*r2, y+dy*r2, h);
        }
      }
    }

    if (rnd == 2) {
      float r1 = s*random(0.2, 0.5);

      int cc = int(random(8, random(8, 48)));
      float sss = s/cc;
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          point(-s*0.5+x+sss*(i+0.5), -s*0.5+y+sss*(j+0.5));
        }
      }

      cc = int(random(16, 200));
      float da = TWO_PI/cc;
      float des = random(1000);
      float det = random(0.1);
      noiseDetail(1);
      //beginShape();

      for (int j = 0; j < cc; j++) {
        float dx = cos(j*da)*r1;
        float dy = sin(j*da)*r1;

        float h = noise(des+dx*det, des+dx*det)*r1;
        line(x+dx, y+dy, 0, x+dx, y+dy, h);
        //vertex(x+dx*r1, y+dy*r1, h);
      }
      //endShape(CLOSE);
    }

    if (rnd == 3) {

      //noStroke();
      //fill(col);

      float ss = s*random(0.6, 0.9);
      //fill(col, 100);
      //fill(col);
      stroke(col);
      noFill();
      pushMatrix();
      translate(x, y, ss*0.5);
      box(ss);
      popMatrix();
    }

    if (rnd == 4) {
      int cc = int(random(4, random(4, 32)));
      float ss = s/cc;
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          noFill();
          stroke(col);
          rect(-s*0.5+x+ss*(i+0.5), -s*0.5+y+ss*(j+0.5), ss, ss);
          float amp = random(0.1, 0.8);
          if (amp < 0.5) {
            rect(-s*0.5+x+ss*(i+0.5), -s*0.5+y+ss*(j+0.5), ss*amp, ss*amp);
            noStroke();
            fill(col);
            rect(-s*0.5+x+ss*(i+0.5), -s*0.5+y+ss*(j+0.5), ss*(amp*0.6), ss*(amp*0.6));
          }
        }
      }
    }

    if (rnd == 5) {
      float ss = random(4, 18);
      int cc = int(s/ss);
      ss = s*1./cc;
      float det = random(0.1);
      stroke(col, 140);
      for (int j = 0; j < cc; j++) {
        for (int i = 0; i < cc; i++) {
          float x1 = -s*0.5+x+ss*(i+0.5);
          float y1 = -s*0.5+y+ss*(j+0.5);
          float h = noise(x1*det, y1*det)*s*0.2;
          line(x1, y1, 0, x1, y1, h);
          rect(x1, y1, ss, ss);
        }
      }
    }

    if (rnd == 6) {
      int cc = int(random(2, random(13)));
      float ss = s*random(0.6, 0.9)/cc;
      float dd = (s-cc*ss)*0.5;
      float val = random(0.0, 0.6);
      float amp = random(0.8, 1);
      //noStroke();
      noFill();
      for (int k = 0; k < cc; k++) {
        for (int j = 0; j < cc; j++) {
          for (int i = 0; i < cc; i++) {
            float xx = dd+-s*0.5+x+ss*(i+0.5);
            float yy = dd+-s*0.5+y+ss*(j+0.5);
            float zz = ss*(k+0.5);
            if (random(1) < val) continue;
            stroke(rcol());
            pushMatrix();
            translate(xx, yy, zz);
            box(ss*amp);
            popMatrix();
          }
        }
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/190A33-db3b4b-edd23b-d4dbdd-2172ba
//int colors[] = {#DB204F, #EAC43A, #d4dbdd, #2172ba};
int colors[] = {#db3b4b, #edd23b, #d4dbdd, #2172ba};
int rcol() {
  //return color(255);
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