class Tipitos {

  PImage images[];

  Tipitos() {
    loadFolder();
  }

  PImage getRnd() {
    return images[int(random(images.length))];
  }

  void loadFolder() {
    File f = new File(dataPath("tipitos/"));
    File[] files = f.listFiles();

    ArrayList<PImage> aux = new ArrayList<PImage>();
    for (int i = 0; i < files.length; i++) {
      PImage img = loadImage(files[i].getPath());
      if (img != null) aux.add(img);
    }

    images = new PImage[aux.size()];
    for (int i = 0; i < aux.size(); i++) {
      images[i] = aux.get(i);
      images[i].filter(THRESHOLD, 0.0);
    }
  }
}  