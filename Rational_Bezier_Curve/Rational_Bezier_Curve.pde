//3次のベジエ曲線を有理化する
//q:P0のウェイト+0.1 Q:P0のウェイト-0.1
//w:P1のウェイト+0.1 W:P1のウェイト-0.1
//e:P2のウェイト+0.1 E:P2のウェイト-0.1
//r:P3のウェイト+0.1 R:P3のウェイト-0.1

class BezierCurve {

    PVector P0, P1, P2, P3;
    PVector[] R;
    int tn;

    float[] w;

    BezierCurve() {
        w = new float[4]; // Weight

        P0 = new PVector();
        P0.x =  20;
        P0.y = 300;
        w[0] = 1;

        P1 = new PVector();
        P1.x = 140;
        P1.y = 100;
        w[1] = 1;

        P2 = new PVector();
        P2.x = 280;
        P2.y = 100;
        w[2] = 1;

        P3 = new PVector();
        P3.x = 380;
        P3.y = 300;
        w[3] = 1;

        tn = 100;
        R = new PVector[tn+1];
    }

    void draw() {

        int   i, tt;
        float t=0.0;
        float ts = (float)1 / tn;
        float B30t, B31t, B32t, B33t;

        stroke(0, 255, 255);
        fill(0, 255, 255, 30);
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
        text("P1", P1.x, P1.y-15); // p1
        text("P2", P2.x+10, P2.y-15); // p2
        text("P3", P3.x-30, P3.y   ); // p3

        noFill();
        stroke(255, 255, 255);

        for (tt = 0; tt < tn+1; tt+=1) {
            B30t = (1-t)*(1-t)*(1-t);
            B31t = 3*(1-t)*(1-t)*t;
            B32t = 3*(1-t)*t*t;
            B33t = t*t*t;

            // weight sum
            float sum = w[0] * B30t + w[1] * B31t + w[2] * B32t + w[3] * B33t;

            //R[t]
            R[tt] = new PVector();
            R[tt].x = (w[0]*B30t*P0.x + w[1]*B31t*P1.x + w[2]*B32t*P2.x + w[3]*B33t*P3.x) / sum;
            R[tt].y = (w[0]*B30t*P0.y + w[1]*B31t*P1.y + w[2]*B32t*P2.y + w[3]*B33t*P3.y) / sum;

            if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);

            t = t + ts;
        }
    }
}

BezierCurve b0;
void setup() {
    size(400, 400);
    b0 = new BezierCurve();
}

void drawWeight() {
    for (int i = 0; i <= 3; i++) {
        text("w"+i+" = "+nf(b0.w[i], 2, 2), 10, 35+15*i);
    }
}

void draw() {
    background(40);

    text("BezierCurve", 10, 20);

    drawWeight();

    b0.P0.x = mouseX;
    b0.P0.y = mouseY;

    b0.draw();
}

void keyPressed() {
    if (key == 'q') {
        b0.w[0]+=0.1;
    } else if (key == 'Q') {
        b0.w[0]-=0.1;
    } else if (key == 'w') {
        b0.w[1]+=0.1;
    } else if (key == 'W') {
        b0.w[1]-=0.1;
    } else if (key == 'e') {
        b0.w[2]+=0.1;
    } else if (key == 'E') {
        b0.w[2]-=0.1;
    } else if (key == 'r') {
        b0.w[3]+=0.1;
    } else if (key == 'R') {
        b0.w[3]-=0.1;
    }
}
