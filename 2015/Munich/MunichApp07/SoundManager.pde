class SoundManager {
  AudioSample openCell, closeCell, openNode, openSubnode, openText;
  SoundManager() {
    loadSound();
  }
  void loadSound() {
    openCell = minim.loadSample("data/sound1.wav", 512);
    closeCell = minim.loadSample("data/sound1.wav", 512);
    openNode = minim.loadSample("data/sound2.mp3", 512);
    openSubnode = minim.loadSample("data/sound2.mp3", 512);
    openText = minim.loadSample("data/sound2.mp3", 512);
  }
}

