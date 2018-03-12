void menu(){
  noStroke();
  fill(60);
  rect(400, 0, 200, height);
  fill(255);
  //text("SUPER PARAMETROS", 410, 15);
  s1.act();
  p1.act();
  p2.act();
  
  if(p1.val){
     n1.guardar(); 
  }
  if(p2.val){
    n1.cargar();
  }
}
