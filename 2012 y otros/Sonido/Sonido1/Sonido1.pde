import ddf.minim.*;

Minim minim;
AudioInput in;

int col;

void setup(){
  size(400, 400);
  frameRate(30);
  smooth();
  noStroke();
  colorMode(HSB);
  //iniciar minim
  minim = new Minim(this);
  minim.debugOn();
  //iniciar la clase que lee el microfono en buffer
  in = minim.getLineIn(Minim.STEREO, 512);
  
  background(0);
}

void draw(){
  fill(0,10);
  rect(0,0,width,height);
  
  fill(col,255,255);
  float rad = in.left.get(511)*400; 
  ellipse(width/2, height/2, rad, rad);
  
  col++;
  col = col%256;
}

void stop() {
  //cierra el minim 
  in.close();
  minim.stop();
  super.stop();
}

