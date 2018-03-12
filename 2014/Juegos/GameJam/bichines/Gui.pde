class Boton {
  boolean sobre, click; 
  float x, y, w, h;
  Boton(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y;
    this.w = w; 
    this.h = h;
  }
  void act() {
    sobre = false; 
    if (mouseX >= x && mouseX < x+w && mouseY >= y && mouseY < y+h) { 
      click = false;
      sobre = true;
      if (input.click) {
        click = true;
      }
    }
    /*
    if(click){
      fill(255,127,255,80);
    }else{
      fill(127,127,255,80);
    }
    rect(x,y,w,h);
    */
  }
}

class Slider {
  boolean sobre, mover;
  float x, y, w, h, pos, val; 
  Slider(float x, float y) {
    this.x = x;
    this.y = y;
    w = img_slider.width;
    h = img_slider.height;
    pos = (w-10)*0.8;
    val = map(pos,2,w-10,0,1);
    mover = false;
  }
  void act() {
    sobre = false;
    if (mouseX >= x-w/2 && mouseX < x+w/2 && mouseY >= y-h/2 && mouseY < y+h/2) { 
      sobre = true;
      if (input.click) {
        mover = true;
      }
    }
    if (input.released) {
      mover = false;
    }
    if (mover) pos += mouseX-pmouseX;
    if (pos < 2) pos = 2;
    if (pos > w-10) pos = w-10;
    val = map(pos,2,w-10,0,1);
    dibujar();
  }
  void dibujar() {
    image(img_slider, x-w/2, y-h/2);
    image(img_pointslider, x-w/2+pos-img_pointslider.width/2, y-h/2-img_pointslider.height/2+10);
    /*
    fill(255,127,255,100);
    rect(x-w/2,y-h/2,w,h);
    ellipse(x-w/2+pos, y, 30,30); 
    */
  }
}
