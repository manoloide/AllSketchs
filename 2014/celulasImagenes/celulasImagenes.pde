ArrayList<PVector> pelotas;
PImage img;
void setup() {
  img = loadImage("https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-xpf1/v/t1.0-9/p480x480/10410414_812711208751794_1785056086824753173_n.jpg?oh=fc1a2500e290d0142ba446759e1a95cd&oe=54C3C483&__gda__=1421427518_69eee9fdbbf97de12651be1a2cf84088");
  size(img.width, img.height);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  //background(240);
  strokeWeight(0.5);
  float det = 0.02;
  pelotas = new ArrayList<PVector>();
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float t = 20*noise(x*det, y*det);
    PVector pel = new PVector(x, y, t);
    boolean agregar = false;
    boolean salir = false;
    while (!salir) {
      agregar = true;
      for (int j = 0; j < pelotas.size (); j++) {
        PVector aux = pelotas.get(j);
        if (dist(aux.x, aux.y, pel.x, pel.y) < (aux.z+pel.z)/2) {
          agregar = false;
          pel.z *= 0.9;
          break;
        }
      }
      if (agregar || pel.z < 5) salir = true;
    }
    if (agregar) pelotas.add(pel);
  }
  for (int i = 0; i < pelotas.size (); i++) {
    PVector pel = pelotas.get(i);
    fill(img.get(int(pel.x), int(pel.y)));
    ellipse(pel.x, pel.y, pel.z, pel.z);
    fill(255, 50);
    ellipse(pel.x, pel.y, pel.z*0.1, pel.z*0.1);
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n,4)+".png");
}
