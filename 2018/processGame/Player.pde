class Player{
  
  PVector position; 
  Player(){
     position = new PVector(); 
  }
  
  void update(){
    
    position.lerp(mouse, 0.02);
    
    
  }
  
  void show(){
    fill(20, 0, 0);
    pushMatrix();
    translate(position.x, position.y, 10);
    //ellipse(0, 0, 20, 20);
    box(20);
    popMatrix();
  }
  
  
}
