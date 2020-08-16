float zoom, newZoom ;

void setup() {
  size(960, 540, P2D);
  smooth(4);
}


void draw() {

  zoom = lerp(zoom, newZoom, 0.12);

  int seed = int(zoom);
  randomSeed(seed);
  noiseSeed(seed);

  float nz = zoom%1;


  float size = width*nz*1.42;
  float maxSize = 0;



  float cx = width*0.5;
  float cy = height*0.5;

  ArrayList<PVector> points = new ArrayList<PVector>();
  float nx = 0;
  float ny = 0;
  for (int i = 0; i < 80; i++) {
    float ang = random(TAU);
    float des = sqrt(random(1));
    float rad = des*size*0.5;
    float xx = cx+cos(ang)*rad;
    float yy = cy+sin(ang)*rad;
    float ss = size*random(0.2)*random(0.5, 1);

    if (rad+ss*0.6 > size*0.5) continue;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(xx, yy, other.x, other.y) < (ss+other.z)*0.6) {
        add = false;
        break;
      }
    }
    if (add) {
      if (ss > maxSize) {
        maxSize = ss;
        nx = xx;
        ny = yy;
      }
      points.add(new PVector(xx, yy, ss));
    }
  }

  float dx = lerp(cx, nx, pow(nz, 1.8));
  float dy = lerp(cy, ny, pow(nz, 1.8));

  //scale(lerp(1, size*0.1/maxSize, nz));
  //scale(1+pow(nz, 1.8)*2);
  translate(width*0.5-dx, height*0.5-dy);

  background((seed%2 == 0)? 255 : 0);
  fill((seed%2 == 0)? 0 : 255);
  ellipse(cx, cy, size, size);
  fill((seed%2 == 0)? 255 : 0);
  noStroke();


  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, p.z, p.z);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  newZoom += e*0.018;
}

//https://coolors.co/ed78dd-1c0a26-0029c1-ffea75-eadcd3
//int colors[] = {#ED61DA, #200C2B, #0029BF, #FFE760, #DBD1CB};
//int colors[] = {#F20707, #FCCE4A, #D0DFE8, #F49FAE, #342EE8};
//int colors[] = {#F20707, #FC9F35, #C5B7E8, #544EE8, #000000};
//int colors[] = {#EF9F00, #E56300, #D15A3D, #D08C8B, #68376D, #013152, #3F8090, #8EB4A8, #E5DFD1};
//int colors[] = {#2E0006, #5B0D1C, #DA265A, #A60124, #F03E90};
int colors[] = {#01D8EA, #005DDA, #1B2967, #5E0D4A, #701574, #C65B35, #FEB51B, #CDB803, #66BB06};
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
  return lerpColor(c1, c2, pow(v%1, 0.5));
}
