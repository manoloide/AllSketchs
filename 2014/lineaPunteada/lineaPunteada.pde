void setup() {
  size(600, 600);
  background(255);
  colorMode(HSB);
}

void draw() {
  background(255);
  stroke(frameCount%360,200,200,80);
  //background(255);
  /*
  lineaPunteada(50, 100, width-50, 100, 10, frameCount);
  lineaPunteada(50, 100, 50, height-100, 10, frameCount);
  lineaPunteada(width-50, 100, width-50, height-100, 10, frameCount);
  lineaPunteada(50, height-100, width-50, height-100, 10, frameCount);

  float ang = (frameCount%600)/600. * TWO_PI;
  lineaPunteada(mouseX, mouseY, mouseX+cos(ang)*50, mouseY+sin(ang)*50, 20, frameCount);
  lineaPunteada(mouseX, mouseY, mouseX+cos(ang*2)*60, mouseY+sin(ang*2)*60, 10, frameCount);
  lineaPunteada(mouseX, mouseY, mouseX+cos(ang*4)*90, mouseY+sin(ang*4)*90, 8, frameCount);
  */
  for(float  i = 0.5; i < width; i*= 1.02){
    lineaPunteada(0, -10+i, width, i, 20, frameCount*i);
    //lineaPunteada(0, height-i, width, height-i, 20, frameCount*i);
  }
  for(float  i = 0.5; i < height; i*= 1.02){
    lineaPunteada(-10+i, 0, i, height, 20, frameCount*i);
  }
}

void lineaPunteada(float x1, float y1, float x2, float y2, float sep, float des) {
  des = des%(sep*2)-sep;
  float dist = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  int cant = int(dist/(sep*2))+ 1;
  float mov = des;
  for (float i = 0; i < cant; i++) {
    float lx1, ly1, lx2, ly2;
    lx1 = x1+cos(ang)*mov;
    ly1 = y1+sin(ang)*mov;
    lx2 = x1+cos(ang)*(mov+sep);
    ly2 = y1+sin(ang)*(mov+sep);
    if (i == 0 && mov < 0) {
      lx1 = x1;
      ly1 = y1;
    }
    if (mov >= dist-sep) { 
      if (mov >= dist) continue;
      lx2 = x2;
      ly2 = y2;
    }
    line(lx1, ly1, lx2, ly2);
    mov += sep*2;
  }
}
