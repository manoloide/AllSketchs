void feedback(int sca, float rot) {
  render.pushMatrix();
  render.translate(render.width/2, render.height/2);
  render.rotate(rot);
  render.copy(0, 0, render.width, render.height, sca, sca, render.width-sca*2, render.height-sca*2);
  
  render.popMatrix();
}