int fps = 30;
float seconds = 4;
boolean export = false;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
  //if (!export) pixelDensity(2);
  frameRate(fps);
}

void draw() {
  if (export) time = map(frameCount-1, 0, frames, 0, 1);
  else time = map((millis()/1000.)%seconds, 0, seconds, 0, 1);

  render();

  if (export) {
    if (time >= 1) exit();
    else saveFrame("export/f####.gif");
  }
}

void render() {
  background(255);
  translate(width/2, height/2); 
  rotate(time*PI);

  rectMode(CENTER);
  noStroke();
  fill(0);

  blendMode(DARKEST);
  fill(255);
  float ww = 80+cos(time*TWO_PI+PI)*30;
  float hh = 70+cos(time*TWO_PI)*20;
  ww = ElasticEaseOut(cos(time*TWO_PI+PI*0.3)*0.5+0.5, 30, 60, 2);
  hh = ElasticEaseOut(cos(time*TWO_PI)*0.5+0.5, 40, 60, 2);
  int cw = int(width*1.4/ww)+3;
  int ch = int(height*1.4/hh)+3;
  for (int j = -ch/2; j < ch/2; j++) {
    for (int i = -cw/2; i < cw/2; i++) {
      fill(colors[0]);
      float dx = ww*time*2;
      if (j%2==0) dx *= -1;
      dx = 0;
      if ((i+j)%2 == 0) ellipse(i*ww+dx, j*hh, ww*0.7, hh*0.7);
      fill(colors[1]);
      if (abs((i+j)%2) == 1) ellipse(j*hh, i*ww, hh, ww);
    }
  }
}

float ElasticEaseOut(float t, float b, float c, float d) {
  if (t==0) return b;  
  if ((t/=d)==1) return b+c;  
  float p=d*.3f;
  float a=c; 
  float s=p/4;
  return (a*pow(2, -10*t) * sin( (t*d-s)*(2*PI)/p ) + c + b);
}

int colors[] = {#e94c20, #0057BB};