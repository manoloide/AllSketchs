import java.util.regex.*;

float sfm(String ori) {  
  //remove char space
  ori = ori.replace(" ", ""); 

  String reg = "((?<=[\\+|\\*|\\-])|(?=[\\+|\\*|\\-]))";
  String[] spl = ori.split(reg);
  while (spl.length > 1) {
    for (int i = 0; i < spl.length; i++) {
      if (spl[i].matches("[-]?[0-9]*\\.?[0-9]+")) {
        print("is number");
      } else {
        float val = 0;
        if (spl[i].equals("+")) {
          val = float(spl[i-1])+float(spl[i+1]);
          spl[i-1] = str(val);
        }
        if (spl[i].equals("-")) {
          val = float(spl[i-1])-float(spl[i+1]);
          spl[i-1] = str(val);
        }
        spl = (String[])concat(subset(spl, 0, i), subset(spl, i+1, spl.length-i-1));
        spl = (String[])concat(subset(spl, 0, i), subset(spl, i+1, spl.length-i-1));
        i--;
        //print("is operator");
      }
      println(spl[i]);
    }
  }



  /* sacar numeros
   Pattern pattern = Pattern.compile("[-]?[0-9]*\\.?[0-9]+");
   Matcher matcher = pattern.matcher(ori);
   while (matcher.find()) {
   println(matcher.group());
   }
   */

  return float(spl[0]);
}


float sfm(String s, float x){  
 String ns = s.replace("x", str(x));
 return sfm(ns);
 }
 
 float sfm(String s, float x, float y){ 
 String ns = s.replace("x", str(x));
 ns = ns.replace("y", str(y)); 
 return sfm(ns);
 }
 
 float sfm(String s, float x, float y, float z){ 
 String ns = s.replace("x", str(x));
 ns = s.replace("y", str(y));
 ns = s.replace("z", str(z));
 return sfm(ns);
 }

