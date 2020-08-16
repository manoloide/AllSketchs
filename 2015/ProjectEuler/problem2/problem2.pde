int av = 1;
int v = 2;
int sum = 2;

while (v < 4000000) {
  int p = v;
  v += av;
  av = p; 
  if (v%2 == 0){
    sum += v;
    println(sum);
  }
}
println("suma", sum);

