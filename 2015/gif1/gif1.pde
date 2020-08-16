void setup() {
  setup_();
  result = new int[width*height][3];
  result_ = new int[width*height][3];
}

int[][] result, result_;
float time;

void draw_() {
  if (aberrationAmount == 0.0) {
    draw__();
    return;
  }

  for (int i=0; i<width*height; i++)
    for (int a=0; a<3; a++)
      result_[i][a] = 0;

  for (int a=0; a<3; a++) {
    pushMatrix();
    translate(width/2, height/2);
    scale(1+0.008*a*aberrationAmount);
    translate(-width/2, -height/2);
    draw__();
    popMatrix();
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      result_[i][a] = pixels[i] >> (8*(2-a)) & 0xff;
    }
  }

  loadPixels();
  for (int i=0; i<pixels.length; i++)
    pixels[i] = 0xff << 24 | result_[i][0] << 16 | 
      result_[i][1] << 8 | result_[i][2];
  updatePixels();
}

void draw() {
  if (shutterAngle == 0.0) {
    time = map(frameCount-1, 0, numFrames, 0, 1) % 1;
    draw_();
    return;
  }

  for (int i=0; i<width*height; i++)
    for (int a=0; a<3; a++)
      result[i][a] = 0;

  for (int sa=0; sa<samplesPerFrame; sa++) {
    time = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
    draw_();
    loadPixels();
    for (int i=0; i<pixels.length; i++) {
      result[i][0] += pixels[i] >> 16 & 0xff;
      result[i][1] += pixels[i] >> 8 & 0xff;
      result[i][2] += pixels[i] & 0xff;
    }
  }

  loadPixels();
  for (int i=0; i<pixels.length; i++)
    pixels[i] = 0xff << 24 | (result[i][0]/samplesPerFrame) << 16 | 
      (result[i][1]/samplesPerFrame) << 8 | (result[i][2]/samplesPerFrame);
  updatePixels();

  if (save) { 
    saveFrame("f###.png");
    if (frameCount==numFrames)
      exit();
  }
}

//////////////////////////////////////////////////////////////////////////////

boolean save = true;
float aberrationAmount = 0.1; // 1 is quite a lot

//color paleta[] = {#FF8800, #FF1188, #0088AA};
int samplesPerFrame = 10;//10;
int numFrames = 40;        
float shutterAngle = 0.5;

void setup_() {
  size(640, 640);
  rectMode(CENTER);
}

void draw__() {
  if (time > 1) time -= 1;
  background(250);
  translate(width/2, height/2);
  float tt = sin(time*PI)*width;
  noStroke();
  fill(40);
  ellipse(0, 0, tt, tt);
}

