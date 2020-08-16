import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage; //Import the MidiMessage classes http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/MidiMessage.html
import javax.sound.midi.SysexMessage;
import javax.sound.midi.ShortMessage;

MidiBus myBus; // The MidiBus
MidiThread midi;

int step = 0;
int cc = 16;
int grid[][];

void setup() {
  size(400, 400, P3D);
  background(0);


  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.
  myBus = new MidiBus(this, 0, "Boutique SH-01A"); // Create a new MidiBus object

  midi=new MidiThread(160);
  midi.start();

  grid = new int[cc][cc];
}

void draw() {

  float ss = width/(cc+2);
  float bb = 0.5;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      if (grid[i][j] == 0) {
        int note = j%12;
        fill(30);
        if (note == 1 || note == 3 || note == 6 || note == 8 || note == 10) {
          fill(20);
        }
        if (i == step) fill(60);
      } else fill(240);
      rect(ss*(i+1)+bb, ss*(j+1)+bb, ss-bb*2, ss-bb*2);
    }
  }


  sendNotes();
}

void keyPressed() {
  if (key == 'r') randomNotes(); 
  if (key == ' ') clearNotes();
}

void clearNotes() {
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      grid[i][j] = 0;
    }
  }
}

void randomNotes() {
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      grid[i][j] = (random(1) > 0.2/cc)? grid[i][j] : (1+grid[i][j])%2;
    }
  }
}

void mouseDragged() {
  float ss = width/(cc+2);
  int mx = int(mouseX/ss-1); 
  int my = int(mouseY/ss-1); 

  if (mx < 0 || mx >= cc || my < 0 || my >= cc) return;

  grid[mx][my]++;
  grid[mx][my] %= 2;
}

void mousePressed() {
  float ss = width/(cc+2);
  int mx = int(mouseX/ss-1); 
  int my = int(mouseY/ss-1); 

  if (mx < 0 || mx >= cc || my < 0 || my >= cc) return;

  grid[mx][my]++;
  grid[mx][my] %= 2;
}

void sendNotes() {

  int channel = 0;
  int velocity = 127;
  for (int j = 0; j < cc; j++) {

    if (grid[step][j] == 0) continue;
    int pitch = 24+j;

    int time = 2;//int(map(mouseX, 0, width, 200, 800));

    myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    //delay(time*2);
    myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
    //delay(time);
  }
}

// Notice all bytes below are converted to integeres using the following system:
// int i = (int)(byte & 0xFF) 
// This properly convertes an unsigned byte (MIDI uses unsigned bytes) to a signed int
// Because java only supports signed bytes, you will get incorrect values if you don't do so

void rawMidi(byte[] data) { // You can also use rawMidi(byte[] data, String bus_name)
  // Receive some raw data
  // data[0] will be the status byte
  // data[1] and data[2] will contain the parameter of the message (e.g. pitch and volume for noteOn noteOff)
  println();
  println("Raw Midi Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+(int)(data[0] & 0xFF));
  // N.B. In some cases (noteOn, noteOff, controllerChange, etc) the first half of the status byte is the command and the second half if the channel
  // In these cases (data[0] & 0xF0) gives you the command and (data[0] & 0x0F) gives you the channel
  for (int i = 1; i < data.length; i++) {
    println("Param "+(i+1)+": "+(int)(data[i] & 0xFF));
  }
}

void midiMessage(MidiMessage message) { // You can also use midiMessage(MidiMessage message, long timestamp, String bus_name)
  // Receive a MidiMessage
  // MidiMessage is an abstract class, the actual passed object will be either javax.sound.midi.MetaMessage, javax.sound.midi.ShortMessage, javax.sound.midi.SysexMessage.
  // Check it out here http://java.sun.com/j2se/1.5.0/docs/api/javax/sound/midi/package-summary.html
  println();
  println("MidiMessage Data:");
  println("--------");
  println("Status Byte/MIDI Command:"+message.getStatus());
  for (int i = 1; i < message.getMessage().length; i++) {
    println("Param "+(i+1)+": "+(int)(message.getMessage()[i] & 0xFF));
  }
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
