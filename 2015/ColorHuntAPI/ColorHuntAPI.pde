ColorHunt colorHunt;

void setup() {
  size(800, 800);
  colorHunt = new ColorHunt();
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

int pallete[] = {
  #2B2E4A, 
  #E84545, 
  #903749, 
  #53354A
};

void generate() {
  background(rcol());
  colorHunt.getRandom();
  ArrayList<PVector> points = new ArrayList<PVector>(); 
  noStroke();
  fill(0);

  for (int cccc = 0; cccc < 100; cccc++) {
    float x = random(width);
    float y = random(height);
    float t = random(8, 90);
    int col = rcol();
    int st = 20;//int(t*0.2);

    int cw = int(random(2, 8));
    int ch = int(random(1, 5));
    fill(col);
    float s = t*random(1.1, 1.6);
    x += -s*((cw-1)*0.5);
    y += -s*((ch-1)*0.5);
    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        noFill();
        for (int k = st; k > 0; k--) {
          stroke(col, map(k, st, 0, 2, 12));
          strokeWeight(k);
          ellipse(x+s*i, y+s*j, t, t);
        }
        noStroke();
        fill(col);
        ellipse(x+s*i, y+s*j, t, t);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

int rcol() {
  return pallete[int(random(pallete.length))];
}

class ColorHunt {
  ColorHunt() {
  }

  int[] getNew() {
    return null;
  }

  int[] getHot() { 
    return null;
  }

  int[] getPopular() {
    return null;
  }

  int[] getRandom() {
    String[] str = loadStrings("http://colorhunt.co/random");
    println(str); 
    return null;
  }
}

