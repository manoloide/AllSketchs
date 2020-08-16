void water() {
  stroke(#edf731);
  strokeWeight(2);
  fill(#edf731, 180);
  rectMode(CORNER);
  
  beginShape();
  float y = height-stats.water;
  
  if(player.position.y > y){
     dead(); 
  }
  
  float oscY = cos(global.time*1.5)*3;
  for(int i = -2; i <= width+2; i+=4){
    float osc = cos(global.time+i*0.05)*3;
    vertex(i, y+osc+oscY);
  }
  vertex(width+2, height+3);
  vertex(-2, height+3);
  
  endShape(CLOSE);
  strokeWeight(1);
}
