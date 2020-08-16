ArrayList<String> antcommand;
String in, view;
PFont font;
PImage peron; 

void setup() {
	size(displayWidth, displayHeight);
	noCursor();
	peron = loadImage("http://fmla975.com/wp-content/uploads/2014/06/24022010.1.jpg");
	antcommand = new ArrayList<String>();
	font = createFont("DejaVu Sans Mono", 16, true);
	//println(PFont.list());
	textFont(font);
	textAlign(LEFT, TOP);
	in = "";
	view = "";
}

void draw() {
	background(16);	
	if(in.equals("peron")) image(peron, (width-peron.width)/2, (height-peron.height)/2);
	String txt = view+">"+in;
	if(frameCount%60 < 30) txt += "|";
	text(txt, 2, 2, width-4, height-4);

	String content = "Manoloide - 2014 "+hour()+":"+minute()+":"+second()+"\nDay: "+day()+" || Month: "+month()+" || Year: "+year();
	ventana(400, 20, 380, 200, "Hola guapon!", content);
	ventana(400, 280, 380, 200, "Process list", executeCommand("dir"));
}

void keyPressed(){
	if(keyCode == ENTER){
		String rest = executeCommand(in);
		view += in+"\n";
		if(rest.length() > 0) view += rest+"\n";
		antcommand.add(in);
		in = "";
	}
	else if(keyCode == BACKSPACE){
		int len = in.length(); 
		if(len > 0) in = in.substring(0, len-1);
	}else{
		in += key;
	}
}

boolean sketchFullScreen() {
	return true;
}

void ventana(int x, int y, int w, int h, String title, String content){
	noStroke();
	fill(#DDDDDD);
	rect(x, y, textWidth(title)+8, 20);
	fill(16);
	text(title, x+4, y);
	
	strokeWeight(1.5);
	stroke(#DDDDDD);
	noFill();
	rect(x, y+30, w, h, 1);
	fill(#DDDDDD);
	//String content = "Manoloide - 2014 "+hour()+":"+minute()+":"+second()+"\nDay: "+day()+" || Month: "+month()+" || Year: "+year();
	text(content, x+24, y+54);
	
	/*
	String title = "Prueba1 id(34468303) - dead process";
	noStroke();
	fill(#DDDDDD);
	rect(40, 40, textWidth(title)+8, 20);
	fill(16);
	text(title, 44, 40);

	strokeWeight(1.5);
	stroke(#DDDDDD);
	noFill();
	rect(40, 70, 380, 200, 1);
	fill(#DDDDDD);
	text("Manoloide - 2014 "+hour()+":"+minute()+":"+second()+"\nDay:"+day()+"\nMonth:"+month()+"\nYear:"+year(), 64, 94);
	*/
}

import java.io.BufferedReader;
import java.io.InputStreamReader;

String executeCommand(String command) {
	StringBuffer output = new StringBuffer();
	Process p;
	try {
		p = Runtime.getRuntime().exec(command);
		p.waitFor();
		BufferedReader reader = 
		new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line = "";			
		while ((line = reader.readLine())!= null) {
			output.append(line + "\n");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	return output.toString();
}