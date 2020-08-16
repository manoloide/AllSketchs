void miniCity() {


  for (int k = 0; k < 400; k++) {
    float val = random(-0.5, 0.5)*random(1);
    float h = height*random(0.2, 1)*random(0.05, 0.1)*pow((1-abs(val)), 2)*0.6;
    if (random(1) < 0.2) h *= 0.2;
    float w = h*random(0.05, 0.3);
    float x = width*(0.5+val*0.29); 
    float y = height*0.5-h;
    noStroke();
    fill(#56537a);
    rect(x-w*0.5, y, w, h);
    fill(#171347, 40);
    rect(x+w*0.5, y, w*0.3, h);
    fill(#f2f2e9);
    rect(x-w*0.5, y, w, h*0.012);

    if (w < 1) continue;

    h -= h*0.02;
    w = w*0.8;
    int cw = int(random(1, 9));
    int ch = int(random(2, random(20, 50)));
    float ww = w*1./(cw+1);
    float hh = h*1./(ch+1);
    fill(lerpColor(color(255, 255, 0), color(255, 180, 0), random(1)));
    float mw = random(0.3, random(0.3, 0.9));
    float mh = random(0.3, random(0.3, 0.9));
    float www = ww*mw;
    float hhh = hh*mh;
    float prob = random(0.0, 0.6);
    if (random(1) < 0.3) prob = 0;
    for (int j = 0; j < ch-1; j++) {
      for (int i = 0; i < cw; i++) {
        if (random(1) < prob) continue;
        rect(x-w*0.5+ww*(i+1)-www*0.5, y+hh*(j+1)+hhh*0.5, www, hhh);
      }
    }
  }
}
