void setup(){
	size(800, 600, P3D);
	smooth(32);	
}

void draw(){
	background(240);
	translate(width/2, height/2, -200);
	rotateX(PI*0.3);
	rotateZ(PI*0.3);
	noFill();
	strokeWeight(0.5);
	float r = 250;
	int cant = 16;
	float da = TWO_PI/cant;
	float ang = frameCount*0.01;
	translate(0, 0, -400);
	for (int j = 0; j < 8; j++){
		translate(0, 0, 100);
		ellipse(0, 0, r*2, r*2);
		for(int i = 0; i < cant; i++){
			pushMatrix();
			translate(cos(ang+da*i)*r, sin(ang+da*i)*r, 0);
			ellipse(0, 0, r*0.05, r*0.05);
			popMatrix();
		}
	}
}