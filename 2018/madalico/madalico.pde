int seed = int(random(9999999));

PGraphics renders[][];

int countScreens = 4;
float widthScreen = -1;
float heightScreen = -1;

void setup() {
  size(640, 640); 
  pixelDensity(2);
  generate();
}


void draw() {
  
  float time = millis()*0.001;
  
  randomSeed(seed);
  
  
  
  float maxSize = max(widthScreen, heightScreen);
  for (int j = 0; j < countScreens; j++) {
    for (int i = 0; i < countScreens; i++) {
      
      PGraphics r = renders[i][j];
      
      float renderTime = time*random(1);
      
      r.beginDraw();
      r.translate(r.width*0.5, r.height*0.5);
      r.rotate(renderTime*random(-1, 1));
      r.rectMode(CENTER);
      float ms = (0.8+cos(renderTime*random(-20, -20)*random(1))*0.2);
      float ss = maxSize*(cos(renderTime*random(1)*random(1))*0.5+0.5)*ms;
      if(random(1) < 0.05) r.noStroke();
      else r.stroke(0, 20);
      float gray = (cos(renderTime*random(1))*0.5+0.5)*255;
      r.fill(gray, 2);
      r.fill(getColor(renderTime*random(1)), 20);
      
      r.rect(0, 0, ss, ss);
      r.endDraw();
      
      image(renders[i][j], i*widthScreen, j*heightScreen);
    }
  }
}

void keyPressed() {
  generate();
}

void generate() {
  
  seed = int(random(999999));
  
  background(0);
  countScreens = int(random(4, 27));
  widthScreen = width*1./countScreens;
  heightScreen = height*1./countScreens;
  renders = new PGraphics[countScreens][countScreens];
  for (int j = 0; j < countScreens; j++) {
    for (int i = 0; i < countScreens; i++) {
      renders[i][j] = createGraphics(int(widthScreen), int(heightScreen));
      renders[i][j].beginDraw();
      renders[i][j].background(random(255));
      renders[i][j].endDraw();
    }
  }
}

int colors[] = {#EDD198, #FCB84C, #FF614C, #0077C4, #55C3C6, #F396BF, #202020};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
