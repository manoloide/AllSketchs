int cant[] = new int[10];

void setup() {
  size(400, 400);
}

void draw(){
  
}

void keyPressed(){
   if(key == '0'){
      cant[0]++;
   }else if(key == '1'){
      cant[1]++;
   }else if(key == '2'){
      cant[2]++;
   } else if(key == '3'){
      cant[3]++;
   } else if(key == '4'){
      cant[4]++;
   } else if(key == '5'){
      cant[5]++;
   } else if(key == '6'){
      cant[6]++;
   } else if(key == '7'){
      cant[7]++;
   } else if(key == '8'){
      cant[8]++;
   } else if(key == '9'){
      cant[9]++;
   } 
  for (int i = 0; i < cant.length; i++){
     println(i +": " + cant[i]);
  } 
}

