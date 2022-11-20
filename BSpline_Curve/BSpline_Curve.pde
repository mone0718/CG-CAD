//n次のB-Spline曲線を描画

class BSplineCurve {

    int[] u; //ノット
    int k; //B-Spline曲線の次数
    int t_max; //tの最大値:nとkによって決まる
    float t_step; //rsごと
    float[][] N; //B-Spline関数
    PVector[] P; //制御点座標
    PVector[] R; //曲線上の座標

    BSplineCurve(int _k) {
        k = _k;

        int rs = 200; //滑らかさ
        R = new PVector[rs+1];
        u = new int[n+k+1];
        N = new float[n+k][n+2]; //n+k: n+2:

        P = new PVector[n+1];

        t_max = n-k+2;

        t_step = (float)t_max/rs;

        // Control Points
        for (int i = 0; i < n+1; i++) {
            P[i] = new PVector();
            P[i].x = 50 + 70*i;
            P[i].y = (i%2 == 0) ? 100 : 300;
        }
    }

    int knot(int j, int n, int k) {
        int uj = 0;
        if (j < k) {
            uj = 0;
        } else if ( k <= j && j <= n) {
            uj = j-k+1;
        } else if ( j > n ) {
            uj = n-k+2;
        }
        return uj;
    }


    void draw(color c) {
        noFill();
        stroke(c);

        // knot vectors
        for ( int j = 0; j <= n+k; j++) u[j] = knot(j, n, k);

        // 0<t<t_max
        int tt = 0;
        for ( float t = 0.0; t < (t_max+1e-6); t = t + t_step ) {
            
            int ii, kk;

            // k = 1
            for ( ii = 0; ii < n+2; ii++ ) {
                if (u[ii] <= t && t <= u[ii+1]) {
                    N[ii][1] = 1;
                } else {
                    N[ii][1] = 0;
                }
            }
            // k > 1
            float d=0, e=0;
            for ( kk = 2; kk <= k; kk++ ) {
                for ( ii = 0; ii <= (n+k)-kk; ii++ ) {
                    d = (u[ii+kk-1] - u[ii] != 0) ? (t-u[ii]) * N[ii][kk-1] / (u[ii+kk-1]-u[ii])
                        : 0;
                    e = (u[ii+kk] - u[ii+1] != 0) ? (u[ii+kk]-t) * N[ii+1][kk-1] / (u[ii+kk]-u[ii+1])
                        : 0;
                    N[ii][kk] = d + e;
                }
            }

            // R(t)
            R[tt] = new PVector();
            for (int i = 0; i < n+1; i++) {
                R[tt].x += N[i][k] * P[i].x;
                R[tt].y += N[i][k] * P[i].y;
            }

            // line
            if (tt!=0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);

            tt = tt + 1;
        }
    }
}

void drawControlPoints(BSplineCurve b) {
    // control points
    fill(0, 255, 255);
    for (int i = 0; i < n+1; i++) {
        ellipse(b.P[i].x, b.P[i].y, 5, 5);
    }
    // text control points
    fill(255, 255, 255);
    for (int i = 0; i < n+1; i++) {
        text("P" + i, b.P[i].x+15, b.P[i].y+15);
    }
}

void drawLabel(int n) {
    fill(255, 255, 255);
    text("BSplineCurve : n=" + n, 10, 20);
}

//BSplineCurve b0, b1, b2;
ArrayList<BSplineCurve> b;

int n = 7; //制御点の数-1
int sizeW;

void settings() {
    sizeW = 100 + 70*n;
    size(sizeW, 400);
}

void setup() {
    background(40);
    b = new ArrayList<BSplineCurve>();

    for (int i = 0; i < n; i++) {
        b.add(new BSplineCurve(i+2));
    }
}

void draw() {
    background(40);

    for (int i = 0; i < n; i++) {
        b.get(i).P[0].x = mouseX;
        b.get(i).P[0].y = mouseY;
    }

    drawLabel(n);
    drawControlPoints(b.get(0));

    b.get(0).draw(color(255, 0, 255));
    for (int i = 1; i < n; i++) {
        b.get(i).draw(color(255, 0, 255-(255/n)*i/1.5));
    }
}
