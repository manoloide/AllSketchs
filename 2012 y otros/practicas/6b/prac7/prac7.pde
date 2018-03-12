int tam = 40;

void setup() {
  size(400, 400);
  stroke(127);
}

void draw() {
  for(int j = 0; j < height/tam; j++){
     for (int i = 0; i < width/tam; i++){
        if (i>j){
           fill(0); 
        }else{
           fill(255); 
        }
        rect(i*tam,j*tam,tam,tam);
     } 
  }
}

