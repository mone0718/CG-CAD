//1. Bezier曲線を次数上げする
//2. 次数上げしたBezier曲線を任意の LaTeX: tt の位置で分割する
//(3). 分割した曲線の一方を選択する
//(4). 1に戻る

class BezierCurve2 {
    PVector P0, P1, P2;
    PVector[] R;
    int tn;

    BezierCurve2() {
        P0 = new PVector();
        P0.x =  20;
        P0.y = 300;
        P1 = new PVector();
        P1.x = 210;
        P1.y = 100;
        P2 = new PVector();
        P2.x = 380;
        P2.y = 300;

        tn = 100;
        R = new PVector[tn];
    }


    void draw(color c) {
        int   i, tt;
        float t=0.0;
        float ts = (float)1 / tn;
        float B20t, B21t, B22t;

        stroke(70, 0, 255);
        fill(70, 0, 255, 50);
        triangle(P0.x, P0.y, P1.x, P1.y, P2.x, P2.y);
        line(P0.x, P0.y, P1.x, P1.y);
        line(P1.x, P1.y, P2.x, P2.y);

        fill(70, 0, 255);
        ellipse(P0.x, P0.y, 10, 10);
        ellipse(P1.x, P1.y, 10, 10);
        ellipse(P2.x, P2.y, 10, 10);

        // text control points
        fill(255, 255, 255);
        text("P0", P0.x+15, P0.y   ); // p0
        text("P1", P1.x, P1.y-15); // p1
        text("P2", P2.x+10, P2.y-15); // p2

        noFill();
        stroke(c);

        for (tt = 0; tt < tn; tt+=1) {
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
        b.P0.x = P0.x;
        b.P0.y = P0.y;
        b.P1.x = (P0.x + 2*P1.x)/3;
        b.P1.y = (P0.y + 2*P1.y)/3;
        b.P2.x = (2*P1.x + P2.x)/3;
        b.P2.y = (2*P1.y + P2.y)/3;
        b.P3.x = P2.x;
        b.P3.y = P2.y;
    }
}

class BezierCurve3 {

    PVector P0, P1, P2, P3;
    PVector[] R;
    int tn;

    BezierCurve3() {

        //制御点
        P0 = new PVector();
        P0.x =  20;
        P0.y = 300;

        P1 = new PVector();
        P1.x = 140;
        P1.y = 100;

        P2 = new PVector();
        P2.x = 280;
        P2.y = 100;

        P3 = new PVector();
        P3.x = 380;
        P3.y = 300;

        tn = 100; //滑らかさ
        R = new PVector[tn]; //ベジエ曲線上の点
    }

    void draw(color c) {

        int i, tt;
        float t=0.0;
        float ts = (float)1 / tn;
        float B30t, B31t, B32t, B33t;

        //台形
        stroke(0, 255, 255);
        fill(0, 255, 255, 30);
        quad(P0.x, P0.y, P1.x, P1.y, P2.x, P2.y, P3.x, P3.y);
        line(P0.x, P0.y, P1.x, P1.y);
        line(P1.x, P1.y, P2.x, P2.y);
        line(P2.x, P2.y, P3.x, P3.y);

        //制御点
        fill(0, 255, 255);
        ellipse(P0.x, P0.y, 10, 10);
        ellipse(P1.x, P1.y, 10, 10);
        ellipse(P2.x, P2.y, 10, 10);
        ellipse(P3.x, P3.y, 10, 10);

        // text control points
        fill(255, 255, 255);
        text("P0", P0.x+15, P0.y); // p0
        text("P1", P1.x, P1.y-15); // p1
        text("P2", P2.x+10, P2.y-15); // p2
        text("P3", P3.x-30, P3.y); // p3

        //ベジエ曲線
        noFill();
        stroke(c);
        for (tt = 0; tt < tn; tt+=1) {

            //ベルンシュタイン基底関数
            B30t =     (1-t)*(1-t)*(1-t)        ;
            B31t = 3 * (1-t)*(1-t)       *t     ;
            B32t = 3 * (1-t)             *t*t   ;
            B33t =                        t*t*t ;

            //ベジエ曲線
            R[tt] = new PVector();
            R[tt].x = B30t*P0.x + B31t*P1.x + B32t*P2.x + B33t*P3.x;
            R[tt].y = B30t*P0.y + B31t*P1.y + B32t*P2.y + B33t*P3.y;
            if (tt != 0) line(R[tt-1].x, R[tt-1].y, R[tt].x, R[tt].y);
            t = t + ts;
        }
    }

