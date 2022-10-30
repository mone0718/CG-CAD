//DDAで直線を引く
//1~4は小数点とか除算 これを工夫して整数だけでできるように

//アルゴリズム部門 傾き全部の範囲でできるように改良
//作品部門 line関数使って作品

// Vertex Class
class CVertex {
  int x;
  int y;
  CVertex() { x=0; y=0; } 
  void draw() {
    set(x, y, color(255));
  }
}

CVertex v0;
CVertex v1;

void setup() {
  size(400, 400);
    background(40); 

    v0 = new CVertex(); v0.x = 200;  v0.y = 200;
    v1 = new CVertex(); v1.x = 222; v1.y = 100;

}

void draw(){
    //background(40);
    
    int dx = v1.x - v0.x;
    int dy = v1.y - v0.y;
    float e = 0.0; // 2
    //int E = -dx;
    //int F = -dy;
    int x, y; 

    x = v0.x; 
    y = v0.y; 
    
    v1.x = mouseX;
    v1.y = mouseY;
    
    text("x : "+ v1.x, 40,10);
    text("y : "+ v1.y, 40,20);
    //text("F : "+ F, 40,30);
    

        

    
    for( ; x<v1.x; x++ ) { 
        set(x,y,color(0, 100, 255));
        e = e + (float)dy/dx;    // 3
        //E = E + 2*dy;
        
        if(e >= 0.5) {   // 1
            y = y + 1; 
            e = e - 1;     // 4
            //E = E - 2*dx;
        }else if (e <= -0.5){
            y = y - 1;
            e = e + 1;
            //E = E + 2*dx;
        }
        
    }
    
    for( ; y>v1.y; y-- ) { 
        
        set(x,y,color(0, 100, 255));
        F = F + 2*dx;
        
        if(F >= 0) {
            x = x + 1; 
            F = F + 2*dy;
        }else if(F <= 0){
            x = x - 1;
            F = F - 2*dy;
        }
        
    }
}
