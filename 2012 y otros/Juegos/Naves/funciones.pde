void fondo(){
   noStroke();
   fill(0);
   rect(0,0,width,height);
   for (int i = 0; i < 100; i++){
     set(int(random(width)),int(random(height)),color(255));
   }
}
