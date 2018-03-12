JSONArray songs;
PImage tapa;

void setup() {
  size(960, 960);
  smooth(8);
  tapa = loadImage("tapa.jpg");
  PFont font = createFont("Playfair Display", 180, true);
  textFont(font);
  songs = loadJSONArray("songs.json");
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {


  color col1 = tapa.get(int(random(tapa.width)), int(random(tapa.height)));//color(random(256), random(256), random(256));
  color col2 = tapa.get(int(random(tapa.width)), int(random(tapa.height)));//color(random(256), random(256), random(256));


  background(lerpColor(col1, col2, random(1)));

  pushMatrix();
  translate(width/2, height/2);
  rotate(PI/8);

  ArrayList<PVector> quads = new ArrayList<PVector>();
  float ss = max(width, height)*2;
  quads.add(new PVector(0, 0, ss));
  for (int i = 0; i < 800; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind);
    float ns = q.z*0.5;
    quads.add(new PVector(q.x-ns*0.5, q.y-ns*0.5, ns));
    quads.add(new PVector(q.x-ns*0.5, q.y+ns*0.5, ns));
    quads.add(new PVector(q.x+ns*0.5, q.y+ns*0.5, ns));
    quads.add(new PVector(q.x+ns*0.5, q.y-ns*0.5, ns));
    quads.remove(ind);
  }

  rectMode(CENTER);
  noStroke();
  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);

    //fill(random(255));
    fill(lerpColor(col1, col2, random(1)));
    rect(q.x, q.y, q.z, q.z);
  }

  JSONObject song = songs.getJSONObject(int(random(songs.size())));
  String words[] = song.getString("lyric").split(" ");

  if (words.length > 0) {
    fill(250, 250);
    ss *= 0.5;
    textAlign(CENTER, CENTER);
    for (int i = 0; i < 10; i++) {
      int ind = int(random(quads.size()));
      PVector q = quads.get(ind);
      textSize(320/int(random(random(1, 5), 6)));
      float x = (ss/8)*int(random(-8, 8));
      float y = (ss/8)*int(random(-8, 8));
      text(words[int(random(words.length))], x, y);
    }
  }

  popMatrix();

  noFill();
  int pelitos = int(random(1000, 8000));
  for (int i = 0; i < pelitos; i++) {
    stroke(255, random(10, 250)*random(1)*random(1));
    float x = random(width);
    float y = random(height);
    float r = random(2, 10);
    float a1 = random(TWO_PI);
    float a2 = a1+random(TWO_PI)*random(1)*random(1)*random(1);
    arc(x, y, r, r, a1, a2);
  }

  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = get(i, j);
      float rnd = random(-4, 4);
      color ncol = color(red(col)+rnd, green(col)+rnd, blue(col)+rnd);
      set(i, j, ncol);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}