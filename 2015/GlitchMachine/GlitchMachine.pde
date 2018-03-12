import processing.video.*; //<>//

boolean Click;
Gui gui;
Pelicula pelicula;
PImage ori, glitch;

Boton bopen, bsave, bglitch, brnd;
Slider disRed, disGreen, disBlue, disHor, osc, waveAmp, amplitud;
Toggle tline, tcolor, ttrash, twave, tscale, tplay;

void setup() {
  size(920, 680);
  frame.setResizable(true); 
  frameRate(30);
  imageMode(CENTER);

  gui = new Gui("Setup");
  gui.addElement(bopen = new Boton("Open", 10, 30, 60, 20));
  gui.addElement(bsave = new Boton("Save", 80, 30, 60, 20));
  gui.addElement(disRed = new Slider("displace red", 10, 60, 130, 20, -32, 32, 0));
  gui.addElement(disGreen = new Slider("displace green", 10, 90, 130, 20, -32, 32, 0));
  gui.addElement(disBlue = new Slider("displace blue", 10, 120, 130, 20, -32, 32, 0));
  gui.addElement(disHor = new Slider("displace horizontal", 10, 150, 130, 20, 0, 64, 0));
  gui.addElement(waveAmp = new Slider("wave amplitud", 10, 180, 130, 20, -10, 40, 0));
  gui.addElement(amplitud = new Slider("amplitud", 10, 450, 130, 20, 0, 8, 0));

  gui.addElement(osc = new Slider("osc line", 10, 210, 130, 20, -10, 50, 10));
  gui.addElement(tline = new Toggle("fx lines", 10, 240, 20, 20, false));
  gui.addElement(tcolor = new Toggle("fx color", 10, 270, 20, 20, false));
  gui.addElement(ttrash = new Toggle("fx trash", 10, 300, 20, 20, false));
  gui.addElement(twave = new Toggle("fx wave", 10, 330, 20, 20, false));
  gui.addElement(tscale = new Toggle("scale to screen", 10, 360, 20, 20, true));
  gui.addElement(tplay = new Toggle("play", 10, 390, 20, 20, true));

  gui.addElement(bglitch = new Boton("Glitch me!", 10, 550, 80, 20));
  gui.addElement(brnd = new Boton("Rnd", 100, 550, 40, 20));

  ori = loadImage("https://scontent-b-mia.xx.fbcdn.net/hphotos-xpa1/v/t1.0-9/10341697_10205114057547982_1703331953423491841_n.jpg?oh=49b53c3f722f4c68a7ee30567bdac268&oe=556ECEC7");
  glitch = createImage(ori.width, ori.height, RGB);
  glitch.copy(ori, 0, 0, ori.width, ori.height, 0, 0, ori.width, ori.height);
}

void draw() {
  background(80);
  fill(240);
  textAlign(LEFT, TOP);
  if (glitch == null) text("Open image or video for glitching", 30, 30);

  if (glitch != null) {
    if (pelicula != null && tplay.val) pelicula.update();
    float pro = 1;
    if (tscale.val && (glitch.width > width-20 || glitch.height > height-20)) {
      if (glitch.width/width > glitch.height/height) {
        pro = (width-20)*1./glitch.width;
      } else {
        pro = (height-20)*1./glitch.height;
      }
    }

    int w = int(glitch.width*pro);
    int h = int(glitch.height*pro);
    image(glitch, width/2, height/2, w, h);
  }
  if (pelicula != null) pelicula.show();
  gui.update();
  if (bopen.click) {
    openImage();
  }
  if (bsave.click) {
    saveImage();
  }
  if (bglitch.click || tplay.val) {
    glitchear();
  }
  if (brnd.click) {
    disRed.rnd();
    disGreen.rnd();
    disBlue.rnd();
    disHor.rnd();
    osc.rnd();
    waveAmp.rnd();
    tline.rnd(); 
    tcolor.rnd();
    ttrash.rnd();
    twave.rnd();
    amplitud.rnd();

    glitchear();
  }
  Click = false;
}

void mousePressed() {
  Click = true;
}

void movieEvent(Movie m) {
  m.read();
}

