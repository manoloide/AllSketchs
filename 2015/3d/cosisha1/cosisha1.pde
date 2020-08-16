float az = 0, zoom = 1;

PGraphics background, render, iu;
PShader sgrandient;

void setup() {
  size(800, 600, P2D);

  sgrandient = loadShader("gradient.glsl");
  sgrandient.set("resolution", float(width), float(height));
  sgrandient.set("col1", float(1), float(0), float(0), float(1));
  sgrandient.set("col2", float(1), float(1), float(0), float(1));

  background = createGraphics(width, height, P2D);
  render = createGraphics(width, height, P3D);
  iu = createGraphics(width, height, P2D);
}

void draw() {
  if (frameCount%20 == 0) frame.setTitle("Fps: "+frameRate);

  background.beginDraw();
  sgrandient.set("col1", (cos(frameCount*0.033)+1)/2, float(0), (cos(frameCount*0.0073)+1)/2, float(1));
  sgrandient.set("col2", float(1), (cos(frameCount*0.0133)+1)/2, float(0), float(1));
  background.shader(sgrandient);
  background.rect(0, 0, width, height);
  background.endDraw();

  render.beginDraw();
  render.clear();
  render.smooth(8);
  render.translate(width/2, height/2, -100);
  render.rotateX(frameCount*0.0271);
  render.rotateY(frameCount*0.0003813);
  az *= 0.95;
  zoom += az;
  render.scale(zoom);
  render.noFill();
  render.strokeWeight(3);
  render.stroke(255);
  render.box(180);
  render.strokeWeight(2);
  render.stroke(#FAAE21, 230);
  render.box(180+noise(frameCount*0.03)*18);
  /*
  render.strokeWeight(0.8);
   render.stroke(255);
   render.box(20);
   render.noStroke();
   render.fill(255);
   render.sphere(3+cos(frameCount*0.08));
   */
  render.endDraw();

  iu.beginDraw();
  iu.noStroke();
  iu.fill(0, 160);
  iu.rect(width-130, 10, 120, 500);
  for (int i = 0; i < 12; i++) {
    iu.fill(#71181E);
    iu.rect(width-120, 20+i*15, 100, 10);
    iu.fill(#FF2433);
    iu.rect(width-120, 20+i*15, 100*noise(frameCount*cos(i)*0.03+i), 10);
  }
  iu.endDraw();

  image(background, 0, 0);
  image(render, 0, 0);
  image(iu, 0, 0);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  az -= e*0.01;
}
