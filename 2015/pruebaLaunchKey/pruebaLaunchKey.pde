import themidibus.*;

LaunchKey lk;
MidiBus bus; 

void setup() {
  size(800, 400);
  background(0);
  bus = new MidiBus(this, 0, 0); 
  lk = new LaunchKey();
}

void draw() {
  background(90);
  pushMatrix();
  translate(100, 20);
  for (int i = 0; i < lk.knob.length; i++) {
    float tt = 40; 
    float sep = 0.2;
    float x = tt*(1+sep)*(i+0.5);
    float y = tt*(1+sep)*0.5;
    stroke(0, 20);
    fill(20);
    ellipse(x, y, tt, tt);
    float a = map(lk.knob[i].get(), 0, 1, PI/2, PI*2.5);
    stroke(240);
    strokeWeight(2);
    line(x, y, x+cos(a)*tt*0.5, y+sin(a)*tt*0.5);
    strokeWeight(1);
  }
  popMatrix();
  pushMatrix();
  translate(100, 80);
  for (int i = 0; i < lk.pad.length; i++) {
    float tt = 40; 
    float sep = 0.2;
    float x = tt*sep+tt*(1+sep)*(i-((i/4)%2)*4-((i/8)*2-1)*2-2);
    float y = ((i%8 < 4)? tt+tt*sep*2 : tt*sep);
    stroke(0, 20);
    fill(220);    
    rect(x, y, tt, tt, 3);
    if (lk.pad[i].press) {
      fill(#FF2C2C, 200+lk.pad[i].get()*56); 
      rect(x, y, tt, tt, 3);
    }
  }
  popMatrix();
  pushMatrix();
  translate(500, 145);
  for (int i = 0; i < lk.control.length; i++) {
    float tt = 26; 
    float sep = 0.2;
    float x =  tt*(1+sep)*i;
    float y = tt*sep;
    fill(20);
    if (lk.control[i].press) {
      fill(60);
    }
    rect(x, y, tt, tt, 3);
  }
  popMatrix();
  pushMatrix();
  translate(14, 200);
  for (int i = 48; i < 73; i++) {
    float tt = 16; 
    float sep = 0.2;
    float x =  tt*(1+sep)*(i-48);
    float y = tt*sep;
    if (((i%12)%2 == 0 && (i%12) < 5) || ((i%12)%2 == 1 && (i%12) > 4)) {
      fill(220);
    } else {
      fill(22);
    }
    if (lk.note[i].press) {
      if (((i%12)%2 == 0 && (i%12) < 5) || ((i%12)%2 == 1 && (i%12) > 4)) {
        fill(180);
      } else {
        fill(0);
      }
    }
    rect(x, y, tt, tt*10, 1);
  }
  popMatrix();
  lk.update();
}

void rawMidi(byte[] data) { 
  lk.recibe(data);
}
