int WINDOW_WIDTH = 400;
int WINDOW_HEIGHT = 400;

// float R = 100; //球の半径
// float Zo = 50; //
// float K[] = {0.0, 0.0, 1.0}; //球の色(r,g,b)
float Bg[] = {0.0, 0.0, 0.0}; //背景の色(r,g,b)

float L[] = {-1, 1, -1}; //光源ベクトル(x,y,z)
float dif[] = {0.8, 0.8, 0.8}; //拡散反射
float amb[] = {0.4, 0.4, 0.4}; //環境光

float V[]={0, 0, -300};
float E[]={0, 0, 0};

int OBJ_NUM = 3;
int ID = 0;
float T = Float.MAX_VALUE;

class Primitive {

    public float Kr, Kg, Kb;
    public float Xo, Yo, Zo;

    Primitive() {
    }
}

class Sphere extends Primitive {

    public float R;

    Sphere() {
    }

    Sphere( float r, float xo, float yo, float zo, float kr, float kg, float kb ) {
        R = r;
        Xo = xo;
        Yo = yo;
        Zo = zo;
        Kr = kr;
        Kg = kg;
        Kb = kb;
    }
}

//class Triangle extends Primitive {
//    Triangle() {
//    }
//    Triangle( float yo, float kr, float kg, float kb ) {
//        Yo=yo;
//        Kr=kr;
//        Kg=kg;
//        Kb=kb;
//    }
//}

boolean RayCast() {
    float a, b, c, D;
    float to;
    int i;

    T = Float.MAX_VALUE;
    ID = -1;

    for (i=0; i<OBJ_NUM; i++) {
        if ( primitives[i] instanceof Sphere ) {
            Sphere s = new Sphere();
            s = (Sphere)primitives[i];
            a = E[0]*E[0] + E[1]*E[1] + E[2]*E[2];
            b = 2 * E[0] * (V[0]-s.Xo) + 2 * E[1] * (V[1]-s.Yo) + 2 * E[2] * (V[2]-s.Zo);
            c = (V[0]-s.Xo) * (V[0]-s.Xo)
                + (V[1]-s.Yo) * (V[1]-s.Yo)
                + (V[2]-s.Zo) * (V[2]-s.Zo)
                - s.R * s.R;
            D = b*b - 4*a*c;
            if (D >= 0) {
                to = (-b - sqrt(D)) / 2;
                if (to < T) {
                    T = to;
                    ID = i;
                }
            }
        }
    }
    return (ID < 0) ? false : true;
}

color Shading (float[] N, float[] P) {
    //光源ベクトルと法線ベクトルの内積
    float LN = innerProduct(L, N);
    if (LN < 0) LN = 0;
    //0以下だったら環境光
    //return (LN < 0) ? color(255 * primitives[ID].Kr * amb[0],
    //    255 * primitives[ID].Kg * amb[1],
    //    255 * primitives[ID].Kb * amb[2])
    //    //そうじゃなかったら、内積の値でグラデーション
    //    : color(255 * primitives[ID].Kr * (dif[0] * LN + amb[0]),
    //    255 * primitives[ID].Kg * (dif[1] * LN + amb[1]),
    //    255 * primitives[ID].Kb * (dif[2] * LN + amb[2]));
    return color(255 * primitives[ID].Kr * (dif[0]*LN + amb[0]),
        255 * primitives[ID].Kg * (dif[1]*LN + amb[1]),
        255 * primitives[ID].Kb * (dif[2]*LN + amb[2]));
}

color RayTrace() {
    //RayCastからtを受け取る
    boolean t = RayCast();

    //Rayと球が交わる時
    //if (RayCast()) {

    //    Sphere s = new Sphere();
    //    s=(Sphere)primitives[ID];
    //    //法線ベクトル
    //    float[] N = {s.Xo, s.Yo, t - s.Zo};
    //    normalize(N);

    //    return Shading(N);
    //}
    ////Rayと球が交わらない時
    //else {
    //    //背景の色を返す
    //    return color(255 * Bg[0], 255 * Bg[1], 255 * Bg[2]);
    //}
    if ( RayCast() ) {
        float[] P={E[0]*T+V[0], E[1]*T+V[1], E[2]*T+V[2]};
        float[] N={0, 0, 0};
        if (primitives[ID] instanceof Sphere) {
            Sphere s = new Sphere();
            s = (Sphere)primitives[ID];
            N[0] = P[0] - s.Xo;
            N[1] = P[1] - s.Yo;
            N[2] = P[2] - s.Zo;
            normalize(N);
        }
        return Shading(N, P);
    } else {
        return color(255*Bg[0], 255*Bg[1], 255*Bg[2]);
    }
}

Primitive[] primitives;

void setup() {
    background(40);
    size(400, 400);

    primitives = new Primitive[OBJ_NUM];

    primitives[0] = new Sphere(100, -40, 40, 100, 1, 0, 0);
    primitives[1] = new Sphere(100, 40, -40, 0, 1, 1, 0);
    primitives[2] = new Sphere(100, -140, 140, 200, 0, 0, 1);

    normalize(L);

    //スクリーン状の全てのピクセルがRayTrace関数から返ってきた色で描画される
    //for (int iy = -WINDOW_HEIGHT/2; iy < WINDOW_HEIGHT/2; iy++) {
    //    for (int ix = -WINDOW_WIDTH/2; ix < WINDOW_WIDTH/2; ix++) {
    //        set(ix + WINDOW_WIDTH/2, WINDOW_HEIGHT/2 - iy, RayTrace());
    //    }
    //}
    
    for (int iy = -WINDOW_HEIGHT / 2; iy < WINDOW_HEIGHT / 2; iy++) {
        for (int ix = -WINDOW_WIDTH / 2; ix < WINDOW_WIDTH / 2; ix++) {
            E[0] = ix - V[0];
            E[1] = iy - V[1];
            E[2] = - V[2]; // perspective
            normalize(E);
            set(ix + WINDOW_WIDTH / 2, WINDOW_HEIGHT / 2 - iy, RayTrace());
        }
    }
    text("ambient light", 10, 20);
}
