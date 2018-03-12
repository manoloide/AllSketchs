class SoundManager {
  AudioSample openCell, closeCell, openNode, openSubnode, openText;
  AudioPlayer music;
  SoundManager() {
    loadSound();
  }
  void loadSound() {
    openCell = minim.loadSample("data/Sounds/INTERACTIVO CLICK B.mp3", 512);
    closeCell = minim.loadSample("data/Sounds/INTERACTIVO CLICK REVERSE A.mp3", 512);
    openNode = minim.loadSample("data/Sounds/INTERACTIVO CLICK CIRCULOS MEDIANOS.mp3", 512);
    openSubnode = minim.loadSample("data/Sounds/INTERACTIVO CLICK CIRCULOS PEQUEÑOS.mp3", 512);
    openText = minim.loadSample("data/Sounds/INTERACTIVO CLICK PRIMER CIRCULO B.mp3", 512);
    music = minim.loadFile("data/Sounds/INTERACTIVO MUSICA A.mp3", 512);
    music.loop();
  }
}

