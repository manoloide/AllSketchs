void setup() {
  size(960, 960); 
  textFont(createFont("Chivo Light", 48, true));
  smooth(8);
  generate();
  println(sqrt(3)/2);
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
  noStroke();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20);
    fill(random(170, 190), 5);
    ellipse(x, y, s, s);
  }

  translate(width/2, height/2);
  rotate(random(TWO_PI));

  color[] cols = {
    color(random(256), random(256), random(256)), 
    color(random(256), random(256), random(256)), 
    color(random(256), random(256), random(256)), 
    color(random(256), random(256), random(256))
  };

  color nc = color(random(256), random(256), random(256));
  for (int i = 0; i < cols.length; i++) {
    cols[i] = lerpColor(cols[i], nc, random(0.2));
    cols[i] = lerpColor(cols[i], color(0), i*0.05);
  }

  noFill();
  stroke(10);
  float sep = random(10, 200*random(0.2, 1));
  float ss = sep*random(1)*random(1);
  boolean inv = true;
  float ang = PI/6;
  float det = random(0.01);
  for (float j = -width; j < width; j+= sep*0.866) {
    inv = !inv;
    for (float i = -width; i < width; i+= sep) {
      float an = noise(i*det, j*det)*TWO_PI*2;
      float d = sep*0.1;
      float x = (inv)? i+sep*0.5 : i +cos(an)*d;
      float y = j+sin(an)*d;
      float dist = dist(0, 0, x, y)/(width*1.4);
      float s = sep*random(0.85, 1.15);
      noStroke();
      fill(rampColor(cols[0], cols[1], cols[2], cols[3], dist), map(sep, 180, 0, 10, 40));
      ellipse(x, y, s, s);
      pushStyle();
      noStroke();
      for (int k = 0; k < sep*0.8; k++) {
        float sss = map(k, 0, s*0.8, s*0.9, s*0.2);
        ellipse(x, y, sss, sss);
      }
      popStyle();
      stroke(10, 30);
      ellipse(x, y, s*0.2, s*0.2);

      /*
      ang += TWO_PI/6;
       fill(255, 0, 0, 20);
       beginShape();
       for (int k = 0; k < 3; k++) {
       float a = ang+TWO_PI/3*k;
       vertex(x+cos(a)*sep*0.49, y+sin(a)*sep*0.49);
       }
       endShape(CLOSE);
       */
    }
  }

  radialBlur(5);
}

void radialBlur(float amp) {
  float diag = dist(0, 0, width, height);
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      float dist = dist(i, j, width/2, height/2)/(diag*0.5);
      dist = pow(dist, 1.8);
      color col = get(i, j);
      int cc = int(dist*amp);
      cc = max(0, cc);
      float r = 0;
      float g = 0;
      float b = 0;
      float div = 0;
      for (int yy = -cc; yy <= cc; yy++) {
        for (int xx = -cc; xx <= cc; xx++) {
          float dd = dist(xx, yy, 0, 0)/amp;
          if (xx == 0 && yy == 0) dd = 1;
          if (i+xx < 0 || i+xx >= width || j+yy < 0 || j+yy >= height) continue;
          col = get(i+xx, j+yy);
          r += red(col)*dd;
          g += green(col)*dd;
          b += blue(col)*dd;
          div += dd;
        }
      }
      set(i, j, color(r/div, g/div, b/div));
    }
  }
}


color rampColor(color c1, color c2, color c3, color c4, float v) {
  if (v < 0.3) {
    return lerpColor(c1, c2, map(v, 0, 0.3, 0, 1));
  } else if (v < 0.8) {
    return lerpColor(c2, c3, map(v, 0.3, 0.8, 0, 1));
  } else {
    return lerpColor(c3, c4, map(v, 0.8, 1, 0, 1));
  }
}