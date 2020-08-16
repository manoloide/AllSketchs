PImage srcImage;
PGraphics maskImage;
PShader maskShader;
PShader edges;  

void setup() {
  size(960, 540, P2D);
  smooth(8);
  pixelDensity(2);
  
  
  srcImage = loadImage("leaves.jpg");
  maskImage = createGraphics(srcImage.width, srcImage.height, P2D);
  maskImage.noSmooth(); 
  edges = loadShader("edges.glsl");
  maskShader = loadShader("mask.glsl");
  maskShader.set("mask", maskImage);
  background(255);
}

void draw() { 
  maskImage.beginDraw();
  maskImage.background(0);
  if (mouseX != 0 && mouseY != 0) {  
    maskImage.noStroke();
    maskImage.fill(255, 0, 0);
    maskImage.ellipse(mouseX, mouseY, 50, 50);
  }
  maskImage.endDraw();

  shader(edges);
  image(srcImage, 0, 0, width, height);
}
