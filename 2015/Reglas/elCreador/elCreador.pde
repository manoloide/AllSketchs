import java.text.SimpleDateFormat;
import java.util.Calendar;

void setup(){
	File path = new File(sketchPath+"/..");
	int n = path.listFiles().length;
	String nameFolder = "Hijo"+nf(n, 3);
	File folder = new File("../"+nameFolder);
	folder.mkdirs();
	String srcFile = (folder.toString()+"/"+nameFolder+".pde");

	//String funciones[] = {};
	String tiempos[] = {"5m", "10m", "15m", "20m", "30m", "45m", "1h"};
	String code = "/*---------------------------\n";
	code += "Tiempo: "+tiempos[int(random(tiempos.length))]+"...\n\n";
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd 'a las' HH:mm:ss");
	code += "Creado: "+ sdf.format(Calendar.getInstance().getTime())+"\n";
	code += "---------------------------*/\n\n";
	code += "void setup(){\n";
	code += "\tsize(600, 600);\n";
	code += "}\n\n";
	code += "void draw(){\n";
	code += "\t\n";
	code += "}\n";
	String[] codeList = split(code, '\n');

	saveStrings(srcFile, codeList);
}