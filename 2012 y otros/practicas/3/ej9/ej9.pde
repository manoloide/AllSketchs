void setup() {
  size(400, 400);
  background(0);
  colorMode(HSB);
}

void draw(){
    float v1 = mouseY* 1./height* 255;
    float v2 = mouseX* 1./width * 255;
    print(v1);
   //background(255);
   stroke(85,v1, v2);
   line(0,0,mouseX,mouseY);
   stroke(171,v2,v1);
   line(400,400,mouseX,mouseY);
}

void mousePressed(){
}

void mouseMoved(){
}
