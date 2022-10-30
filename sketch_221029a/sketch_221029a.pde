void setup() {
  size(300, 300);
  background(255);
  noLoop();
}
 
void draw() {
    for(int i = 1; i <= 5; i++){
        int product = binom(i, 2);
        print(product);
    }
}

int binom (int n,int r){
    int val;
    if (r == 0){
        val = 1;
    }else{
        val = binom(n-1, r-1)*n/r;
    }
    return val;
}
