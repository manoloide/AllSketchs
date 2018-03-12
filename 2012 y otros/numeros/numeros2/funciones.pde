int sumaDigitos(int num) {
  int suma = int(num/10)+(num%10);
  if (num >= 10) {
    suma = sumaDigitos(suma);
  }
  return suma;
}

int cantidadDigitos(int num) {
  int cant = 0;
  while (num != 0) {
    num /= 10;
    cant++;
  }
  return cant;
}

int factorial(int num) {
  int fac = 1;
  for (int i = 2; i <= num; i++) {
    fac *= i;
  }
  return fac;
}

int sumatoria(int num) {
  int sum = 0;
  for (int i = 1; i <= num; i++) {
    sum += i;
  }
  return sum;
}

String binario(int num) {
  String bi = "";
  if (num == 0) {
    return "0";
  }
  while (num != 0) {
    if (num%2 == 1) {
      bi = "1"+bi;
    } 
    else {
      bi = "0"+bi;
    }
    num = num/2;
  }
  return bi;
}

int bits(int num) {
  int b = 1;
  while (pow (2, b) <= num) {
    b++;
  }
  return b;
}

