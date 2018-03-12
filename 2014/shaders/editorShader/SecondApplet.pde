PFrame f;
secondApplet s;

public class PFrame extends Frame {
  public PFrame() {
    setBounds(0, 40+height, 480, 160);
    s = new secondApplet();
    add(s);
    s.init();
    show();
  }
}

public class secondApplet extends PApplet {
  boolean mover;
  public void setup() {
    size(480, 160);
  }

  public void draw() {
    if (load) return;
    background(60);
    fill(10);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, 16);
    //slider mescla
    sliderMescla();
    selector(0, 16, 100, width-16, vs1);
    selector(width-100, 16, 100, width-16, vs2);
  }

  void sliderMescla() {
    float xx = width/2; 
    float yy = height/2;
    float ww = 120;
    float hh = 24;
    stroke(80);
    strokeWeight(1.6);
    line(xx, yy-hh/2, xx, yy+hh/2);
    fill(10);
    noStroke();
    rectMode(CENTER);
    rect(xx, yy, ww, 8, 1);
    if (mousePressed && mouseX > xx-ww/2 && mouseX < xx+ww/2 && mouseY > yy-hh/2 && mouseY < yy+hh/2) {
      mover = true;
    }
    if (!mousePressed) {
      mover = false;
    }
    if (mover) {
      desmouse = map(mouseX, xx-ww/2, xx+ww/2, 0, 1);
      desmouse = constrain(desmouse, 0, 1);
    }
    fill(40);
    rect(xx+map(desmouse, 0, 1, -ww/2, ww/2), yy, 8, 32);
  }

  void selector(float xx, float yy, float ww, float hh, ViewShader vs) {
    fill(40);
    noStroke();
    rectMode(CORNER);
    int cant = shadersNames.length;
    rect(xx, yy+cant*16, ww, hh-cant*16);
    for (int i = 0; i < cant; i++) {
      boolean sobre = false;
      if (mouseX >= xx && mouseX < xx+ww && mouseY >= yy+i*16 && mouseY < yy+(i+1)*16) {
        sobre = true;
      }
      if (sobre) {
        fill(60);
      } else {
        fill(50);
      }
      boolean selec = vs.src.equals(shadersPaths[i]);
      if (mousePressed && sobre && !selec) {
        vs.newShader(shadersPaths[i]);
      }
      if (selec) {
        fill(70);
      }
      rect(xx, yy+i*16, ww, 16);
      textAlign(LEFT, TOP);
      fill(250);
      if (i < shadersNames.length && !load)
        text(shadersNames[i], xx+5, yy+i*16);
    }
  }
}