void glitchear() {
  if (ori == null) return;
  glitch = createImage(ori.width, ori.height, RGB);
  glitch.copy(ori, 0, 0, ori.width, ori.height, 0, 0, ori.width, ori.height);

  float time = 1;
  if (tplay.val) {
    time =  noise(20+(frameCount)*0.08) * noise(30+(frameCount)*0.054) * noise(16+(frameCount)*0.00347)*amplitud.val;
  }

  color col = color(0, 200, 180);
  float mez = 0;//random(1);
  float des = 0;
  float ao = osc.val;

  glitch.loadPixels();
  if (!tline.val) ao = 0;
  for (int j = 0; j < glitch.height; j++) {
    for (int i = 0; i < glitch.width; i++) {
      if (random(glitch.width+glitch.height) < 1*time && i%8 == 0 && j%8 == 0) {
        col = color(random(256), random(256), random(256));
        if (tcolor.val) {
          mez = random(0.5);
        } 
        des = random(-disHor.val, disHor.val)*time;
      }
      int x = i;//(int) random(glitch.width);
      int y = j;//int(j+noise(20+j*0.02)*200);//(int) random(glitch.height); 
      float o = (j%2)*ao;
      float r, g, b;
      float d = des;
      if (twave.val) {
        d += (noise(j*0.02+frameCount)*2-1)*waveAmp.val*time;
      }
      if (ttrash.val) {
        r = red(ori.get(int(x+disRed.val*d), y))-o;
        g = green(ori.get(int(x+disGreen.val*d), y))-o;
        b = blue(ori.get(int(x+disBlue.val*d), y))-o;
      } else {
        r = red(ori.get(int(x+disRed.val+d), y))-o;
        g = green(ori.get(int(x+disGreen.val+d), y))-o;
        b = blue(ori.get(int(x+disBlue.val+d), y))-o;
      }
      glitch.set(x, y, lerpColor(color(r, g, b), col, mez*time));
    }
  }
  /*
  for (int j = 0; j < glitch.height; j++) {
   for (int i = 0; i < glitch.width; i++) {
   if(noise((i/16)*glitch.height+(j/16)) > 0.8){
   color c = glitch.get(i, j);
   glitch.set(i, j, color(255-red(c), 255-green(c), 255-blue(c)));
   }
   }
   }
   */
  glitch.updatePixels();
}


void openImage() {
  selectInput("Seleccionar Sprite:", "fileSelected");
}

void saveImage() {
  selectOutput("Select a file to write to:", "fileSaved");
}

void fileSaved(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    glitch.save(selection.getAbsolutePath());
  }
}
void fileSelected(File sel) {
  if (sel != null) {
    String[] stg = (split(sel.getAbsolutePath(), "."));
    String format = stg[stg.length-1];
    if (format.equals("png") || format.equals("gif") || format.equals("jpg") || format.equals("tga") || format.equals("tiff")) {
      pelicula = null;
      ori = loadImage(sel.getAbsolutePath());
      glitch = createImage(ori.width, ori.height, RGB);
      glitch.copy(ori, 0, 0, ori.width, ori.height, 0, 0, ori.width, ori.height);
    }
    //if(format.equals("mov")){
    else {
      Movie movie = new Movie(this, sel.getAbsolutePath());
      pelicula = new Pelicula(movie);
      glitchear();
      /*
       try{
       Movie movie = new Movie(this, sel.getAbsolutePath());
       } catch (IOException e) {
       println("dsdsdfd");
       } 
       */
    }
  }
}

class Pelicula {
  float x, y, w, h;
  int frame, movFrameRate;
  Movie movie;
  Pelicula(Movie movie) {
    this.movie = movie; 
    frame = 0;

    w = 400;
    h = 120;
    x = 15;
    y = height-15-h;
  movie.play();
    movFrameRate = int(movie.frameRate);
    movie.pause();
  }
  void update() {
    setFrame(frame);
    frame++;
    ori = pelicula.movie.get();
  }

  void show() {
    fill(60);
    rect(x, y, w, h);
    textAlign(LEFT, TOP);
    fill(250);
    text(frame+"/"+getLength(), x+4, y+4);
    float posx = map(frame, 0, getLength(), 0, w);
    stroke(250);
    line(x+posx, y, x+posx, y+h);
  }

  void setFrame(int n) {
    movie.play();

    // The duration of a single frame:
    float frameDuration = 1.0 / movFrameRate;

    // We move to the middle of the frame by adding 0.5:
    float where = (n + 0.5) * frameDuration; 

    // Taking into account border effects:
    float diff = movie.duration() - where;
    if (diff < 0) {
      where += diff - 0.25 * frameDuration;
    }

    movie.jump(where);
    movie.pause();
  } 

  int getLength() {
    return int(movie.duration() * movFrameRate);
  }
}
