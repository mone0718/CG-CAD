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
    set(x, y, color(255)); //指定した座標のピクセルを指定した色で塗りつぶす
  }
}

CVertex v0;
CVertex v1;

void setup() {
  size(400, 400);
	background(40); 

	v0 = new CVertex(); v0.x = 200;  v0.y = 200;
	v1 = new CVertex(); v1.x = 200; v1.y = 200;

}

void draw(){
    //background(40);
    
    int dx = v1.x - v0.x;
    int dy = v1.y - v0.y;
    //float e = 0.0; // 2
    int E = -dx;
    int F = -dy;
    int x, y; 

    x = v0.x; 
    y = v0.y; 
    
    v1.x = mouseX;
    v1.y = mouseY;
 
    
    if(dx == 0){
        
        set(x,y,color(0, 100, 255));
        
    }else if(dy <= dx && dy >= -dx){
        
        for( ; x<v1.x; x++ ) { 
            set(x,y,color(0, 100, 255));
            //e = e + (float)dy/dx;    // 3
            E = E + 2*dy;
            
            if(E >= 0) {   // 1
                y = y + 1; 
                //e = e - 1;     // 4
                E = E - 2*dx;
            }else{
                y = y - 1;
                E = E + 2*dx;
            }    
        }
        
    }else if(dy >= dx && dy <= -dx){
        for( ; x>v1.x; x-- ) { 
            
            set(x,y,color(0, 100, 255));
            E = E + 2*dy;
            
            if(E >= 0) {
                y = y + 1; 
                E = E + 2*dx;
            }else{
                y = y - 1;
                E = E - 2*dx;
            }
        }
    /*text("x : "+ x, 40,10);
    text("y : "+ y, 40,20);
    text("mousex : "+ mouseX, 40,40);
    text("mousey : "+ mouseY, 40,50);*/
     
    }else{
        
        for( ; y<v1.y; y++ ) { 
            
            set(x,y,color(0, 100, 255));
            F = F + 2*dx;
            
            if(F >= 0) {
                x = x + 1; 
                F = F - 2*dy;
            }else if(F <= 0){
                x = x - 1;
                F = F + 2*dy;
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
}
