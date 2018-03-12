import org.processing.wiki.triangulate.*;

int seed;

void setup(){
	size(600, 800);
	colorMode(HSB);
	generar();
}

void draw(){	
}

void keyPressed(){
	if(key == 's') saveFrame(""+seed);
	else generar();
}

void generar(){
	seed = (int) random(999999);
	randomSeed(seed);
	ArrayList<PVector> puntos = new ArrayList<PVector>();

	for(int i = 0; i < 100; i++){
		puntos.add(new PVector(random(-100, width+100), random(-100, height+100)));
	}
	ArrayList tri = new ArrayList();
	tri = Triangulate.triangulate(puntos);
	noStroke();
	for(int i = 0; i < tri.size(); i++){
		Triangle t = (Triangle)tri.get(i);
		float cx = (t.p1.x+t.p2.x+t.p3.x)/3;
		float cy = (t.p1.y+t.p2.y+t.p3.y)/3;
		int cs = 5;
		for(int j = 0; j < cs; j++){
			float dis, ang;
			fill((i*128+120)%256, 80+5*j, 30+25*j);
			noStroke();
			beginShape();
			dis = dist(t.p1.x, t.p1.y, cx, cy)/cs;
			dis = dis*j;
			ang = atan2(t.p1.y-cy, t.p1.x-cx);
			vertex(t.p1.x-cos(ang)*dis,t.p1.y-sin(ang)*dis);
			dis = dist(t.p2.x, t.p2.y, cx, cy)/cs;
			dis = dis*j;
			ang = atan2(t.p2.y-cy, t.p2.x-cx);
			vertex(t.p2.x-cos(ang)*dis,t.p2.y-sin(ang)*dis);

			dis = dist(t.p3.x, t.p3.y, cx, cy)/cs;
			dis = dis*j;
			ang = atan2(t.p3.y-cy, t.p3.x-cx);
			vertex(t.p3.x-cos(ang)*dis,t.p3.y-sin(ang)*dis);
			/*
			vertex(t.p1.x,t.p1.y);
			vertex(t.p2.x,t.p2.y);
			vertex(t.p3.x,t.p3.y);
			*/
			endShape(CLOSE);
		}
/*
		noFill();
		stroke(10, 80);
		ellipse(cx, cy, 8, 8);
		line(cx-2, cy-2,cx+2, cy+2);
		line(cx-2, cy+2,cx+2, cy-2);
*/
	}
}