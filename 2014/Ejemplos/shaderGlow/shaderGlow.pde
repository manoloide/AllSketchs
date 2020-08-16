PGraphics gra;
PShader blur, glow;

void setup() {
  //tenes que estar en el modo P2D o P3D
  size(800, 800, P2D); 

  gra = createGraphics(600, 600, P2D);
  
  blur = loadShader("blur.glsl"); 
  glow = loadShader("glow.glsl");
  glow.set("iResolution", float(width), float(height)); 
}

void draw() {
  background(0);
  
  blur.set("time", (float)millis() / 5000.0);
  //tiempo de titalado del glow
  glow.set("iGlobalTime", frameCount*0.04);
  gra.beginDraw();
  //gra.background(0);
  //aca va lo que dibuja;
  //no tenes que limpiar la pantalla por que el effecto no funciona
  randomSeed(5);
  for (int i = 0; i < 30; i++) {
    float x = width * (0.0+noise(i+frameCount*0.001));
    float y = height * (0.0+noise(i+frameCount*0.001+20.34));
    float tt = random(10, 40);
    gra.noStroke();
    color col = (random(1) < 0.5)? #37549B : #58CB87;
    gra.fill(col);
    gra.ellipse(x, y, tt, tt);
  }
  gra.endDraw();
  //efecto uno fundamenta no tener background, el efecto lo borra solo
  //gra.filter(blur);

  //efecto glowww 
  //shader(glow);
  image(gra, width/2-gra.width/2, height/2-gra.height/2);
}
