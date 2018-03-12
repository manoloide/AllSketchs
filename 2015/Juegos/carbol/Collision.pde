static class Collision {
  static boolean circleCircle(float cx1, float cy1, float cr1, float cx2, float cy2, float cr2) {
    if (dist(cx1, cy1, cx2, cy2) < cr1+cr2) {
      return true;
    } 
    return false;
  }
  static boolean rectCircle(float rx, float ry, float rw, float rh, float cx, float cy, float cr) {
    rx -= rw/2;
    ry -= rh/2;
    float closeX, closeY;
    if (cx < rx)
      closeX = rx;
    else if (cx > rx + rw)
      closeX = rx + rw;
    else
      closeX = cx;

    if (cy < ry)
      closeY = ry;
    else if (cy > ry + rh)
      closeY = ry + rh;
    else
      closeY = cy;

    float dis = dist(cx, cy, closeX, closeY);
    if (dis < cr) {
      return true;
    }
    return false;
  }
  static boolean rectCircle(float rx, float ry, float rw, float rh, float ra, float cx, float cy, float cr) {
    PVector m = new PVector(cx-rx, cy-ry);
    m.rotate(-ra);
    return rectCircle(0, 0, rw, rh, m.x, m.y, cr);
  }
  static boolean rectRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
    return ((x1-w1*0.5 < x2+w2*0.5) && (x2-w2*0.5 < x1+w1*0.5) && (y1-h1*0.5 < y2+h2*0.5) && (y2-h2*0.5 < y1+h1*0.5));
  }
}
