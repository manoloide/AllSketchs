void setup() {
  size(800, 800);
  generar();
}

void draw() {
  background(20); 
  stroke(250);

  float t = width*0.6;
  strokeWeight(1.5);
  colorMode(HSB, 256, 256, 256);
  stroke((frameCount)%256, 120, 200);
  for (int i = 0; i < 30; i++) {
    for (int j = 0; j < t; j++) {
      float a1 = 1-sin(abs(-t/2+j)/t*PI/2)*2;
      a1 = pow(a1, 2);
      if (a1 < 0.1) a1 = 0.1;
      float x1 = width/2-t/2+j;
      float y1 = height/2+t/2-i*8;
      float dy1 = noise(j*0.04+(frameCount*1.02+i)*20)*40*a1;
      float x2 = width/2-t/2+(j-1);
      float y2 = height/2+t/2-i*8;
      float dy2 = noise((j-1)*0.04+(frameCount*1.02+i)*20)*40*a1;
      //stroke((((255)/58.)*i+frameCount)%256, 120, 200);
      if (i == 29) {
        float m = map(frameCount%60, 0, 60, 1.5, -0.5);
        if(m < 0) m = 0;
        if(m > 1) m = 1;
        float m1 = int(cos((frameCount+j)*0.2)+1)*30;
        float m2 = int(cos((frameCount+j-1)*0.2)+1)*30;
        y1 -= frameCount%60;
        dy1 = dy1*m + m1*(1-m); 
        y2 -= frameCount%60;
        dy2 = dy2*m + m2*(1-m);
        
      }
      line(x1, y1-dy1, x2, y2-dy2);
    }
  }


  strokeWeight(20);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, t+60, t+60);

  //noiseee(-8);
}

void keyPressed() {
  generar();
}

void generar() {
  background(20); 
  stroke(250);

  float t = width*0.7;
  strokeWeight(1);
  for (int i = 0; i < 20; i++) {
    for (int j = 0; j < t; j++) {
      line(width/2-t/2+j, height/2+t/2-noise(j*0.04+i*100)*20-i*10, width/2-t/2+(j-1), height/2+t/2-noise((j-1)*0.04+i*100)*20-i*10);
    }
  }


  strokeWeight(4);
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, t, t, 1);

  noiseee(-20);
}

void noiseee(float val) {
  for (int j = 0; j < height; j++) {
    for (int i = 0; i < width; i++) {
      color col = get(i, j); 
      float bri = random(val);
      set(i, j, color(red(col)+bri, green(col)+bri, blue(col)+bri));
    }
  }
}
