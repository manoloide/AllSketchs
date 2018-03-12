PImage img;

float tam = 10;

void setup() {
  size(600, 600);
  img = loadImage("../f2.jpg");
  

}

void draw() {
    for (int j = 0; j < height; j+=tam ) {
    for (int i = 0; i < width; i+=tam ) {
      color aux = img.get(i, j);
      float ang = random(TWO_PI);
      float x = i + random(tam);
      float y = j + random(tam);
      float dx = cos(ang)*(tam/2);
      float dy = sin(ang)*(tam/2);
      
      stroke(red(aux),green(aux),blue(aux));
      line(x+dx,y+dy,x-dx,y-dy);
    }
  }
}

