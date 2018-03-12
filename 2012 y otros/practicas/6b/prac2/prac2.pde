int tam = 40;

void setup() {
  size(400, 400);
}

void draw() {
  for(int j = 0; j < height/tam; j++){
     float val1 = map(j,0,height/tam,0,255);
     for (int i = 0; i < width/tam; i++){
        float val2 = map(i,0,width/tam,0,255/10); 
        fill(val1+val2);
        rect(j*tam,i*tam,tam,tam);
     } 
  }
}

