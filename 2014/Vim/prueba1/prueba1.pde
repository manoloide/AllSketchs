int car = 0;
int file = 0;
int line = 0;
String pdes[][];
PFont font;
void setup(){
	size(600, 320);
	font = createFont("Source Code Pro", 12, true);
	textFont(font);
	pdes = loadFiles();
	frameRate(60);
	textAlign(LEFT, TOP);
}
void draw(){
	background(20);
	int init = line-19;
	if(init < 0) init = 0;
	fill(250);
	for(int i = init; i <= line; i++){
		if(i < line || car >= pdes[file][i].length()){
			fill(250);
			text(pdes[file][i], 10, 16*(i-init));
		}
		else{
			fill(250);
			//println(frameCount, car, file, line, (pdes[file][line]).length());
			text((pdes[file][i]).substring(0,car), 10, 16*(i-init));
		}
	}
	car++;
	if(car >= (pdes[file][line]).length()){
		car = 0;
		line++;
		if(line >= pdes[file].length){
			file++;
			line = 0;
			if(file >= pdes.length) exit();
		}
	}
}

String[][] loadFiles(){
	ArrayList<File> files = listFiles(sketchPath+"/../../", "pde");
	int cant = files.size();
	String aux[][] = new String[cant][];
	for(int i = 0; i < cant; i++){
		aux[i] = loadStrings(files.get(i));
	}
	return aux;
}

ArrayList<File> listFiles(String src, String ext){
	ArrayList<File> aux = new ArrayList<File>();
	File master = new File(src);
	File files[] = master.listFiles();
	for(int i = 0; i < files.length; i++){
		String ruta = files[i].toString();
		if(files[i].isDirectory()){
			//println("Directorio: " + files[i].toString());
			aux.addAll(listFiles(ruta, ext));	
		}else{
			String extension = ruta.substring(ruta.lastIndexOf(".") + 1, ruta.length());
			if(extension.equals(ext)){
				aux.add(files[i]);
				//println("Archivo: " + files[i].getName());
			}
		}
	} 
	return aux;
}

