float ang = random(TWO_PI);
String txt = "manoloide";

void setup() {
	size(160, 160);
	textFont(createFont("Helvetica Neue Bold", 120, true));
	background(#33F99A);
}

void draw() {
	noStroke();
	fill(#33F99A);
	rect(0, 0, width, height);

	textAlign(CENTER,CENTER);
	ang += random(-0.05, 0.05);
	for(int i = 0; i < 10; i++){
		fill(252, (255./(i*2+1)));
		text(txt.charAt(((frameCount/10)%(txt.length()*2) >= txt.length())? 0 : (frameCount/10)%(txt.length()*2)), width/2+cos(ang)*i*2, height/2+sin(ang)*i*2);
	}
}

