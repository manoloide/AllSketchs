
int dim = 300; // the grid dimensions of the heightmap
int blurFactor = 3; // the blur for the displacement map (to make it smoother)
float resizeFactor = 0.25; // the resize factor for the displacement map (to make it smoother)
float displaceStrength = 0.2; // the displace strength of the GLSL shader displacement effect

PShape heightMap; // PShape to hold the geometry, textures, texture coordinates etc.
PShader displace; // GLSL shader

PImage img;
PGraphics dis;

void setup() {
  img = loadImage("img.jpg");
  size(img.width, img.height, P3D);
  //ortho(0, width, 0, height);
  dis = createGraphics(int(img.width*resizeFactor), int(img.height*resizeFactor));
  dis.beginDraw();
  dis.background(0);
  dis.endDraw();

  displace = loadShader("displaceFrag.glsl", "displaceVert.glsl"); // load the PShader with a fragment and a vertex shader
  displace.set("displaceStrength", displaceStrength); // set the displaceStrength
  resetMaps(); // set the color and displacement maps
  heightMap = createPlane(dim, dim); // create the heightmap PShape (see custom creation method) and put it in the global heightMap reference
}

void draw() {
  pushMatrix();
  pointLight(255, 255, 255, 2*(mouseX-width/2), 2*(mouseY-height/2), 500); // required for texLight shader
  translate(width/2, height/2); // translate to center of the screen
  //rotateX(radians(60)); // fixed rotation of 60 degrees over the X axis
  //rotateZ(frameCount*0.01); // dynamic frameCount-based rotation over the Z axis

  background(0); // black background

  dis.beginDraw();
  dis.noStroke();
  dis.fill(0, 5);
  dis.rect(0, 0, width, height);
  if (mousePressed) {
    dis.noFill();
    dis.strokeWeight(5);
    for (int i = 0; i < 2; i++) {
      float tt = dist(mouseX, mouseY, pmouseX, pmouseY)*0.1;
      if (i%2 == 1) {
        dis.stroke(255, map(i, 0, 5, 255, 0));
      } else {
        dis.stroke(0, map(i, 0, 5, 50, 0));
      }
      dis.ellipse(mouseX*resizeFactor, mouseY*resizeFactor, i*5*tt, i*5*tt);
    }
  }
  dis.filter(BLUR, 3);
  dis.endDraw();
  //perspective(PI/3.0, (float) width/height, 0.1, 1000000); // perspective for close shapes
  scale(img.width); // scale by 750 (the model itself is unit length

    resetMaps();
  shader(displace); // use shader
  shape(heightMap); // display the PShape
  popMatrix();
  // write the fps, the current colorMap and the current displacementMap in the top-left of the window
  
  frame.setTitle(" " + int(frameRate));
  hint(DISABLE_DEPTH_TEST); 
  resetShader();
  image(dis, 0, 0);
  hint(ENABLE_DEPTH_TEST);
}

// custom method to create a PShape plane with certain xy dimensions
PShape createPlane(int xsegs, int ysegs) {

  // STEP 1: create all the relevant data

  ArrayList <PVector> positions = new ArrayList <PVector> (); // arrayList to hold positions
  ArrayList <PVector> texCoords = new ArrayList <PVector> (); // arrayList to hold texture coordinates

  float usegsize = 1 / (float) xsegs; // horizontal stepsize
  float vsegsize = 1 / (float) ysegs; // vertical stepsize

  for (int x=0; x<xsegs; x++) {
    for (int y=0; y<ysegs; y++) {
      float u = x / (float) xsegs;
      float v = y / (float) ysegs;

      // generate positions for the vertices of each cell (-0.5 to center the shape around the origin)
      positions.add( new PVector(u-0.5, v-0.5, 0) );
      positions.add( new PVector(u+usegsize-0.5, v-0.5, 0) );
      positions.add( new PVector(u+usegsize-0.5, v+vsegsize-0.5, 0) );
      positions.add( new PVector(u-0.5, v+vsegsize-0.5, 0) );

      // generate texture coordinates for the vertices of each cell
      texCoords.add( new PVector(u, v) );
      texCoords.add( new PVector(u+usegsize, v) );
      texCoords.add( new PVector(u+usegsize, v+vsegsize) );
      texCoords.add( new PVector(u, v+vsegsize) );
    }
  }

  // STEP 2: put all the relevant data into the PShape

    textureMode(NORMAL); // set textureMode to normalized (range 0 to 1);
  //PImage tex = loadImage("../_Images/Texture01.jpg");

  PShape mesh = createShape(); // create the initial PShape
  mesh.beginShape(QUADS); // define the PShape type: QUADS
  mesh.noStroke();
  mesh.texture(img); // set a texture to make a textured PShape
  // put all the vertices, uv texture coordinates and normals into the PShape
  for (int i=0; i<positions.size (); i++) {
    PVector p = positions.get(i);
    PVector t = texCoords.get(i);
    mesh.vertex(p.x, p.y, p.z, t.x, t.y);
  }
  mesh.endShape();

  return mesh; // our work is done here, return DA MESH! ;-)
}

// a separate resetMaps() method, so the images can be change dynamically
void resetMaps() {
  displace.set("colorMap", img);
  displace.set("displacementMap", dis.get());
}

// convenience method to create a smooth displacementMap
PImage imageToDisplacementMap(PImage img) {
  PImage imgCopy = img.get(); // get a copy so the original remains intact
  imgCopy.resize(int(imgCopy.width*resizeFactor), int(imgCopy.height*resizeFactor)); // resize
  if (blurFactor >= 1) { 
    imgCopy.filter(BLUR, blurFactor);
  } // apply blur
  return imgCopy;
}

void keyPressed() {
}
