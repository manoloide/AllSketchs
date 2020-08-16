class Layer {
  boolean view, blocker;
  String name;
  Layer(String name) {
    this.name = name;
    view = true;
  }
}

class Layers {
  Layer layers[];
  Layers() {
    layers = new Layer[4];
    for (int i = 0; i < layers.length; i++) {
      layers[i] = new Layer("Layer"+(i+1));
    }
  }

  void update() {
    show();
  }

  void show() {
    noStroke();
    fill(160, 20);
    rect(0, height-120, width, 120);
    noFill();
    stroke(0, 20);
    for (int j = 0; j < layers.length; j++) {
      for (int i = 100; i < width; i+=10) {
        rect(i, height-110+j*16, 10, 16);
      }
    }
  }
}

