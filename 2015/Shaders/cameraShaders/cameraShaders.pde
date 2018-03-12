import processing.video.*;

Capture video;
PShader post;
int select = 0;
PShader shaders[];
String names[];

void setup() {
  size(640, 480, P2D);
  frameRate(30);
  video = new Capture(this, width, height);
  video.start();

  initShader();
}

void draw() {
  if (video.available()) {
    post.set("time", millis()/1000.);
    post.set("mouse", float(mouseX)/width, 1-float(mouseY)/height);
    video.read();
    image(video, 0, 0);
    filter(post);
    fill(0);
    rect(10, 10, textWidth(names[select])+6, 20);
    fill(255);
    textAlign(LEFT, TOP);
    text(names[select], 13, 12);
  }
}

void keyPressed() {
  if (key == 'l')
    initShader();
  else if (keyCode == LEFT) {
    select--;
    if (select < 0) select = shaders.length-1;
    post = shaders[select];
    post.set("resolution", float(width), float(height));
  } else if (keyCode == RIGHT) {
    select++;
    select %= shaders.length;
    post = shaders[select];
    post.set("resolution", float(width), float(height));
  }
}

void dispose() {
  video.stop();
}

void initShader() {

  File files[] = (new File(sketchPath("data/shaders/"))).listFiles();
  shaders = new PShader[files.length];
  names = new String[files.length];
  for (int i = 0; i < files.length; i++) {
    shaders[i] = loadShader(files[i].getAbsolutePath());
    names[i] = files[i].getName();
  }
  select %= shaders.length;
  post = shaders[select];
  post.set("resolution", float(width), float(height));
}

