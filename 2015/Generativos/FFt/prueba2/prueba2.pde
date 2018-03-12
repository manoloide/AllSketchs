import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

ArrayList<Particula> particulas;
PGraphics gra;
PShader bloom, blur, glow, vignette;

void setup() {
  size(displayWidth, displayHeight, P2D);
  //size(480, 480, P2D);
  frameRate(30);
  bloom = loadShader("bloom.glsl");
  blur = loadShader("blur.glsl"); 
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
  vignette = loadShader("vignette.glsl");
  vignette.set("iResolution", float(width), float(height)); 
  //shader.set("time", 0.0);
  gra = createGraphics(width, height, P2D);
  particulas = new ArrayList<Particula>();


  minim = new Minim(this);
  player = minim.loadFile("../idm1.mp3", 512);
  player.loop();
  fft = new FFT( player.bufferSize(), player.sampleRate());
  fft.linAverages(16);
}

void draw() {

  fft.forward( player.mix );

  for (int i = 0; i < fft.getBand (0)*0.5-2; i++) {
    particulas.add(new Particula(random(width), random(height)));
  }

  blur.set("time", millis()/3000.0);  
  glow.set("iGlobalTime", frameRate/6.);  
  vignette.set("iGlobalTime", millis()/1000.);

  background(0);
  gra.beginDraw();
  gra.filter(blur);
  for (int i = 0; i < particulas.size (); i++) {
    Particula p = particulas.get(i);
    p.update();
    if (p.eliminar) particulas.remove(i--);
  }
  if (fft.getBand(1) > 22) {
    for (int i = 0; i < 1; i++) {
      int t = int(random(2));
      if (t == 0) {
        gra.stroke(random(256), random(256), random(256), random(200, 256));
        gra.strokeWeight(random(1, width/100));
        gra.noFill();
        poly(gra, width/2, height/2, random(10, random(width*0.4, width)), int(random(3, 10)), random(TWO_PI));
      } else if (t == 1) {
        float x = width/2;
        float y = height/2;
        float a = random(TWO_PI);
        float r = random(10, width);
        int c = int(random(1, 20));
        float da = TWO_PI/c;
        float tt = width*random(0.05);
        gra.noStroke();
        gra.fill(random(256), random(256), random(256), random(200, 256));
        for (int j = 0; j < c; j++) {
          gra.ellipse(x+cos(a+da*j)*r, y+sin(a+da*j)*r, tt, tt);
        }
      }
    }
  }
  if (fft.getBand(5) > 12) {
    for (int i = 0; i < 1; i++) {
      /*
      gra.stroke(random(256), random(256), random(256), random(200, 256));
       gra.strokeWeight(1);
       gra.noFill();
       poly(gra, random(width), random(height), random(10, 30), int(random(3, 10)), random(TWO_PI));
       */
      float x = random(width);
      float y = random(height);
      float d = random(1, 5);
      gra.noStroke();
      gra.fill(random(256), random(256), random(256), random(200, 256));
      int t = int(random(2));
      if (t == 0) gra.ellipse(x, y, d, d);
      if (t == 1) poly(gra, x, y, random(2, width/10), int(random(3, 10)), random(TWO_PI));
    }
  }
  gra.endDraw();
  glow.set("intensity", fft.getBand(3)*0.09+0.1);
  shader(glow);
  image(gra, 0, 0);
  filter(vignette);
  /*
  if(frameCount >= 300) exit();
   saveFrame("video/####.png");
   */
}

void keyPressed() {
  if (key == 's') saveImage();
}

void saveImage() {
  int n = (new File(sketchPath+"/export")).listFiles().length+1;
  saveFrame("export/"+nf(n, 4)+".png");
}

void poly(PGraphics gra, float x, float y, float d, int cant, float ang) {
  float r = d/2; 
  float da = TWO_PI/cant;
  gra.beginShape();
  for (int i = 0; i < cant; i++) {
    gra.vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
  }
  gra.endShape(CLOSE);
}

class Particula {
  boolean eliminar = false;
  color col; 
  float x, y, t, ang, vel;
  Particula(float x, float y) {
    this.x = x; 
    this.y = y;
    col = color(random(240, 256), random(240, 256), random(240, 256));
    t = random(2);
    vel = random(0.05, 0.08);
    ang = random(TWO_PI);
  }
  void update() {
    ang += random(-0.04, 0.04);
    vel *= 1+random(0.1);
    t -= random(0.08);
    if (t < 0) eliminar = true;
    x += cos(ang)*vel;
    y += sin(ang)*vel;
    show();
  }
  void show() {

    gra.noStroke();
    gra.fill(col);
    gra.ellipse(x, y, t, t);
  }
}

