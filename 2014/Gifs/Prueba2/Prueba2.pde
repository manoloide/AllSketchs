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
 
boolean save = true;
float aberrationAmount = 0.2; // 1 is quite a lot

int samplesPerFrame = 10;
int numFrames = 30;        
float shutterAngle = 0.2;
 
void setup_() {
	size(600,600);
}

void draw__() {
	time %= 1;
	background(250);
	noFill();
	float tam = abs(time*2-time)*50+10;
	translate(width/2, height/2);
	rotate(time*TWO_PI*2);
	scale(time+0.2);
	strokeWeight(sin(time*PI)*6);
	int cant = 20;
	for(int i = 1; i <= cant; i++){
		float vel;
		float dim = 0.1*i;
		float ang = (TWO_PI/cant)*i;
		if(time < 0.5){
			vel = sin(time*2*PI/2);
			stroke(lerpColor(#FF8800, #8800FF, vel));
			arc(0,0,width*dim, height*dim, 0+ang, vel*TWO_PI+ang);
			ellipse(cos(vel*TWO_PI+ang)*(width*dim)/2, sin(vel*TWO_PI+ang)*(height*dim)/2, sin(time*PI)*8, sin(time*PI)*8); 
		}else{
			vel = sin((time-0.5)*2*PI/2);
			stroke(lerpColor(#FF8800, #8800FF, 1-vel));
			arc(0,0,width*dim, height*dim, vel*TWO_PI+ang, TWO_PI+ang);
			ellipse(cos(TWO_PI+ang)*(width*dim)/2, sin(TWO_PI+ang)*(height*dim)/2, sin(time*PI)*8, sin(time*PI)*8);
		}
	}
}