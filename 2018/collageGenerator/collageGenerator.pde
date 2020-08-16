int seed = int(random(999999));

PImage images[];

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  loadImages();

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

  ArrayList<PVector> rects = new ArrayList<PVector>();
  rects.add(new PVector(0, 0, width));

  int sub = int(random(1, random(40)));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(rects.size()*random(1)));
    PVector r = rects.get(ind);
    float md = r.z*0.5;
    rects.add(new PVector(r.x, r.y, md));
    rects.add(new PVector(r.x+md, r.y, md));
    rects.add(new PVector(r.x+md, r.y+md, md));
    rects.add(new PVector(r.x, r.y+md, md));
    rects.remove(ind);
  }

  for (int i = 0; i < rects.size(); i++) {
    PVector r = rects.get(i);
    image(images[int(random(images.length))], r.x, r.y, r.z, r.z);
  }
}

void loadImages() {
  File folder = new File(sketchPath()+"/images/");
  String[] filenames = folder.list();
  images = new PImage[filenames.length];
  for (int i = 0; i < filenames.length; i++) {
    images[i] = loadImage("images/"+filenames[i]);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame("export/"+timestamp+".png");
}