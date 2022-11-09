class BezierCurve2 {
  PVector P0, P1, P2;
  PVector[] R;
  int tn;
  
  BezierCurve2() {
    P0 = new PVector(); P0.x =  20; P0.y = 300;
    P1 = new PVector(); P1.x = 210; P1.y = 100;
    P2 = new PVector(); P2.x = 380; P2.y = 300;

    tn = 100;
    R = new PVector[tn];
  }
  
  
  void draw(color c) {
    int   i, tt;
    float t=0.0;
    float ts = (float)1 / tn;
    float B20t, B21t, B22t;

    stroke(255, 255, 0);
    fill(255, 255, 0, 50);
    triangle(P0.x, P0.y, P1.x, P1.y, P2.x, P2.y);
    line(P0.x, P0.y, P1.x, P1.y);
    line(P1.x, P1.y, P2.x, P2.y);
    
    fill(255, 255, 0);
    ellipse(P0.x, P0.y, 10, 10);
    ellipse(P1.x, P1.y, 10, 10);
    ellipse(P2.x, P2.y, 10, 10);
    
    // text control points 
    fill(255, 255, 255);
    text("P0", P0.x+15, P0.y   ); // p0
    text("P1", P1.x,    P1.y-15); // p1
    text("P2", P2.x+10, P2.y-15); // p2
    
    noFill();
    stroke(c);
    
    for(tt = 0; tt < tn ; tt+=1) {
        B20t =     (1-t)*(1-t)         ; 
        B21t = 2 *       (1-t)       *t;
        B22t =                      t*t; 
        R[tt] = new PVector();
        R[tt].x = B20t*P0.x + B21t*P1.x + B22t*P2.x;
        R[tt].y = B20t*P0.y + B21t*P1.y + B22t*P2.y;
      if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);
      
      t = t + ts;
    }
  }  
  
  void degreeElevation(BezierCurve3 b) {    
    b.P0.x = P0.x; b.P0.y = P0.y;
    b.P1.x = (P0.x + 2*P1.x)/3; b.P1.y = (P0.y + 2*P1.y)/3;
    b.P2.x = (2*P1.x + P2.x)/3; b.P2.y = (2*P1.y + P2.y)/3;
    b.P3.x = P2.x; b.P3.y = P2.y; 
  }
  
}

class BezierCurve3 {
  
  PVector P0, P1, P2, P3;
  PVector[] R;
  int tn;
  
  BezierCurve3() {
    P0 = new PVector(); P0.x =  20; P0.y = 300;
    P1 = new PVector(); P1.x = 140; P1.y = 100;
    P2 = new PVector(); P2.x = 280; P2.y = 100;
    P3 = new PVector(); P3.x = 380; P3.y = 300;
    
    tn = 100;
    R = new PVector[tn];
  }
  
  void draw(color c) {
    
    int   i, tt;
    float t=0.0;
    float ts = (float)1 / tn;
    float B30t, B31t, B32t, B33t;

    stroke(0, 255, 255);
    fill(0, 255, 255, 50);
    quad(P0.x, P0.y, P1.x, P1.y, P2.x, P2.y, P3.x, P3.y);
    line(P0.x, P0.y, P1.x, P1.y);
    line(P1.x, P1.y, P2.x, P2.y);
    line(P2.x, P2.y, P3.x, P3.y);
    
    fill(0, 255, 255);
    ellipse(P0.x, P0.y, 10, 10);
    ellipse(P1.x, P1.y, 10, 10);
    ellipse(P2.x, P2.y, 10, 10);
    ellipse(P3.x, P3.y, 10, 10);
    
    // text control points 
    fill(255, 255, 255);
    text("P0", P0.x+15, P0.y   ); // p0
    text("P1", P1.x,    P1.y-15); // p1
    text("P2", P2.x+10, P2.y-15); // p2
    text("P3", P3.x-30, P3.y   ); // p3    
    
    noFill();
    stroke(c);
    
    for(tt = 0; tt < tn ; tt+=1) {
        B30t =     (1-t)*(1-t)*(1-t)        ; 
        B31t = 3 * (1-t)*(1-t)       *t     ;
        B32t = 3 * (1-t)             *t*t   ; 
        B33t =                        t*t*t ;
        R[tt] = new PVector();
        R[tt].x = B30t*P0.x + B31t*P1.x + B32t*P2.x + B33t*P3.x;
        R[tt].y = B30t*P0.y + B31t*P1.y + B32t*P2.y + B33t*P3.y;
      if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);
      t = t + ts;
    }
  }
    
}

BezierCurve3 b0;
BezierCurve2 b1;

boolean up=false;

void setup() {
  size(400, 400);
  b0 = new BezierCurve3();
  b1 = new BezierCurve2();
}

void draw() {
  background(40);
  
  fill(255, 255, 255);
  text("BezierCurve Degree Elevation Sample. Press 'u' key.", 10, 20);
  
  b1.P0.x = mouseX; b1.P0.y = mouseY;
  
  if(up) b0.draw(color(255, 255, 255));
  b1.draw(color(255, 255,  255));  
}

void keyPressed() {
  if (key=='u') {
    up = true;
    b1.degreeElevation(b0);
  }
}

void keyReleased() {
  up = false;
}


