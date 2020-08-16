int seed = int(random(9999999));

void setup() {
	size(600, 800);
	generar();
}

void draw() {
	
}

void generar(){
	randomSeed(seed);
	background(#D7D3CE);
	int t = 20;
	noStroke();
	fill(250, 20);
	for(int j = 0; j < height/t+1; j++){
		for(int i = 0; i < width/t+1; i++){
			float x = i*t + t/2;
			float y = j*t + t/2;
			float dis = dist(width/2, height/2, x, y);
			float tam = t*dis/height;
			ellipse(x, y, tam, tam);
		}
	}
	noFill();
	for(int i = 0; i < 200; i++){
		float x = width/2;
		float y = height/2;
		float da = TWO_PI/3;
		float ang = -PI/2;
		float tt = i*10;
		strokeWeight(map(i, 0, 200, 0.1, 3));
		stroke(0, map(i, 0, 200, 10, 40));
		triangle(x+cos(ang)*tt, y+sin(ang)*tt, x+cos(ang+da)*tt, y+sin(ang+da)*tt, x+cos(ang+da*2)*tt, y+sin(ang+da*2)*tt);
	}

	for(int i = 0; i < 80; i++){
		float xx = width*0.66+i;
		stroke(5, map(i, 0, 80, 30, 0));
		line(xx, 0, xx, height);
	}

	for(int i = 0; i < 300; i++){
		float ang = random(TWO_PI);
		float dis = random(200);
		float tam = dis/4;
		float x = width/2 + cos(ang)*dis;
		float y = height/2 + sin(ang)*dis;
		strokeWeight(tam/10);
		stroke(random(248,252),random(248,252),random(248,252));
		noFill();
		ellipse(x, y, tam, tam);
	}
	noStroke();
	fill(250, 60);
	ellipse(width*0.25, height*0.25, width*0.2,width*0.2);
	stroke(250, 60);
	noFill();
	for(int i = 0; i < 10; i++){
		strokeWeight(1.5 - i/10);
		float ttt = width*0.2 + (i+1) * 10;
		ellipse(width*0.25, height*0.25, ttt, ttt);
	}

	noStroke();
	fill(#F2ECB1);
	for(int i = 0; i < 3; i++){
		float d = width*0.04;
		float ttt = d - d/2.3 * i;
		ellipse(width*0.25+d* i, height*0.25, ttt, ttt);
	}
}

void keyPressed(){
	if(key == 's') saveFrame(seed+".png");
	else {
		seed = int(random(9999999));
		generar();
	}
}