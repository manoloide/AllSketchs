// by dave @ beesandbombs.tumblr.com >:)
 
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
 
  if(save){ 
	 saveFrame("f###.gif");
	  if (frameCount==numFrames)
	    exit();
	  }
}
 
//////////////////////////////////////////////////////////////////////////////
 
boolean save = false;
float aberrationAmount = 0.2; // 1 is quite a lot

int samplesPerFrame = 8;
int numFrames = 30;        
float shutterAngle = 0.5;
 
void setup_() {
	size(600,600);
	noStroke();
}

void draw__() {
	background(250);
	float ang = time*PI;
	float dis = 120;
  translate(width/2, height/2);
  float tt = 30;
  for(int j = -height; j < height; j+=tt){
    for(int i = -width; i < width; i+=tt){
      float des = tt*time;
      noStroke();
      fill(230);
      ellipse(i+des, j+des, tt*0.6, tt*0.6);
      stroke(250);
      strokeWeight(1.5);
      strokeCap(SQUARE);
      line(i+des-tt*0.2, j+des, i+des+tt*0.2, j+des);
      line(i+des, j+des-tt*0.2, i+des, j+des+tt*0.2);
      strokeCap(ROUND);
    } 
  }
  scale(1-cos(time*PI*6)*0.05);
  noFill();
  stroke(200);
  strokeWeight(8);
  ellipse(0,0,(dis*2),(dis*2));
  for(int j = 0; j < 2; j++){
  	float x = cos(ang+PI*j)*dis;
  	float y = sin(ang+PI*j)*dis;
  	float tam = 200;//(abs((frameCount%numFrames)-numFrames/2.))/(numFrames/2)*300+10;
  	noStroke();
    fill(20);
    ellipse(x,y,tam,tam);
  	fill(40);
  	float da = TWO_PI/16;
  	for(int i = 0; i < 16; i++){
  		float dd = time*da*8;
  		ellipse(x+cos(da*i+dd)*tam/2.5, y+sin(da*i+dd)*tam/2.5, tam/10, tam/10);
  	}
  }
}