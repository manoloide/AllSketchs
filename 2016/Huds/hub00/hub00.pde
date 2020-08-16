float tt = 16;
float val[][];
int ss = 20;
int cx, cy;


PShader post;

void setup() {
  size(640, 640, P2D);
  cx = width/ss+1;
  cy = height/ss+1;

  val = new float[cx][cy];

  post = loadShader("repeat.glsl");
  post.set("resolution", float(width), float(height));
}

void draw() {
  post.set("mouse", float(mouseX), float(mouseY));
  post.set("time", millis()/1000.);
  background(8);
  noStroke();
  fill(#39A4FF, 200);
  blendMode(ADD);
  for(int k = 0; k < 2; k++){
    for (int j = 0; j < cy; j++) {  
      for (int i = 0; i < cx; i++) {
        float xx = i*ss+k*noise(frameCount*0.02);
        float yy = j*ss+k*noise(frameCount*0.02+100);
        float d = dist(xx, yy, mouseX, mouseY);
        float v = max(0, map(d, 0, 100, 1, 0));
        if (v == 0) {
          val[i][j] -= 0.002;
        } else if (val[i][j] < v) {
          val[i][j] += 0.05;
        } 
        val[i][j] = constrain(val[i][j], 0, 1);
        float t = tt*ease(val[i][j]);
        ellipse(xx, yy, t, t);
      }
    }
  }

  filter(post);
}

float ease(float t){
  float amp = constrain(map(t, 0, 1, 0, 1.1), 0, 1);
  return cos((t*2)*PI)*amp;
}