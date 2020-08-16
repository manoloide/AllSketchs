class Mesh{
	ArrayList<PVector> verts;
	int faces[][];
	PVector pos, rot, sca;
	Mesh(){
		pos = new PVector();
		rot = new PVector();
		sca = new PVector();
		createMesh();
	}
	void update(){
		createMesh();
	}
	void draw(){
		beginShape(QUAD);
		for(int j = 0; j < faces.length; j++){
			for(int i = 0; i < faces[i].length; i++){
				int ind = faces[j][i];
				PVector ver = verts.get(ind);
				vertex(ver.x, ver.y, ver.z);
			}
		}
		endShape();
	}
	void createMesh(){
		verts = new ArrayList<PVector>();
		float h = ((Slider) (window.get("width"))).getFloat(); // 120;
		float v = ((Slider) (window.get("height"))).getFloat(); // 400;
		int ch = ((Slider) (window.get("cant h"))).getInt(); // 16;
		int cv = ((Slider) (window.get("cant w"))).getInt(); // 10;
		float amp1 = ((Slider) (window.get("amp1"))).getFloat(); // 10;
		float amp2 = ((Slider) (window.get("amp2"))).getFloat(); // 10;
		float dh = v/(cv);
		faces = new int[ch*cv][];
		float da = TWO_PI/ch;
		for(int j = 0; j <= cv; j++){
			float hh = (h/2-10) * (cos(map(j, 0, cv, amp1, amp2)+1))/2 + 10;
			for(int i = 0; i < ch; i++){
				float xx = cos(da*i) * hh;
				float yy = (j-cv/2)*(dh);
				float zz = sin(da*i) * hh;
				verts.add(new PVector(xx, yy, zz));
				if(j < cv){
					int face[] = {(i+0)%ch+((j+0)*ch), (i+1)%ch+((j+0)*ch), (i+1)%ch+((j+1)*ch), (i+0)%ch+((j+1)*ch)};
					faces[i+j*ch] = face;
				}
			}

		}
	}
}