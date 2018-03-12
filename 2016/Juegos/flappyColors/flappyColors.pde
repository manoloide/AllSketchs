int paleta []= {
  #F8F3D4, 
  #00B8A9, 
  #F6416C, 
  #FFDE7D
};

Ball ball;

void setup() {
  size(460, 640);
  smooth(8);
  ball = new Ball();
}

void draw() {
  background(paleta[0]);

  ball.update();
}

void mousePressed() {
  ball.press();
}


class Ball {
  boolean pause;
  float x, y, s;
  float vy;
  int cc;
  float ptime;
  Ball() {
    init();
    pause = true;
  }

  void init() {
    x = width/2; 
    y = height/2;
    vy = 0;
    s = 36;
  }

  void update() {
    if (!pause) {
      ptime += 1./60;
      vy += 0.7;
      y += vy;
    }
    
    show();
  }

  void show() {
    noStroke();
    color col = paleta[1+cc];
    float tt = ptime*3;

    if (tt < 1) { 
      color ant = paleta[1+(cc+2)%3];
      fill(ant);
      ellipse(x, y, s, s);
      fill(col);
      float amp = sin(tt*HALF_PI);
      ellipse(x, y, s*amp, s*amp);
    } else {
      fill(col);
      ellipse(x, y, s, s);
    }
  }

  void press() {
    cc++;
    cc %= 3;
    vy = -14;
    ptime = 0;
    pause = false;
  }
}

