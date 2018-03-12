int tam = 20;
size(400,400);
for(int i = width;i >= tam; i-=tam){
   if(i%(tam*2) == 0){
     fill(255);
      ellipse(width/2,height/2,i,i);
   } else{
     fill(0);
      ellipse(width/2+tam/2,height/2,i,i); 
   }
}
