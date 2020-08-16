PFont fonts[];

void setup() {
  size(720, 720);
  smooth(8);
  pixelDensity(2);
  String sources[] = {"Saira-Black", "Saira-ExtraBold", "Saira-Bold", "Saira-SemiBold", "Saira-Medium", "Saira-Regular", "Saira-Light", "Saira-ExtraLight", "Saira-Thin"};
  fonts = new PFont[sources.length];
  for (int i = 0; i < fonts.length; i++) {
    fonts[i] = createFont(sources[i], 16, true);
  }
}

int seed = int(random(9999999));

void draw() {

  float time = millis()/1000.;

  randomSeed(seed);
  noiseSeed(seed);

  background(0);
  textAlign(CENTER, CENTER);
  float ss = 16; 
  float des = random(1000);
  float det = random(1);

  String chars = "abcdefghijklmnñopqrtsuvwxyz";
  char cha = chars.charAt(int(time%chars.length()));
  for (int j = -1; j <= height/ss+1; j++) {
    float dx = 0;//(time*random(-4, 4))%1;
    float desf = time+cos(j*0.09+time*0.8)*0.8;
    for (int i = -1; i <= width/ss+1; i++) {
      float xx = (i+0.5+dx)*ss;
      float yy = (j+0.3)*ss;
      float val = abs(i*0.08+desf)%1.0;
      int font = constrain(int(map(abs(val-0.5)*2, 0, 1, 0, fonts.length)), 0, fonts.length-1);//int(noise(des+(i+time)*det, des+(j+time)*det)*fonts.length);
      textFont(fonts[font]);
      text(fonts.length-font, xx, yy);
    }
  }
  for (int i = 0; i < fonts.length; i++) {
  }
}

void keyPressed() {
  seed = int(random(999999999));
}