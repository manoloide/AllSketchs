import ddf.minim.*;
import ddf.minim.analysis.*;

class AudioData {

  //String songName = "../_musics/NicolasJaar_Angles.aiff";
  String songName = "music.aiff";

  //String songName = "../_musics/the-horrors-something-to-remember-me-by-official-audio.mp3";
  int initSong = 0;

  float timeWaitKick;
  float timeWaitSnare;
  float timeWaitHat;

  boolean kick, snare, hat;

  AudioInput in;
  AudioPlayer song;
  BeatDetect beat;
  BeatListener bl;
  FFT fft;

  float kickSize, snareSize, hatSize;
  float nkickSize, nsnareSize, nhatSize;

  AudioData() {
    init();
  }

  void init() {
    song = minim.loadFile(songName, 1024);
    //song.loop();
    song.cue(initSong);
    song.setGain(-20);

    in = minim.getLineIn(Minim.STEREO, 1024);

    beat = new BeatDetect(song.bufferSize(), song.sampleRate());
    beat.setSensitivity(450);  
    kickSize = snareSize = hatSize = 0;
    bl = new BeatListener(beat, in);

    fft = new FFT(in.bufferSize(), in.sampleRate());
    fft.logAverages(22, 3);
  }

  void update() {

    timeWaitKick -= 1./60;
    timeWaitSnare -= 1./60;
    timeWaitHat -= 1./60;

    float smoothBeat = 0.95;
    nkickSize = constrain(nkickSize * smoothBeat, 0, 1);
    nsnareSize = constrain(nsnareSize * smoothBeat, 0, 1);
    nhatSize = constrain(nhatSize * smoothBeat, 0, 1);

    kickSize = lerp(kickSize, nkickSize, 0.1);
    snareSize = lerp(snareSize, nsnareSize, 0.1);
    hatSize = lerp(hatSize, nhatSize, 0.1);

    kick = snare = hat = false;

    if (beat.isKick()) {
      nkickSize = 1;
      kick();
    }
    if (beat.isSnare()) {
      nsnareSize = 1;
      snare();
    }
    if (beat.isHat()) {
      nhatSize = 1;
      hat();
    }

    fft.forward(song.mix);
  }

  void show() {

    strokeWeight(1);
    noStroke();
    fill(240);
    rect(30, height-50, 8, 60);
    rect(50, height-50, 8, 60);
    rect(70, height-50, 8, 60);

    fill(0);
    rect(30, height-50, 8, 60*kickSize);
    rect(50, height-50, 8, 60*snareSize);
    rect(70, height-50, 8, 60*hatSize);


    noFill();
    stroke(240);
    float xx = 80;
    float yy = height-20;
    for (int i = 0; i < fft.specSize(); i++) {
      float amp = fft.getBand(i)*0.4;
      line(xx+i*3, yy, xx+i*3, yy - amp);
    }

    noFill();
    float ww = in.bufferSize()/5;
    float hh = 60;
    rect(xx+ww*0.5+10, yy+hh*0.5-60, ww, hh);

    float amp = 30;
    float y1 = yy-amp*1.5;
    float y2 = yy-amp*0.5;
    for (int i = 0; i < in.bufferSize() - 1; i+=5) {
      int ix = i/5+10;
      line(ix+xx, y1 + in.left.get(i)*amp, ix+1+xx, y1 + in.left.get(i+1)*amp);
      line(ix+xx, y2 + in.right.get(i)*amp, ix+1+xx, y2 + in.right.get(i+1)*amp);
    }
  }



  void kick() {
    if (timeWaitKick > 0) return;
    timeWaitKick = 0.1;

    kick = true;
  }

  void snare() {

    if (timeWaitSnare > 0) return;
    timeWaitSnare = 0.1;

    snare = true;
  }

  void hat() {

    if (timeWaitSnare > 0) return;
    timeWaitSnare = 0.1;

    hat = true;
  }
}

class BeatListener implements AudioListener
{
  private BeatDetect beat;
  private AudioInput source;

  BeatListener(BeatDetect beat, AudioInput source)
  {
    this.source = source;
    this.source.addListener(this);
    this.beat = beat;
  }

  void samples(float[] samps)
  {
    beat.detect(source.mix);
  }

  void samples(float[] sampsL, float[] sampsR)
  {
    beat.detect(source.mix);
  }
} 
