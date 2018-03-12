float dim, dmin, dmax,cre;
int col;

void setup() {
  size(600, 600);
  colorMode(HSB);
  noStroke();
  smooth();
  dmin = 20;
  dmax = 200;
  dim = random(dmin,dmax);
  cre = 1;
  
  col = int(random(256));
}

void draw() {
  fill((col+128)%256, 255,255,10);
  rect(0,0,width,height);
  if (dim > dmax){
     cre = -1; 
  }else if (dim < dmin){
     cre = 1; 
  }
  dim += cre;
  fill(col, 255, random(220,256));
  ellipse(mouseX,mouseY,dim,dim);
  //
  col ++;
  col = col%256;
}

