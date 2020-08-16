int seed = int(random(999999));

void setup() {
  size(700, 700, P3D);
  pixelDensity(2);
  smooth(4);
}


void draw() {

  noiseSeed(seed);
  randomSeed(seed);

  //background(255); 

  float time = millis()*0.001*random(0.4, 1)*0.4;

  int cw = 40*2;
  int ch = 60*2;

  float border = 0;
  float w = (width-border*2);
  float h = (width-border*2);//*1.2;

  float valuesW[][] = new float[cw][ch];
  float totalW[] = new float[ch];

  float valuesH[][] = new float[cw][ch];
  float totalH[] = new float[ch]; 


  float det = random(0.1, 0.08);

  for (int j = 0; j < ch; j++) {
    totalW[j] = 0;
    for (int i = 0; i < cw; i++) {
      valuesW[i][j] = 0.2+pow(noise(i*det, j*det, time*0.1), 4.6);
      totalW[j] += valuesW[i][j];
    }
  }

  for (int i = 0; i < cw; i++) {
    totalH[i] = 0;
    for (int j = 0; j < ch; j++) {
      valuesH[i][j] = 0.2+pow(noise(j*det+40, i*det+32.1, time*0.1), 4.6);
      totalH[i] += valuesH[i][j];
    }
  }

  float xs[][] = new float[cw][ch];
  for (int j = 0; j < ch; j++) {
    float x = border;
    for (int i = 0; i < cw; i++) {
      float ww = w*(valuesW[i][j]/totalW[j]);
      xs[i][j] = x;
      x += ww;
    }
  }

  float ys[][] = new float[cw][ch];
  for (int i = 0; i < cw; i++) {
    float y = border;
    for (int j = 0; j < ch; j++) {
      float hh = h*(valuesH[i][j]/totalH[i]);
      ys[i][j] = y;
      y += hh;
    }
  }
  
  
  float dc = random(0.02);
  
  float dr = random(0.01);
  
  //lights();
  
  noStroke();
  fill(0);
  //ellipseMode(CORNERS);
  //stroke(0);
  for (int j = 0; j < ch-1; j++) {
    for (int i = 0; i < cw-1; i++) {
      fill(getColor(noise(i*dc, j*dc, time*0.1)*2), 20);
      float ww = xs[i+1][j+1]-xs[i+0][j+0];
      float hh = ys[i+1][j+1]-ys[i+0][j+0];
      pushMatrix();
      translate(xs[i][j]+ww*0.5, ys[i][j]+hh*0.5);
      rotateX(time*0.2+i*0.1);
      rotateY(time*0.3+j*0.01);
      rotateZ(time*0.3+(i+j)*0.1);
      ellipse(0, 0, ww*10, hh*2);
      popMatrix();
      //ellipse(xs[i][j]-2, ys[i][j]-2, xs[i+1][j+1]+2, ys[i+1][j+1]+2);
    }
  }


  /*
  for (int j = 0; j < ch; j++) {
   float x = border;
   float y = border;
   float hh = h*(valuesH[0][j]/totalH[j]);
   for (int i = 0; i < cw; i++) {
   float ww = w*(valuesW[i][j]/totalW[j]);
   ellipse(x, y, x+ww, y+hh);
   y = border;
   for (int k = 0; k < i; k++) {
   hh = h*(valuesH[k][j]/totalH[j]);
   y += hh;
   }
   x += ww;
   }
   }
   */
}

void keyPressed() {
  seed = int(random(999999));
}

//int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
//int colors[] = {#FFFFFF, #FEE71F, #FF7991, #26C084, #0E0E0E};
//int colors[] = {#F6C9CC, #119489, #7AC3AB, #F47AD4, #6AC8EC, #5BD5D4, #1E4C5B, #CF350A, #F5A71C};
//int colors[] = {#3102F7, #F6C9CC, #F47AD4, #CF350A, #F5A71C};
//int colors[] = {#FFF4D4, #FD8BA4, #FF5500, #018CC7, #000000, #000000, #000000, #000000, #000000, #000000, #000000, #000000};
//int colors[] = {#FCF0E3, #F3C6BD, #F36B7F, #F8CF61, #3040C4};
//int colors[] = {#FFFFFF, #FFFFFF, #000000, #000000, #000000, #000000, #000000, #000000, #FFFFFF, #000000};
int colors[] = {#F7E843, #409746, #373787, #E12E29, #C8C8C8};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v)%1;
  int ind1 = int(v*colors.length);
  int ind2 = (int((v)*colors.length)+1)%colors.length;
  int c1 = colors[ind1]; 
  int c2 = colors[ind2]; 
  return lerpColor(c1, c2, (v*colors.length)%1);
}
