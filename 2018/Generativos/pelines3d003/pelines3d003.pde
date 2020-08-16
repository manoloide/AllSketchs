import peasy.PeasyCam;
int seed = int(random(9999999));

ArrayList<Line> lines;
PShader fogLines;
float fov;

int gridCount = 20;
int linesCount = 2000;
float gridSize;
float det, des1, des2;

PeasyCam cam;
void setup() {
  size(960, 540, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);

  fogLines = loadShader("fogLines.glsl");
  fogLines.set("fogNear", 1000.0); 
  fogLines.set("fogFar", 3000.0);

  generate();
}

void draw() {

  background(0);

  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  blendMode(ADD);

  gridSize = width*1./gridCount;
  translate(-gridSize*gridCount*0.5, -gridSize*gridCount*0.5, -gridSize*gridCount*0.5);

  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    l.update();
    l.show();
    if (l.remove) lines.remove(i);
  }

   while(lines.size() < linesCount) addLine();
  shader(fogLines);
}

void keyPressed() {
  seed = int(random(9999999));
  generate();
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  lines = new ArrayList<Line>();
  det = random(0.001);
  des1 = random(10000);
  des2 = random(10000);

  fov = PI/random(2, random(2, 3));
  
  /*
  for (int i = 0; i < linesCount; i++) {
    addLine();
  }
  */
}

void addLine() {
  float xx = int(random(gridCount))*gridSize;
  float yy = int(random(gridCount))*gridSize;
  float zz = int(random(gridCount))*gridSize; 
  lines.add(new Line(xx, yy, zz));
}


int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
