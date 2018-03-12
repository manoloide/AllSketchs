void setup() {
	size(800, 600, P3D);
	sphereDetail(12);
}

void draw() {
	if(frameCount%10 == 0) frame.setTitle("asdasda"+frameRate);
	directionalLight(126, 126, 126, 0, 0, -1);
	ambientLight(102, 102, 102);
	background(72);
	translate(width/2, height/2, -200);
	noStroke();
	fill(200,100,240);
	rotateX(frameCount/30.);
	rotateY(frameCount/55.);
	rotateZ(frameCount/62.);
	sphere(100);
	translate(100, 200, 200);
	sphere(30);
}