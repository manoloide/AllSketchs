PImage img;
int cont;

void setup() {
  size(640, 480);
  colorMode(HSB,255);
  img = loadImage("logo.png");
  //blendMode(DIFFERENCE);
  background(255);
}

void draw() {
  fill(random(256),200,256,80);
  rect(0,0,width,height);
  //tint(0, 153, 204,random(256)); 
  //image(img, random(-90,width), random(-90,height), img.width/5, img.height/5);
  //image(img, random(-90,width), random(-90,height), img.width/20, img.height/20);
  image(img, (cont%5)*92, int(cont/5)*45, img.width/20, img.height/20);
  println(img.width/20 + " " + img.height/20);
  cont++;
  if(cont > 40){
     cont = 0; 
  }
}

