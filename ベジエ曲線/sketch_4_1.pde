class BezierCurve {

    int n = 5;
    PVector[] P;
    PVector[] R;
    int tn;


    BezierCurve() {
        P = new PVector[n+1];
        for (int i = 0; i < n+1; i++) {
            P[i] = new PVector();
            P[i].x = 150 + 50 * i;
            P[i].y = 50 + 10 * pow(i, 2);
        }
        //print(P[1].x+ " ");

        tn = 1000;
        R = new PVector[tn+1];
    }


    void draw_area() {
        stroke(0, 255, 255);
        fill(0, 255, 255, 30);
        //P = new PVector[n+1];

        beginShape();
        for (int i = 0; i < n+1; i++) {
            //P[i] = new PVector();
            vertex(P[i].x, P[i].y);
            //print(P[0].x+ " ");
        }
        endShape( CLOSE );
        //print(P[2].x+ " ");
    }

    void draw_line() {
        for (int i = 0; i < n; i++) {
            //P[i]= new PVector();
            line(P[i].x, P[i].y, P[i+1].x, P[i+1].y);
        }
        //print(P[2].x+ " ");
    }

    void draw_circle() {
        fill(0, 255, 255);
        for (int i = 0; i < n+1; i++) {
            //P[i] = new PVector();
            ellipse(P[i].x, P[i].y, 10, 10);
        }
        //print(P[2].x+ " ");
    }

    void draw_text() {
        fill(255, 255, 255);
        for (int i = 0; i < n+1; i++) {
            //P[i] = new PVector();
            text("P" + i, P[i].x+15, P[i].y+15);
        }
    }

    void draw_curve() {
        int   tt;
        float t=0.0;
        float ts = (float)1 / tn;
        float[] B; //二項定理を一段階増やす
        B = new float[n+1];

        noFill();
        stroke(255, 255, 255);

        for (tt = 0; tt < tn + 1; tt+=1) {
            for (int r = 0; r < n+1; r++) {
                B[r] =  binom(n, r) * pow(1-t, n-r) * pow(t, r); //基底関数
            }

            R[tt] = new PVector();
            //P[r] = new PVector();
            for (int a = 0; a < n+1; a++) {
                R[tt].x += B[a] * P[a].x;
                R[tt].y += B[a] * P[a].y;
            }
            if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);

            t = t + ts;
        }
        println(R[1]+" 1");
        println(R[2]+" 2");
    }

    int binom (int n, int r) {  //二項定理
        int val;
        r = min(r, n-r);
        if (r == 0) {
            val = 1;
        } else {
            val = binom(n-1, r-1) * n/r;
        }
        return val;
    }

    void draw() {
        //println(P[2] + " 0");
        draw_area();
        //println(P[2] + " 1");
        draw_line();
        //println(P[2] + " 2");
        draw_circle();
        //println(P[2] + " 3");
        draw_text();
        //println(P[2] + " 4");
        draw_curve();
        //println(P[2] + " 5");

        /*
        //print(P[0].x+ " ");
         
         stroke(0, 255, 255);
         fill(0, 255, 255, 30);
         
         beginShape();
         vertex(P[i].x, P[i].y);
         print(P[0].x+ " ");
         endShape( CLOSE );
         
         //print(P[1].x+ " ");
         
         //if (i != 0) line(P[i-1].x, P[i-1].y, P[i].x, P[i].y);
         
         //P[i] = new PVector();
         fill(0, 255, 255);
         ellipse(P[i].x, P[i].y, 10, 10);
         
         fill(255, 255, 255);
         text("P"+i, P[i].x+15, P[i].y   ); // p0
         
         int   tt;
         float t=0.0;
         float ts = (float)1 / tn;
         float[] B; //二項定理を一段階増やす
         B = new float[n+1];
         
         noFill();
         stroke(255, 255, 255);
         
         for(tt = 0; tt < tn + 1; tt+=1) {
         for(int r = 0; r < n+1; r++){
         B[r] =  binom(n,r) * pow(1-t,n-r) * pow(t,r); //基底関数
         
         P[r] = new PVector();
         R[tt] = new PVector();
         R[tt].x = B[r] * P[r].x;
         R[tt].y = B[r] * P[r].y;
         //print(tt+" ");
         
         if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);
         
         t = t + ts;
         }
         //print(R[9]+" ");
         }
         */
    }
    //print(P[1].x+ " ");
}


BezierCurve b0;
void setup() {
    size(400, 400);
    b0 = new BezierCurve();
    println("hogehoge");
    println(b0.P[2] + "b0");
    /*
    for (int i = 0; i < 4; i++) {
     print(b0.P[i].x);
     }*/
}

/*
void createNPoints(int n) {
 
 }
 */

void draw() {
    background(40);

    text("BezierCurve", 10, 20);

    b0.P[0].x = mouseX;
    b0.P[0].y = mouseY;

    //println(b0.P[2] + " -1");
    b0.draw();
}
