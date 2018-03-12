int paleta[] = {
  #F2F0F0, 
  #2EFF48, 
  #3B3A39, 
  #FFFFFF
};
PGraphics background;

//td-18 supernova

void setup() {
  size(1000, 600);
  drawBackground();
  generar();
}

void draw() {
  generar();
}
void keyPressed() {
  String keys = "awsedftgyhujkolp";
  //if (key == 's') saveImage();
  //else generar();
}

void generar() {
  image(background, 0, 0);

  led(300, 25, 300, 100);

  knob(75, 225, 50, 0);
  knob(175, 225, 50, 0);
  knob(275, 225, 50, 0);
  //knob(350, 200, 50, 0);
  for (int j = 1; j < 2; j++) {
    for (int i = 0; i < 8; i++) {
      if (j == 1) knob(400+75*i, 225, 50, 0);
      pad(375+75*i, 250+75*j, 50, cos((frameCount-i)*0.2));
    }
  }

  piano(200, 400);

  /*
  stroke(0, 40);
   for (int i = 0; i < width; i+=50) {
   line(i, 0, i, height);
   line(0, i, width, i);
   }
   */
}

void drawBackground() {
  background = createGraphics(width, height);
  background.beginDraw();
  background.background(120);//paleta[0]);
  background.noStroke();
  background.fill(40);
  background.rect(0, 0, width, 150);
  background.fill(200);
  background.rect(0, 150, 350, 125);

  background.fill(110);
  background.rect(350, 150, 650, 250);

  background.fill(140);
  background.rect(0, 400, 175, 200);
  background.rect(975, 400, 25, 200);
  background.fill(70);
  background.rect(175, 400, 800, 200);

  for (int i = 0; i < 8; i++) {
    //background.stroke(60+i*2);
    background.stroke(0, 80-i*10);
    background.line(0, 400+i, width, 400+i);
  }
  /*
  for (int i = 0; i < 200; i++) {
   background.stroke(0, 30-i/2);
   background.line(200, 400+i, 948, 400+i);
   }
   */


  background.stroke(0);
  background.line(0, 150, width, 150);
  background.stroke(10);
  background.line(0, 151, width, 151);
  background.stroke(20);
  background.line(0, 152, width, 152);
  background.stroke(30);
  background.line(0, 153, width, 153);
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = background.get(i, j);
      col = lerpColor(col, color(brightness(col)+random(-20, 20)), noise(i*0.01, j*0.01)*0.2);
      background.set(i, j, col);
    }
  }
  background.textAlign(LEFT, TOP);
  background.textFont(createFont("Helvetica Neue Bold", 80, true));
  background.fill(250);
  background.text("TD-18", 50, 25);
  background.fill(0, 30);
  background.text("TD-18", 50, 27);
  /*
  background.textFont(createFont("Helvetica Neue Light", 18, true));
   background.fill(250);
   background.text("SYNTH SUPERBOSSA", 50, 95);
   background.fill(0, 30);
   background.text("SYNTH SUPERBOSSA", 50, 97);
   */


  background.rect(50, 100, 228, 3);
  background.rect(50, 105, 228, 2);

  background.fill(0, 120);
  for (int j = 0; j < 10; j++) {
    for (int i = 0; i < 30; i++) {
      background.ellipse(655+i*10+(j%2)*5, 30+j*10, 5, 5);
    }
  }
  background.endDraw();
}

void knob(float x, float y, float t, float a) {
  noStroke();
  fill(0, 3);
  for (int i = 8; i > 0; i--) {
    ellipse(x, y+i-1, t+i+1, t+i+1);
  }
  fill(paleta[0]); 
  ellipse(x, y, t, t);
  fill(120, 30);
  ellipse(x, y, t-5, t-5);
}

void pad(float x, float y, float t, float v) {
  int w = int(t);
  int h = int(t);
  color l = lerpColor(color(220), color(20, 250, 80), v);
  float d = dist(0, 0, w/2, h/2);

  PGraphics m = createGraphics(w, h);
  m.beginDraw();
  m.noFill();
  m.background(255);
  m.stroke(0, 240);
  m.strokeWeight(4);
  m.rect(-2, -2, w+3, h+3, 8);

  PGraphics p = createGraphics(w, h);
  p.beginDraw();
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      color col = color(lerpColor(color(190), l, 1-(pow(w/2-i, 2)+pow(h/2-j, 2))/(d*d)));
      p.set(i, j, color(red(col), green(col), blue(col), red(m.get(i, j))));
    }
  }
  p.endDraw();
  m.endDraw();

  noStroke();
  fill(0, 3);
  for (int i = 8; i > 0; i--) {
    rect(x-1, y+i-1, t+2, t+i+1, 6);
  }

  image(p, x, y);
}

void piano(float x, float y) {
  fill(240);
  for (int i = 0; i < 15; i++) {
    rect(x+50*i, y, 48, 175, 0, 0, 4, 4);
  }

  fill(10);
  for (int i = 0; i < 14; i++) {
    if (i%7 != 2 && i%7 != 06) { 
      rect(x+36+50*i, y, 28, 100, 0, 0, 3, 3);
    }
  }

  for (int i = 0; i < 5; i++) {
    stroke(0, 200-i*40);
    line(x, 400+i, 947, 400+i);
  }
}

void led(float x, float y, float w, float h) {
  PGraphics led = createGraphics(int(w), int(h));
  led.beginDraw();
  led.background(16);
  led.stroke(paleta[1]);
  led.strokeWeight(2);
  for (int i = 1; i < w; i++) {
    float v1 = h/2+cos((-frameCount+i-1)*0.1)*h*0.3;
    float v2 = h/2+cos((-frameCount+i)*0.1)*h*0.3;
    led.line(i-1, v1, i, v2);
  }

  led.strokeWeight(1);
  led.noStroke();
  led.fill(paleta[1]);
  led.rect(0, 0, (frameCount*2)%led.width, 10);
  led.stroke(60);
  led.endDraw();
  PGraphics copy = createGraphics(led.width, led.height); 
  copy.beginDraw();
  copy.image(led, 0, 0);
  copy.filter(BLUR, 2);
  copy.endDraw();
  led.beginDraw();
  led.tint(255, 100);
  led.image(copy, 0, 0);
  led.noFill();
  led.stroke(24);
  led.strokeWeight(6);
  led.rect(0, 0, led.width-1, led.height-1, 6);
  led.endDraw();

  image(led, x, y);
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1; 
  saveFrame(nf(n, 4)+".png");
}

