PFont chivo;

void setup() {
  size(720, 720);
  //pixelDensity(2);
  chivo = createFont("Chivo-Light", 20, true);
  textFont(chivo);
}

void draw() {
  background(colors[(frameCount/60)%colors.length]);

  textAlign(CENTER, TOP);
  //text("NO DATA", width/2, height/2);

  String text = " NO DATA ";
  for (int i = 0; i < 4; i++) {
    text += text;
  }
  float ss = 20; 
  int cc = int(width/ss)/2;
  for (int i = -cc; i <= cc; i++) {
    float dx = cos(frameCount*0.007+i*0.1)*width*0.5;
    float dy = i*ss;
    text(text, width/2+dx, height/2+dy);
  }
}

int colors[] = {#DB231A, #EFBD0C, #1F5DA6};