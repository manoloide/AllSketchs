class Camera {
    float x, y, dx, dy;
    Camera() {
        x = 0; 
        y = 0;
    }
    void update() {
        //x += (dx-x)*0.9;
        //y += (dy-y)*0.9;
        translate(width/2, height/2);
        translate(x, y);
    }
    void update(PVector dp){
        dx = dp.x;
        dy = dp.y;
        update();
    }
}