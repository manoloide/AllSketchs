int pallete[] = {
	#FF6136,
	#FFCC30,
	#FF4056,
	#49ABFF,
	#FFD863
};

void setup() {
  size(960, 960, P2D);
  smooth(4);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {

	beginShape();
	fill(rcol());
	vertex(0, 0);
	fill(rcol());
	vertex(width, 0);
	fill(rcol());
	vertex(width, height);
	fill(rcol());
	vertex(0, height);
	endShape(CLOSE);

	float diag = dist(0, 0, width, height);
	int sep = int(random(8, 28));
	pushMatrix();
	translate(width/2, height/2);
	rotate(random(TWO_PI));
	stroke(255, random(180)*random(1));
	strokeWeight(sep*random(0.2, 0.4));
	for(float i = -diag/2; i < diag/2; i+=sep){
		line(i, -diag/2, i, diag/2);
	}
	popMatrix();

	int c = int(random(-1, 4));
	for(int i = 0; i < c; i++){
		float x = width*0.5;//random(0.35, 0.65);
		float y = height*0.5;//random(0.35, 0.65);
		float a = random(TWO_PI);
		float amp = PI/int(random(2, random(2, 10)));
		noStroke();
		color col = rcol();
		beginShape();
		fill(bri2(col, random(-15)));
		vertex(x+cos(a-amp)*diag+cos(a)*diag, y+sin(a-amp)*diag+sin(a)*diag);
		vertex(x+cos(a-amp)*diag, y+sin(a-amp)*diag);
		fill(bri2(col, random(20)));
		vertex(x, y);
		fill(bri2(col, random(-15)));
		vertex(x+cos(a+amp)*diag, y+sin(a+amp)*diag);
		vertex(x+cos(a+amp)*diag+cos(a)*diag, y+sin(a+amp)*diag+sin(a)*diag);
		endShape(CLOSE);		

		noFill();
		stroke(0, 3);
		for(int s = 8; s > 0; s--){
			strokeWeight(s);
			float xx = x+cos(a)*s/2;
			float yy = y+sin(a)*s/2;
			beginShape();
			vertex(xx+cos(a-amp)*diag, yy+sin(a-amp)*diag);
			vertex(xx, yy);
			vertex(xx+cos(a+amp)*diag, yy+sin(a+amp)*diag);
			endShape(CLOSE);
		}
		stroke(255, 3);
		for(int s = 8; s > 0; s--){
			strokeWeight(s);
			float xx = x-cos(a)*s/2;
			float yy = y-sin(a)*s/2;
			beginShape();
			vertex(xx+cos(a-amp)*diag, yy+sin(a-amp)*diag);
			vertex(xx, yy);
			vertex(xx+cos(a+amp)*diag, yy+sin(a+amp)*diag);
			endShape(CLOSE);
		}
	}

	for(int i = 0; i < 100; i++){
		float x = random(width);
		float y = random(height);
		float t = random(2, 9);
		noFill();
		stroke(255, 6);
		for(int s = 8; s > 0; s--){
			strokeWeight(s);
			ellipse(x, y, t, t);
		}
		noStroke();
		fill(250);
		ellipse(x, y, t, t);
	}

	for(int i = 0; i < 120; i++){
		float x = random(width);
		float y = random(height);
		float dis = dist(x, y, width/2, height/2);
		float t = max(1, 120*(dis/diag)*random(0.6, 1.2));
		float a = random(TWO_PI);
		beginShape();
		float da = TWO_PI/3;
		noFill();
		stroke(0, 3);
		for(int s = 7; s > 0; s--){
			strokeWeight(s);
			for(int cc = 0; cc < 3; cc++){
				vertex(x+cos(a+da*cc)*t, y+sin(a+da*cc)*t);
			}
		}
		endShape(CLOSE);

		beginShape();
		noStroke();
		for(int cc = 0; cc < 3; cc++){
			fill(rcol());
			vertex(x+cos(a+da*cc)*t, y+sin(a+da*cc)*t);
		}
		endShape(CLOSE);
	}

	radialBlur(random(6));
	noisee(3);
}

void noisee(int ii){
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			color col = get(i, j);
			set(i, j, bri(col, ii));
		}
	}
}

void radialBlur(float amp){
	float diag = dist(0, 0, width, height);
	for(int j = 0; j < height; j++){
		for(int i = 0; i < width; i++){
			float dist = dist(i, j, width/2, height/2)/(diag*0.5);
			dist = pow(dist, 1.8);
			color col = get(i, j);
			int cc = int(dist*amp);
			cc = max(0, cc);
			float r = 0;
			float g = 0;
			float b = 0;
			float div = 0;
			for(int yy = -cc; yy <= cc; yy++){
				for(int xx = -cc; xx <= cc; xx++){
					float dd = dist(xx, yy, 0, 0)/amp;
					if(xx == 0 && yy == 0) dd = 1;
					if(i+xx < 0 || i+xx >= width || j+yy < 0 || j+yy >= height) continue;
					col = get(i+xx, j+yy);
					r += red(col)*dd;
					g += green(col)*dd;
					b += blue(col)*dd;
					div += dd;
				}
			}
			set(i, j, color(r/div, g/div, b/div));
		}
	}
}


color bri(color col, float b){
	return color(red(col)+random(-b, b), green(col)+random(-b, b), blue(col)+random(-b, b));
}

color bri2(color col, float b){
	return color(red(col)+b, green(col)+b, blue(col)+b);
}

int rcol() {
	return pallete[int(random(pallete.length))];
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
