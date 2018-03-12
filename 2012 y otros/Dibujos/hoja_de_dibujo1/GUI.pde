void gui() {
  strokeWeight(1);
  fill(70);
  noStroke();
  rect(600,0,200,height);
  cuadroColor();
  scr5.act();
  grosor = scr5.val;
}

void cuadroColor() {
  scr1.act();
  scr2.act();
  scr3.act();
  scr4.act();
  col = color(scr1.val, scr2.val, scr3.val,scr4.val);
  fill(255);
  stroke(128);
  rect(610,10,80,80);
  for (int j = 0; j < 9; j++){
     line(610+(j*10),10,610+(j*10),90);
     line(610,10+(j*10),690,10+(j*10));
  }
  fill(col);
  rect(610, 10, 80, 80);
}

class scrollH {
  float x, y, width, height, max, min, val;
  String name;
  scrollH(float nx, float ny, float nw, float nh, float nmin, float nmax, float nvar, String n) {
    x = nx;
    y = ny;
    width = nw;
    height = nh;
    max = nmax;
    min = nmin;
    val = nvar;
    name = n;
  }

  void act() {
    if (mousePressed) {
      if ( mouseX >= x + height/2 && mouseX - 8 <= x + width - height/2+ 8) {
        if ( mouseY >= y  && mouseY <= y + height )
          val = min + (max-min) * ((mouseX- height/2 - x )/(width - height));
        if (val < min) {
          val = min;
        }
        else if (val > max) {
          val = max;
        }
      }
    } 
    draw();
  }

  void draw() {
    fill(120);
    rect(x, y, width, height);

    fill(150);
    float pos = x + ((width-height) * (val-min)/(max-min));
    rect(pos, y, height, height);
    fill(255);
    text(name+" "+int(val), x+2, y+height-4);
  }
}
