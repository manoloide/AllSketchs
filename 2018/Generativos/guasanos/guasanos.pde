void setup() {
  size(800, 800);
  pixelDensity(2);
}


void draw() {

  background(255); 

  float time = millis()*0.0001;

  int cw = 40;
  int ch = 60;

  float border = 20;
  float w = (width-border*2);
  float h = (width-border*2);//*1.2;

  float valuesW[][] = new float[cw][ch];
  float totalW[] = new float[ch];

  float valuesH[][] = new float[cw][ch];
  float totalH[] = new float[ch]; 


  float det = 0.02;

  for (int j = 0; j < ch; j++) {
    totalW[j] = 0;
    totalH[j] = 0;
    for (int i = 0; i < cw; i++) {
      valuesW[i][j] = 0.2+noise(i*det, j*det, time)*0.8;
      totalW[j] += valuesW[i][j];
      valuesH[i][j] = 0.2+noise(j*det, i*det, time)*0.8;
      totalH[i] += valuesH[i][j];
    }
  }

  for (int i = 0; i < cw; i++) {
    for (int j = 0; j < ch; j++) {
    }
  }

  ellipseMode(CORNERS);
  for (int j = 0; j < ch; j++) {
    float x = border;
    float y = border;
    for (int i = 0; i < cw; i++) {
      float ww = w*(valuesW[i][j]/totalW[j]);
      float hh = h*(valuesH[i][j]/totalH[j]);
      ellipse(x, y, x+ww, y+hh);
      x += ww;
      y += hh;
    }
  }
}
