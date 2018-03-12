import ddf.minim.*;

Minim minim;

ArrayList<Sampler> samples;
boolean Click, kclick;
JSONArray jsamples;

void setup() {
  size(800, 600);
  minim = new Minim(this);

  samples = new ArrayList<Sampler>();
  loadJSON();
}

void draw() {
  background(60);

  int bor = 20;
  int sep = 10;

  for (int i = 0; i < samples.size (); i++) {
    Sampler s = samples.get(i);
    int cw = (width-bor)/(s.w+sep);
    s.x = bor+(i%cw)*(s.w+sep);
    s.y = bor+(i/cw)*(s.h+sep);
    s.update();
    if (s.remove) samples.remove(i--);
  }  

  int w = 100; 
  int h = 120;
  int cw = (width-bor)/(w+sep);
  int i = samples.size ();
  int x = bor+(i%cw)*(w+sep);
  int y = bor+(i/cw)*(h+sep); 
  noStroke();
  fill(150);
  //rect(x, y, w, h, 2);
  ellipse(x+w/2, y+w/2, w*0.6, w*0.6);
  fill(240);
  GPlus(x+w/2, y+w/2, w*0.3);

  if (dist(mouseX, mouseY, x+w/2, y+w/2) < w*0.4 && Click) {
    selectInput("Seleccionar audio:", "fileSelected");
  }


  Click = false;
  kclick = false;
}

void mousePressed() {
  Click = true;
}

void keyPressed() {
  kclick = true;
}

void dispose() {
  saveJSON();
}

void loadJSON() {
  File f = (new File(sketchPath("set.cf")));
  if (f.exists()) {
    jsamples = loadJSONArray("set.cf");
  } else {
    jsamples = new JSONArray();
  }

  samples = new ArrayList<Sampler>();

  for (int i = 0; i < jsamples.size (); i++) {
    println(jsamples.getString(i));
    samples.add(new Sampler(jsamples.getString(i)));
  }
}

void saveJSON() {


  jsamples = new JSONArray();
  for (int i = 0; i < samples.size (); i++) {
    jsamples.append(samples.get(i).src);
  }

  saveJSONArray(jsamples, "set.cf");
}

void fileSelected(File sel) {
  if (sel != null) {
    String[] stg = (split(sel.getAbsolutePath(), "."));
    String format = stg[stg.length-1];

    samples.add(new Sampler(sel.getAbsolutePath()));
    saveJSON();
  }
}

class Sampler {
  AudioPlayer sample;
  boolean play, loop, remove, recKey;
  char keyPress;
  int x, y, w, h; 
  String src, name; 
  Sampler(String src) {
    this.src = src;
    name =  (new File(src)).getName();
    w = 100;
    h = 120;
    loadSampler();
  }
  void update() {
    if ((dist(mouseX, mouseY, x+w/2, y+w/2) < w*0.6*0.5 && Click) || (key == keyPress && kclick)) {
      play = !play;
      if (play) {
        if (loop) sample.loop();
        else sample.play();
      } else {
        sample.pause();
        sample.rewind();
      }
    }

    if (play && !loop && !sample.isPlaying()) {
      play = false;
      sample.rewind();
    }

    if (recKey && keyPressed) {
      keyPress = key; 
      recKey = false;
    }
    show();
  }
  void show() {
    noFill();
    stroke(0, 5);
    for (int i = 6; i >= 1; i--) {
      strokeWeight(i);
      rect(x, y, w, h, 2);
    }
    noStroke();
    fill(100);
    rect(x, y, w, h, 2);
    if (play || true) {
      float time = map(sample.position(), 0, sample.length()-400, 0, TWO_PI);
      fill(250);
      arc(x+w/2, y+w/2, w*0.6+3, w*0.6+3, -PI/2, time-PI/2);
      /*
      fill(90);
       arc(x+w/2, y+w/2, w*0.6+3, w*0.6+3, time-PI/2, PI*1.5);
       */
    }
    fill(150);
    ellipse(x+w/2, y+w/2, w*0.6, w*0.6);    
    fill(240);
    if (play) {
      GPause(x+w/2, y+w/2, w*0.3);
    } else {
      GPlay(x+w/2, y+w/2, w*0.3);
    }

    fill(0);
    rect(x, y+w, w, h-w, 0, 0, 2, 2);
    int cc = 3;
    float cw = w*1./cc;
    String valores[] = {
      "key", "lop", "rem"
    };
    for (int i = 0; i < cc; i++) {
      int sob = 0;
      if (mouseX >= x+cw*i && mouseX < x+cw*i+cw && mouseY >= y+w && mouseY < y+w+(h-w)) {
        sob = 10;
        if (Click) {
          if (i == 0) recKey = !recKey;
          if (i == 1) loop = !loop;
          if (i == 2) remove = true;
        }
      }
      if (i == 0 && recKey) sob += 20;
      if (i == 1 && loop) sob += 20;

      fill(30+i*3+sob);
      rect(x+cw*i, y+w, cw, h-w, 0, 0, (i == cc-1)? 2 : 0, (i == 0)? 2 : 0);
      fill(250);
      textAlign(CENTER, CENTER);
      text(valores[i], x+cw*(i+0.5), y+w+(h-w)*0.5);
    }
    textAlign(LEFT, TOP);
    text(name, x+6, y+2);
  }
  void loadSampler() {
    sample = minim.loadFile(src, 512);
    if (sample == null) remove = true;
  }
}

void GPause(float x, float y, float dim) {
  float r = dim*0.5;
  float a = PI/4;
  float da = TWO_PI/4;
  beginShape();
  for (int i = 0; i < 4; i++) {
    vertex(x+cos(da*i+a)*r, y+sin(da*i+a)*r);
  }
  endShape();
}

void GPlay(float x, float y, float dim) {
  float r = dim*0.5;
  float da = TWO_PI/3;
  beginShape();
  for (int i = 0; i < 3; i++) {
    vertex(x+cos(da*i)*r, y+sin(da*i)*r);
  }
  endShape();
}

void GPlus(float x, float y, float dim) {
  float r = dim*0.5;
  float a = PI/8;
  float da = TWO_PI/8;
  beginShape();
  vertex(x+r/3, y+r);
  vertex(x-r/3, y+r);
  vertex(x-r/3, y+r/3);
  vertex(x-r, y+r/3);
  vertex(x-r, y-r/3);
  vertex(x-r/3, y-r/3);
  vertex(x-r/3, y-r);
  vertex(x+r/3, y-r);
  vertex(x+r/3, y-r/3);
  vertex(x+r, y-r/3);
  vertex(x+r, y+r/3);
  vertex(x+r/3, y+r/3);
  endShape();
}
