class Ship{
   float x, y;
   Ship(){
      x = width*0.5;
      y = height*0.8;
   }
   void update(){
     
   }
   void show(){
     fill(255, 40, 120);
      rect(x, y, 20, 30, 10); 
   }
}