    void drawPointOnCurve(float t) {
        int   i, tt;
        float ts = (float)1 / tn;

        //基底関数:tはmouseXに合わせて動く0~1の値
        float B30t, B31t, B32t, B33t;
        B30t =     (1-t)*(1-t)*(1-t)        ;
        B31t = 3 * (1-t)*(1-t)       *t     ;
        B32t = 3 * (1-t)             *t*t   ;
        B33t =                        t*t*t ;

        //mouseXに合わせてベジエ曲線上を動く円
        stroke(0, 0, 0);
        fill(255, 255, 255);
        ellipse(B30t*P0.x + B31t*P1.x + B32t*P2.x + B33t*P3.x,
            B30t*P0.y + B31t*P1.y + B32t*P2.y + B33t*P3.y, 5, 5);
    }

    void split(float tx, BezierCurve3 b1, BezierCurve3 b2) {

        // de Casteljau Algorithm ド・カステリョ
        //P0~t:制御点
        PVector P00t = new PVector();
        P00t.x = P0.x;
        P00t.y = P0.y;

        PVector P01t = new PVector();
        P01t.x = P1.x;
        P01t.y = P1.y;

        PVector P02t = new PVector();
        P02t.x = P2.x;
        P02t.y = P2.y;

        PVector P03t = new PVector();
        P03t.x = P3.x;
        P03t.y = P3.y;

        //P1~t:制御点同士結んだ線分を(1-t):tに内分する点
        PVector P10t = new PVector();
        P10t.x = (1-tx)*P00t.x + tx*P01t.x;
        P10t.y = (1-tx)*P00t.y + tx*P01t.y;

        PVector P11t = new PVector();
        P11t.x = (1-tx)*P01t.x + tx*P02t.x;
        P11t.y = (1-tx)*P01t.y + tx*P02t.y;

        PVector P12t = new PVector();
        P12t.x = (1-tx)*P02t.x + tx*P03t.x;
        P12t.y = (1-tx)*P02t.y + tx*P03t.y;

        //P2~t:P1~tの隣り合う点同士結んだ線分を(1-t):tに内分する点
        PVector P20t = new PVector();
        P20t.x = (1-tx)*P10t.x + tx*P11t.x;
        P20t.y = (1-tx)*P10t.y + tx*P11t.y;

        PVector P21t = new PVector();
        P21t.x = (1-tx)*P11t.x + tx*P12t.x;
        P21t.y = (1-tx)*P11t.y + tx*P12t.y;

        //P3~t:P2~tの隣り合う点同士結んだ線分を(1-t):tに内分する点
        //3次だからこの点がベジエ曲線上の点になる
        PVector P30t = new PVector();
        P30t.x = (1-tx)*P20t.x + tx*P21t.x;
        P30t.y = (1-tx)*P20t.y + tx*P21t.y;

        // former bezier curve b1
        b1.P0.x = P00t.x;
        b1.P0.y = P00t.y;
        b1.P1.x = P10t.x;
        b1.P1.y = P10t.y;
        b1.P2.x = P20t.x;
        b1.P2.y = P20t.y;
        b1.P3.x = P30t.x;
        b1.P3.y = P30t.y;

        // latter bezier curve b2
        b2.P0.x = P30t.x;
        b2.P0.y = P30t.y;
        b2.P1.x = P21t.x;
        b2.P1.y = P21t.y;
        b2.P2.x = P12t.x;
        b2.P2.y = P12t.y;
        b2.P3.x = P03t.x;
        b2.P3.y = P03t.y;
    }

