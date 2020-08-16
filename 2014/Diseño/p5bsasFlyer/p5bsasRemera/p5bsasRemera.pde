import processing.pdf.*;



int paleta[] = {
  #120930, 
  #007D98, 
  #FCBF05, 
  #FA9A00, 
  #E00072
};
PFont fontBold = createFont("Source Code Pro Bold", 420, true);
PFont font = createFont("Source Code Pro Bold", 60, true);
PFont fontChica = createFont("Source Code Pro Bold", 42, true);


void setup() {
  size(800, 800);
  beginRecord(PDF, "line.pdf"); 
  PGraphics mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.noStroke();
  mask.fill(255);//rcol());
  mask.textFont(fontBold);
  mask.textAlign(LEFT, CENTER);
  float desx = width/2-mask.textWidth("P5")/2;
  mask.text("P5", desx, height/2);
  mask.textFont(font);
  mask.text("Buenos Aires", desx, height/2+20);
  mask.textFont(fontChica);
  mask.text("@p5buenosaires", desx, height/2+50);
  mask.endDraw();
  //image(mask, 0, 0);
  for (int i = 0; i < 200000; i++) {
    float d = random(width*0.4);
    float a = random(TWO_PI);
    float x = width/2+cos(a)*d;
    float y = height/4+sin(a)*d;
    float t = map(d, 0, width*0.4, 4, 2);
    fill(rcol()); 
    noStroke();
    if(brightness(mask.get(int(x), int(y))) > 200)
    ellipse(x, y, t, t);
  }
  endRecord();
}


int rcol() {
  return paleta[int(random(paleta.length))];
}
