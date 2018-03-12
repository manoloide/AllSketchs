void poly(float x, float y, float dim, int amount, float ang){
	float r = dim/2;
	float da = TWO_PI/amount;
	beginShape();
	for(int i = 0; i < amount; i++){
		vertex(x+cos(ang+da*i)*r, y+sin(ang+da*i)*r);
	}
	endShape(CLOSE);
}