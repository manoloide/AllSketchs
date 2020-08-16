int paleta[] = {
	#FFE223,
	#E9D459,
	#70A112,
	#385F1B,
	#F8CB3D
};

void setup() {
	size(600, 600);
	generar();
}

void draw() {
	
}

void generar(){
	background(2);
	for(int i = 0; i < 1000; i++){
		stroke(rcol(), 20);//lerpColor(rcol(), color(0), random(random(0, 0.2), random(0.6, 1))));
		strokeWeight(random(2));
		noFill();
		fill(rcol(), 6);
		float x = width/2; 
		float y = height/2; 
		float r1 = randomGaussian()*100;
		float r2 = randomGaussian()*30;
		float ang = random(TWO_PI);

		float width_two_thirds = r1 * 4. / 3;
		float dx1 = sin(ang) * r2;
		float dy1 = cos(ang) * r2;
		float dx2 = cos(ang) * width_two_thirds;
		float dy2 = sin(ang) * width_two_thirds;

		float topCenterX = x - dx1;
		float topCenterY = y + dy1;
		float topRightX = topCenterX + dx2;
		float topRightY = topCenterY + dy2;
		float topLeftX = topCenterX - dx2;
		float topLeftY = topCenterY - dy2;

		float bottomCenterX = x + dx1;
		float bottomCenterY = y - dy1;
		float bottomRightX = bottomCenterX + dx2;
		float bottomRightY = bottomCenterY + dy2;
		float bottomLeftX = bottomCenterX - dx2;
		float bottomLeftY = bottomCenterY - dy2;


		//translate(x, y);
		beginShape();
		vertex(bottomCenterX, bottomCenterY);
		bezierVertex(bottomRightX, bottomRightY, topRightX, topRightY, topCenterX, topCenterY);
		bezierVertex(topLeftX, topLeftY, bottomLeftX, bottomLeftY, bottomCenterX, bottomCenterY);
		//ctx.bezierCurveTo(bottomRightX, bottomRightY, topRightX, topRightY, topCenterX, topCenterY);
		//ctx.bezierCurveTo(topLeftX, topLeftY, bottomLeftX, bottomLeftY, bottomCenterX, bottomCenterY);
		endShape();
	}
}

void keyPressed(){
	if(key == 's') saveImage();
	else generar();
}

void saveImage(){
	int n = (new File(sketchPath)).listFiles().length-2;
	saveFrame(nf(n, 3)+".png");
}

int rcol(){
	return paleta[int(random(paleta.length))];
}