    void repeat(BezierCurve3 b3) {
        b3.P0.x = P0.x;
        b3.P0.y = P0.y;
        b3.P1.x = P1.x;
        b3.P1.y = P1.y;
        b3.P2.x = P2.x;
        b3.P2.y = P2.y;
        b3.P3.x = P3.x;
        b3.P3.y = P3.y;
    }
}

int n = 10;

BezierCurve2 B0;
ArrayList<BezierCurve3> b;
//BezierCurve3 b1, b2, b3;

//PVector bp;
float t;

int state = 0; //0:初期 1:次数上げ 2:分割 3:選択 4:
int count = 0; //繰り返し何回目か

void setup() {
    size(400, 400);

    B0 = new BezierCurve2();

    b = new ArrayList<BezierCurve3>();

    //bp = new PVector();
}

void draw() {
    background(40);

    fill(255, 255, 255);
    text("BezierCurve", 10, 20);
    text("u : Degree Elevation, s : Sprit, c : Choose, r : Repeat, q : Reset", 10, 33);

    //map(変換される値, 現在の範囲の最小値, 最大値, 変換する範囲の最小値, 最大値);
    t = map(mouseX, 20, width, 0, 1);

    /*
    switch(state) {
     case 0: //次数上げ前
     B0.draw(color(255, 255, 255));
     break;
     
     case 1: //次数上げ
     b.get((count*3)).draw(color(255, 255, 255));
     b.get((count*3)).drawPointOnCurve(t);
     break;
     
     case 2: //分割
     b.get((count*3)+1).draw(color(255, 255, 0));
     b.get((count*3)+2).draw(color(255, 0, 255));
     b.get((count*3)).drawPointOnCurve(t);
     break;
     
     case 3: //選択、繰り返す
     if (mouseX < b.get((count*3)+2).P0.x) {
     b.get((count*3)+1).draw(color(255, 255, 0));
     } else {
     b.get((count*3)+2).draw(color(255, 0, 255));
     }
     b.get((count*3)).drawPointOnCurve(t);
     //println(count+" state3");
     break;
     }*/

    //次数上げ前
    B0.draw(color(255, 255, 255));

    //次数上げ
    if (state == 1) {
        b.get((count*3)).draw(color(255, 255, 255));
        b.get((count*3)).drawPointOnCurve(t);
        //println(count+" "+state);
    }
    //分割
    if (state == 2) {
        b.get((count*3)+1).draw(color(255, 255, 0));
        b.get((count*3)+2).draw(color(255, 0, 255));
        b.get((count*3)).drawPointOnCurve(t);
        //println(count+" state2");
    }
    //選択
    if (state == 3) {
        if (mouseX < b.get((count*3)+2).P0.x) {
            b.get((count*3)+1).draw(color(255, 255, 0));
        } else {
            b.get((count*3)+2).draw(color(255, 0, 255));
        }
        b.get((count*3)).drawPointOnCurve(t);
        //println(count+" state3");
    }
    //繰り返し
    if (state == 4) {
        b.get((count*3)).draw(color(255, 255, 255));
        b.get((count*3)).drawPointOnCurve(t);
        //println(count+" state4");
    }
}

void keyPressed() {
    if (key == 'u' && state == 0) {
        b.add(new BezierCurve3());
        B0.degreeElevation(b.get(0));

        state = 1;
        println(count+" "+state);
    }
    if (key == 's' && state == 1) {
        b.add(new BezierCurve3());
        b.add(new BezierCurve3());

        b.get((count*3)).split(t, b.get((count*3)+1), b.get((count*3)+2));

        state = 2;
        println(count+" "+state);
    }
    if (key == 'c' && state == 2) {
        b.add(new BezierCurve3());
        if (mouseX < b.get((count*3)+2).P0.x) {
            b.get((count*3)+1).repeat(b.get(3));
        } else {
            b.get((count*3)+2).repeat(b.get(3));
        }

        state = 3;
        println(count+" "+state);
    }
    if (key == 'q') {
        state = 0;
        println(count+" "+state);
    }
}

void keyReleased() {
    if (key == 'r' && state == 3) {
        b.add(new BezierCurve3());
        count += 1;
        state = 1;
        println(count+" "+state);
    }
}
