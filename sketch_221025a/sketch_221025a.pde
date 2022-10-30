class BezierCurve {
  
    PVector P0, P1, P2, P3, P4;
    PVector[] R;
    int tn;
  
    BezierCurve() {
        P0 = new PVector(); P0.x = 150; P0.y = 50;
        P1 = new PVector(); P1.x = 200; P1.y = 60;
        P2 = new PVector(); P2.x = 250; P2.y = 90;
        P3 = new PVector(); P3.x = 300; P3.y = 140;
        P4 = new PVector(); P4.x = 350; P4.y = 210;
        
        tn = 10;
        R = new PVector[tn + 1];
    }
    
    int binom (int n,int r){
        int val;
        r = min(r, n-r);
        if (r == 0){
            val = 1;
        }else{
            val = binom(n-1, r-1)*n/r;
        }
        return val;
    }
  
    void draw() {
    
        int   tt;
        float t=0.0;
        float ts = (float)1 / tn;
        float[] B;
    
        stroke(0, 255, 255);
        fill(0, 255, 255, 30);
        
        beginShape();
        vertex(P0.x, P0.y);
        vertex(P1.x, P1.y);
        vertex(P2.x, P2.y);
        vertex(P3.x, P3.y);
        vertex(P4.x, P4.y); 
        endShape( CLOSE );
        
        line(P0.x, P0.y, P1.x, P1.y);
        line(P1.x, P1.y, P2.x, P2.y);
        line(P2.x, P2.y, P3.x, P3.y);
        line(P3.x, P3.y, P4.x, P4.y);
        
        fill(0, 255, 255);
        ellipse(P0.x, P0.y, 10, 10);
        ellipse(P1.x, P1.y, 10, 10);
        ellipse(P2.x, P2.y, 10, 10);
        ellipse(P3.x, P3.y, 10, 10);
        ellipse(P4.x, P4.y, 10, 10); 
        
        // text control points 
        fill(255, 255, 255);
        text("P0", P0.x+15, P0.y   ); // p0
        text("P1", P1.x,    P1.y-15); // p1
        text("P2", P2.x+10, P2.y-15); // p2
        text("P3", P3.x-30, P3.y   ); // p3 
        text("P4", P4.x+15, P4.y   ); // p4
        
        
        noFill();
        stroke(255, 255, 255);
        
        int n = 4;
        B = new float[n+1];
        
        for(tt = 0; tt < tn + 1; tt+=1) {
            for(int r = 0; r <= n; r++){
                B[r] =  binom(n,r) * pow(1-t,n-r) * pow(t,r);
            }
            
            R[tt] = new PVector();
            R[tt].x = B[0] * P0.x + B[1] * P1.x + B[2] * P2.x + B[3] * P3.x + B[4] * P4.x;
            R[tt].y = B[0] * P0.y + B[1] * P1.y + B[2] * P2.y + B[3] * P3.y + B[4] * P4.y; 

            if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);               
            
        t = t + ts;
        //println(P0);
        }
        println(R[1]+" 1");
        println(R[2]+" 2");
    }
}



BezierCurve b0;
void setup() {
    size(400, 400);
    b0 = new BezierCurve();
}

void draw() {
    background(40);
  
    text("BezierCurve", 10, 20);
  
    b0.P0.x = mouseX; b0.P0.y = mouseY;
  
    b0.draw();
}
