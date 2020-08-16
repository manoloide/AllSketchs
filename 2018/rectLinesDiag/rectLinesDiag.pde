void setup() {
  size(640, 640);
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  float time = millis()*0.001;
  rectLines(100, 100, 200, 20, 10, 0, time%1);
  rectLines(500, 100, 20, 200, 10, 1, time%1);
  rectLines(350, 100, 100, 100, 10, 0, time%1);
  rectLines(50, 50, mouseX-50, mouseY-50, 8, 1, time%1);//(time%10 < 5)? 0 : 1, time%1);
}

void rectLines(float x, float y, float w, float h, float s, int dir, float tt) {
  float des = s*tt;
  //rect(x, y, w, h);
  if (dir == 0) {
    for (float i = des; i < max(w, h); i+=s) {
      float difw = constrain(i-w, 0, h);
      float difh = constrain(i-h, 0, w);
      line(x+i-difw, y+difw, x+difh, y+i-difh);
    }
    for (float i = s-(max(w, h)-des)%s; i < min(w, h); i+=s) {
      float dw = constrain(w-h, 0, h+w);
      float dh = constrain(h-w, 0, h+w);
      line(x+dw+i, y+h, x+w, y+dh+i);
    }
  }
  if (dir == 1) {
    for (float i = des; i < max(w, h); i+=s) {
      float difw = constrain(i-w, 0, h);
      float difh = constrain(i-h, 0, w);
      line(x+w-i+difw, y+difw, x+w-difh, y+i-difh);
    }
    for (float i = s-(max(w, h)-des+s)%s; i < min(w, h); i+=s) {
      float dh = constrain(h-w, 0, h+w);
      float dw = constrain(w-h, 0, h+w);
      line(x+w-dw-i, y+h, x, y+dh+i);
    }
  }
}