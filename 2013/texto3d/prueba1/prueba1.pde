void setup() {
    size(800,600,P3D);    
    textSize(80);
} 

void draw() {  
    background(0);
    translate(width * .5, height*.5,0);
    rotateY(map(mouseX,0,width,-PI,PI));
    rotateX(map(mouseY,0,height,-PI,PI));
    pushMatrix();
    text("foo!", -20, 0, 20);
    popMatrix();
}