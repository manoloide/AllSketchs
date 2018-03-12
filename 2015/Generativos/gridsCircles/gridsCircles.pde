PShader post;

void setup() {
  size(800, 800, P2D);
  post = loadShader("data/post.glsl");
  post.set("iResolution", float(width), float(height));
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  color c1 = color(random(256), random(256), random(256));
  color c2 = color(random(256), random(256), random(256));
  for (int j = 0; j < height; j++) {
    color col = lerpColor(c1, c2, j*1./height);
    for (int i = 0; i < width; i++) {
      float b = random(-5, 5);
      color c = color(red(col)+b, green(col)+b, blue(col)+b);
      set(i, j, c);
    }
  }

  noFill();
  for (int i = 0; i < 10; i++) {
    float tt = random(width*0.8);
    stroke(255*int(random(2)));
    strokeWeight(max(2, tt*random(0.2)*random(1)));
    ellipse(width/2, height/2, tt, tt);
  }

  noStroke();
  for (int c = 0; c < 50; c++) {
    float t = int(5*pow(2, int(random(1, 4))));
    float x = random(width);
    x -= x%t;
    float y = random(height);
    y -= y%t;
    fill(10, 240);
    rect(x, y, t, t);
    fill(250, 240);
    for (int j = 0; j < 8; j++) {
      for (int i = 0; i < 8; i++) {
        float tt = t/10.;
        float xx = x+tt*(i+1);
        float yy = y+tt*(j+1);
        if ((i+j)%2 == 0) rect(xx, yy, tt, tt);
      }
    }
  }
  loadPixels();
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width/2; i++) {
      set(i, j, get(width-1-i, j));
    }
  }
  updatePixels();
  filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

