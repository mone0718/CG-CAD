class BezierCurve {

    //int n = 5;
    PVector[] P;
    PVector[] R;
    int tn;

    BezierCurve(int n, ArrayList<PVector> Pos) {

        P = new PVector[n+1];
        for (int i = 0; i < n+1; i++) {
            P[i] = Pos.get(i);
            //P[i].x = position_x(n, i);
            //P[i].y = position_y(n, i);
        }

        tn = 100;
        R = new PVector[tn+1];
    }

    void draw_area(int n) {

        stroke(0, 255, 255);
        fill(0, 255, 255, 20);

        beginShape();
        for (int i = 0; i < n+1; i++) {
            vertex(P[i].x, P[i].y);
        }
        endShape( CLOSE );
    }

    void draw_line(int n) {

        stroke(255, 200, 200);

        for (int i = 0; i < n; i++) {
            line(P[i].x, P[i].y, P[i+1].x, P[i+1].y);
        }
    }

    void draw_circle(int n) {

        noStroke();
        fill(0, 255, 255);

        for (int i = 0; i < n+1; i++) {
            ellipse(P[i].x, P[i].y, 10, 10);
        }
    }

    void draw_text(int n) {

        fill(255, 255, 255);

        for (int i = 0; i < n+1; i++) {
            text("P" + i, P[i].x+15, P[i].y+15);
        }
    }

    void draw_curve(int n) {

        int tt;
        float t = 0.0;
        float ts = (float)1 / tn;
        float[] B;

        B = new float[n+1];

        noFill();
        stroke(255, 255, 255);

        for (tt = 0; tt < tn + 1; tt++) {
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

    void draw(int n) {

        draw_area(n);
        //draw_line(n);
        //draw_circle(n);
        draw_text(n);
        draw_curve(n);
    }
}

BezierCurve b0;

int state = 0; //0:初期(クリック) 1:表示
int count = -1; //制御点の数

ArrayList<PVector> clickPos;

void setup() {
    size(400, 400);
    clickPos = new ArrayList<PVector>();
}

void draw() {
    background(40);

    fill(255, 255, 255);
    text("BezierCurve", 10, 20);

    //b0.P[0].x = mouseX;
    //b0.P[0].y = mouseY;

    noStroke();
    fill(0, 255, 255);

    for (int i = 0; i < clickPos.size(); i++) {
        PVector pos = clickPos.get(i);
        ellipse(pos.x, pos.y, 10, 10);
    }

    if (state == 1) {
        b0 = new BezierCurve(count, clickPos);
        b0.draw(count);
    }
}

void mousePressed() {
    if (state == 0) {
        clickPos.add(new PVector(mouseX, mouseY));
        count++;
    }
}

void keyReleased() {
    if (key == 'd' && state == 0) {
        state = 1;
    } else if (key == 'r' && state == 1) {
        state = 0;
    }
}
