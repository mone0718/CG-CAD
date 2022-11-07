class BezierCurve {

    int n = 3;
    PVector[] P;
    PVector[] R;
    int tn;

    BezierCurve() {

        P = new PVector[n+1];
        for (int i = 0; i < n+1; i++) {
            P[i] = new PVector();
            P[i].x = position_x(n, i);
            P[i].y = position_y(n, i);
        }

        tn = 10;
        R = new PVector[tn+1];
    }

    void draw_area() {

        stroke(0, 255, 255);
        fill(0, 255, 255, 30);

        beginShape();
        for (int i = 0; i < n+1; i++) {
            vertex(P[i].x, P[i].y);
        }
        endShape( CLOSE );
    }

    void draw_line() {

        fill(0, 255, 255);

        for (int i = 0; i < n; i++) {
            line(P[i].x, P[i].y, P[i+1].x, P[i+1].y);
        }
    }

    void draw_circle() {

        noStroke();
        fill(0, 255, 255);

        for (int i = 0; i < n+1; i++) {
            ellipse(P[i].x, P[i].y, 10, 10);
        }
    }

    void draw_text() {

        fill(255, 255, 255);

        for (int i = 0; i < n+1; i++) {
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

            for (int a = 0; a < n+1; a++) {
                R[tt].x += B[a] * P[a].x;
                R[tt].y += B[a] * P[a].y;
            }

            if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);

            t = t + ts;
        }
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

    int position_x (int n, int i) {
        
        int x = 0;
        x = width / 2 - int(150 * cos(radians(180/n * i)));

        return x;
    }

    int position_y (int n, int i) {
        
        int y = 0;
        y = height / 2 + 50 - int(150 * sin(radians(180/n * i)));

        return y;
    }


    void draw() {

        draw_area();
        draw_line();
        draw_circle();
        draw_text();
        draw_curve();
        
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

    b0.P[0].x = mouseX;
    b0.P[0].y = mouseY;

    b0.draw();
}
