size(400,400);
noStroke();
for (int i = 0; i < width; i+=40){
    if ( i%80== 0){
       fill(255); 
    }else{
       fill(0); 
    }
    rect(0,i,40,40);
}
