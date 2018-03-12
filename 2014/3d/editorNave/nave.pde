class Nave{
	int cantW, cantH;
	Mesh mesh;
	PVector pos, rot, sca;
	Nave(){
		cantW = 4;
		cantH = 4;
		pos = new PVector();
		rot = new PVector();
		sca = new PVector(100, 100, 100);
		mesh = new Mesh();
	}
	void update(){
		rot.y += 0.005;
		rot.x += 0.001;
		rot.z += 0.005;
		mesh.update();
		draw();
	}
	void draw(){
		pushMatrix();
		translate(pos.x, pos.y, pos.z);
		rotateX(rot.x);
		rotateY(rot.y);
		rotateZ(rot.z);
		noStroke();
		mesh.draw();
		popMatrix();
		/*
		beginShape(QUADS);
		float tw = 1./cantW;
		float th = 1./cantH;
		for(int j = -cantH/2; j < cantH/2; j++){
			for(int i = -cantW/2; i < cantW/2; i++){
				vertex(tw*(i+0)*sca.x, th*(j+0)*sca.y, 0*sca.z);
				vertex(tw*(i+1)*sca.x, th*(j+0)*sca.y, 0*sca.z);
				vertex(tw*(i+1)*sca.x, th*(j+1)*sca.y, 0*sca.z);
				vertex(tw*(i+0)*sca.x, th*(j+1)*sca.y, 0*sca.z);
			}
		}
		endShape();
		popMatrix();
		*/
	}
}