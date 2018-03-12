void drawInterface() {
  background(#151121);

  translate(width/2, height/2, cos(millis()*0.0006)*40);

  randomSeed(0);

  int cw = 8; 
  int ch = 10;

  float w = width/cw;
  float h = height/ch;

  float t = (millis()/1000.)%5;

  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      rect(w*i-width/2, h*j-height/2, w, h);
    }
  }

  /*
  float d = width*0.18;
   int cc = 18;
   float da = TWO_PI/cc;
   float s = 6;
   float tt = 2;
   float time = (millis()/1000.)%tt;
   float dt = tt/cc;
   for (int i = 0; i < cc; i++) {
   float t = constrain(map(time, dt*(i-1), dt*i, 0, 1), 0, 1);
   if (dt*(i-1) < time) {
   float a = PI*1.5+da*(i-cos(t*HALF_PI));
   float x = cos(a)*d;
   float y = sin(a)*d;
   ellipse(x, y, s, s);
   }
   }
   */


  filter(post);
}


void grid(float w, float h, int cw, int ch) {
  float dx = w/cw;
  float dy = h/ch;
  float mw = w/2.;
  float mh = h/2.;
  float v;
  for (int i = 0; i <= cw; i++) {
    v = dy*i-mh;
    line(-mw, v, mw, v);
  }
  for (int i = 0; i <= cw; i++) {
    v = dx*i-mw;
    line(v, -mh, v, mh);
  }
}

