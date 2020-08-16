int fps = 30;
float seconds = 5;
boolean export = true;

int frames = int(fps*seconds);
float time = 0;

void setup() {
  size(640, 640);
  //if(!export) pixelDensity(2);
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
  rotate(time*HALF_PI);
  scale(1+cos(time*TWO_PI)*0.01);

  float mix = ElasticEaseOut(time%0.5, 0, 1, 0.5);


  int cc = 120; 

  PVector p1[] = new PVector[cc];
  PVector p2[] = new PVector[cc];

  float ia = PI*1.5;
  float r = width*0.2;

  translate(r*2*time, 0);
  int lad1 = cc;
  float da = TWO_PI/lad1;
  float cr = 0.85;
  for (int i = 0; i < lad1; i++) {
    float x1 = cos(ia+da*i)*r*cr;
    float y1 = sin(ia+da*i)*r*cr;
    float x2 = cos(ia+da*i+da)*r*cr;
    float y2 = sin(ia+da*i+da)*r*cr;
    for (int j = 0; j < cc/lad1; j++) {
      p1[i*(cc/lad1)+j] = new PVector(map(j, 0, cc/lad1, x1, x2), map(j, 0, cc/lad1, y1, y2));
    }
  }

  int lad2 = 4;
  da = TWO_PI/lad2;
  for (int i = 0; i < lad2; i++) {
    float x1 = cos(ia+da*i)*r;
    float y1 = sin(ia+da*i)*r;
    float x2 = cos(ia+da*i+da)*r;
    float y2 = sin(ia+da*i+da)*r;
    for (int j = 0; j < cc/lad2; j++) {
      p2[i*(cc/lad2)+j] = new PVector(map(j, 0, cc/lad2, x1, x2), map(j, 0, cc/lad2, y1, y2));
    }
  }

  for (int dy = -8; dy < 9; dy++) {
    for (int dx = -8; dx < 9; dx++) {
      pushMatrix();

      translate(r*2*dx, r*2*dy);
      noStroke();
      fill(0);
      beginShape();
      for (int i = 0; i < cc; i++) {
        float xx = map(mix, 0, 1, p1[i].x, p2[i].x);
        float yy = map(mix, 0, 1, p1[i].y, p2[i].y);
        if (time >= 0.5) {
          xx = map(mix, 0, 1, p2[i].x, p1[i].x);
          yy = map(mix, 0, 1, p2[i].y, p1[i].y);
        }
        //xx = p2[i].x;
        //yy = p2[i].y;
        vertex(xx, yy);
      }
      endShape(CLOSE);
      popMatrix();
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