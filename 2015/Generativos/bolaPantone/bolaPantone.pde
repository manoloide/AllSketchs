ArrayList<Color> pallete;

void setup() {
  size(1600, 1600);
  pallete = getPalleteImage(loadImage("image.jpg"));
  generar();
}

void draw() {
}

void keyPressed(){
 generar(); 
}

void generar(){
   background(250);
  for(int i = 0; i < 10000; i++){
    float cx = width/2;
    float cy = height/2;
    float dis = random(cx*0.6);
   float ang = random(TWO_PI);
   float tt = random(1, 40)*map(dis, 0, cx*0.6, 1, 0.5);
   float x = cx+cos(ang)*dis;
   float y = cy+sin(ang)*dis;
   for(int k = 0; k < 6; k++){
   stroke(0, 4);
   noFill();
   for(float j = 0.1; j <= 1; j+=0.1){ 
     strokeWeight(tt*0.3*j);
     ellipse(x+k*2, y+k*2, tt, tt);
   }
   noStroke();
   strokeWeight(1.5);
   stroke(pallete.get(i%pallete.size()).col, k*50);
   ellipse(x+k*2, y+k*2, tt, tt);
  } 
  }
  saveFrame("export.png");
  exit();
}

ArrayList<Color> getPalleteImage(PImage img) {
  ArrayList<Color> aux = new ArrayList<Color>();
  for (int i = 0; i < img.pixels.length; i++) {
    color ac = img.pixels[i];
    boolean add = true;
    for (int j = 0; j < aux.size (); j++) {
      if (ac == aux.get(j).col) {
        add = false;
        break;
      }
    }
    if(add) aux.add(new Color(ac));
  }
  print(aux.size());
  return aux;
}

class Color {
  int col; 
  Color(int col) {
    this.col = col;
  }
}
