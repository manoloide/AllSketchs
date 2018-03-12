class Video {
  int frames, frame;
  int w, h;
  PImage iframes[];
  Video(int w, int h, int frames) {
    this.w = w; 
    this.h = h;
    this.frames = frames;
    frame = 0;

    iframes = new PImage[frames];
    for(int i = 0; i < frames; i++){
    	PGraphics aux = createGraphics(w, h);
    	aux.beginDraw();
    	aux.background(random(20,200),random(20,200),random(20,200));
    	aux.textSize(120);
    	aux.textAlign(CENTER, CENTER);
    	aux.fill(250, 200);
    	aux.text(i+1, w/2, h/2);
    	aux.endDraw();
    	iframes[i] = aux.get();
    }
  }
};
