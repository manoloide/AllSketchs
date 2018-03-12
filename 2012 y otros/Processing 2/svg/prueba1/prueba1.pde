PShape carita;

void setup() {
  size(600, 600,P3D);
  carita = loadShape("../carita.svg");
}

void draw() {
  for (int j = 0; j < height/100; j++) {
    for (int i = 0; i < width/100; i++) {
      carita.resetMatrix();
      carita.rotateY(map(100*i-mouseX,-200,200,-PI,PI)); 
      shape(carita, 100*i, 100*j, 100, 100);
    }
  }
  shape(carita, mouseX-50, mouseY-50, 100, 100);
}

