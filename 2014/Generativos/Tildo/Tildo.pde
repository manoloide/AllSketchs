float xoff = 0;

void setup() {
	size(200,200);
	frame.setResizable(true);
}

void draw() {
	background(#262626);
	xoff = xoff + .01;
	strokeWeight(noise(xoff)*2+1.5);
	stroke(#3762E4);
	noFill();
	ellipse(width/2, height/2, width*0.6, height*0.6);
	float amp = width*0.2;
	float freq = 20;//map(abs(frameCount%400-200)/200., 0, 1, 40, 200);
	float des = frameCount*0.5;
	for(int i = 1; i < width; i++){
		float ang = (TWO_PI/freq)*(i-1+des);
		float ang2 = (TWO_PI/freq)*(i+des);
		line(i-1, height/2+cos(ang)*amp, i, height/2+cos(ang2)*amp);
	}
	float da = TWO_PI/6;
	for(int i = 0; i < 6; i++){
		float ang = des*0.08 + da*i;
		float x = width/2+cos(ang)*width*0.2;
		float y = height/2+sin(ang)*height*0.2;
		ellipse(x,y, width*0.05, width*0.05);
	}
}