import processing.video.*;

Capture video;
PShader dither, threshold;

void setup() {
  size(640, 480, P2D);
  frameRate(30);
  dither = loadShader("dither.glsl");
  dither.set("iResolution", float(width), float(height));
  threshold = loadShader("threshold.glsl");
  threshold.set("threshold", 0.5);
  video = new Capture(this, width, height);
  video.start();
}

void draw() {
  dither.set("iGlobalTime", millis()/1000.);
  if (video.available()) {
    video.read();
    shader(threshold);
    image(video, 0, 0);
  }
  filter(dither);
}

