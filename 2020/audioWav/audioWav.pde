import javax.sound.sampled.*;
import java.io.*;

void setup() {
  size(240, 540);
}

void draw() {

  background(20);

  noFill();
  stroke(255, 140);
  rect(20, 20, 200, 80);

  if (pcm_data != null) {
    beginShape();
    for (int i = 0; i < pcm_data.length; i+=400) {
      float nv = (float)raw_data[i]/128.0;
      float x = 20+map(i, 0, pcm_data.length, 0, 200);
      float y = 20+40+nv*40;
      vertex(x, y);
    }
    endShape();
  }
}

double[] raw_data;
byte[] pcm_data;
void mousePressed() {
  raw_data = new double[44100*2];
  pcm_data = new byte[44100*2];
  double L1 = 44100.0/240.0;
  double L2 = 44100.0/245.0;
  for (int i=0; i < pcm_data.length; i++) {
    raw_data[i] = 55*Math.sin((i/L1)*Math.PI*2);
    raw_data[i] += 55*Math.sin((i/L2)*Math.PI*2);
    pcm_data[i] = (byte)(raw_data[i]);
  }

  AudioFormat frmt = new AudioFormat(44100, 8, 1, true, true);
  AudioInputStream ais = new AudioInputStream(
    new ByteArrayInputStream(pcm_data), frmt, 
    pcm_data.length / frmt.getFrameSize()
    );

  try {
    AudioSystem.write(ais, AudioFileFormat.Type.WAVE, new
      File(sketchPath()+"/test.wav")
      );
  } 
  catch(Exception e) {
    e.printStackTrace();
  }
}
