int WINDOW_WIDTH=400;
int WINDOW_HEIGHT=400;

float Bg[]={0.0, 0.0, 0.0};

float L[]={-1, 1, -1};
float dif[]={1.0, 1.0, 1.0};
float amb[]={0.2, 0.2, 0.2};

float V[]={0, 0, -300};
float E[]={0, 0, 0};

int OBJ_NUM=4;
int ID=0;
float T=Float.MAX_VALUE;

class Primitive {
    public float Kr, Kg, Kb;
    public float Sr, Sg, Sb;
    public int m;
    public float Xo, Yo, Zo;
    Primitive() {
    }
}

class Sphere extends Primitive {
    public float R;
    Sphere() {
    }
    Sphere( float r, float xo, float yo, float zo, float kr, float kg, float kb, float sr, float sg, float sb ) {
        R=r;
        Xo=xo;
        Yo=yo;
        Zo=zo;
        Kr=kr;
        Kg=kg;
        Kb=kb;
        Sr=sr;
        Sg=sg;
        Sb=sb;
        m=10;
    }
}

class Plane extends Primitive {
    Plane() {
    }
    Plane( float yo, float kr, float kg, float kb, float sr, float sg, float sb ) {
        Yo=yo;
        Kr=kr;
        Kg=kg;
        Kb=kb;
        Sr=sr;
        Sg=sg;
        Sb=sb;
        m=4;
    }
}

float Highlight( float[] N ) {
    float rx=0, ry=0, rz=0;
    float rv=0;
    float rvn=0;

    float LN2=2 * (innerProduct(L, N));
    
    rx=N[0]*LN2 - L[0];
    ry=N[1]*LN2 - L[1];
    rz=N[1]*LN2 - L[1];
    rv=rx*-E[0] + ry*-E[1] + rz*-E[2];
    
    if ( rv >= 0 ) {
        float m=primitives[ID].m;
        rvn=1;
        for ( int i=0; i<m; i++ ) rvn *= rv;
    } else {
        rvn=0;
    }
    return rvn;
}

float Shadowing( float[] P ) {
    boolean block=false;
    float t0;

    for ( int i=0; i<OBJ_NUM; i++ ) {
        float a, b, c, D;
        if (primitives[i] instanceof Sphere) {
            Sphere s= new Sphere();
            s=(Sphere)primitives[i];
            a=L[0]*L[0]+L[1]*L[1]+L[2]*L[2];
            b=2*( L[0]*(P[0]-s.Xo)+L[1]*(P[1]-s.Yo)+L[2]*(P[2]-s.Zo) );
            c=(P[0]-s.Xo)*(P[0]-s.Xo) + (P[1]-s.Yo)*(P[1]-s.Yo) + (P[2]-s.Zo)*(P[2]-s.Zo) - s.R*s.R;
            D=b*b-4*a*c;
            if ( D >= 0 ) {
                t0=(-b-sqrt( D ))/2;
                if ( t0>0 ) {
                    block=true;
                    break;
                }
            }
        }
    }

    return (block)?0.1:1;
}

color Shading( float[] N, float[] P ) {
    float LN=innerProduct(L, N);
    if (LN<0) LN=0;
    float shadow=Shadowing( P );

    float rvn=Highlight( N );
    return color(255*(primitives[ID].Kr*(dif[0]*shadow*LN+amb[0]) + primitives[ID].Sr*dif[0]*rvn),
        255*(primitives[ID].Kg*(dif[1]*shadow*LN+amb[1]) + primitives[ID].Sg*dif[1]*rvn),
        255*(primitives[ID].Kb*(dif[2]*shadow*LN+amb[2]) + primitives[ID].Sb*dif[2]*rvn));
}

color RayTrace() {
    float t=0;
    float x, y, z;
    float nx, ny, nz;

    if ( RayCast() ) {
        float[] P={E[0]*T+V[0], E[1]*T+V[1], E[2]*T+V[2]};
        float[] N={0, 0, 0};
        if ( primitives[ID] instanceof Sphere ) {
            Sphere s=new Sphere();
            s=(Sphere)primitives[ID];
            N[0]=P[0]-s.Xo;
            N[1]=P[1]-s.Yo;
            N[2]=P[2]-s.Zo;
            normalize(N);
        }
        if ( primitives[ID] instanceof Plane ) {
            N[0]=0;
            N[1]=1;
            N[2]=0;
        }
        return Shading(N, P);
    } else {
        return color(255*Bg[0], 255*Bg[1], 255*Bg[2]);
    }
}

boolean RayCast() {
    float a, b, c, D;
    float to;
    int i;

    T=Float.MAX_VALUE;
    ID=-1;

    for ( i=0; i<OBJ_NUM; i++ ) {
        if ( primitives[i] instanceof Sphere ) {
            Sphere s = new Sphere();
            s=(Sphere)primitives[i];
            a=E[0]*E[0]+E[1]*E[1]+E[2]*E[2];
            b=2*E[0]*(V[0]-s.Xo)+2*E[1]*(V[1]-s.Yo)+2*E[2]*(V[2]-s.Zo);
            c= (V[0]-s.Xo)*(V[0]-s.Xo)
                + (V[1]-s.Yo)*(V[1]-s.Yo)
                + (V[2]-s.Zo)*(V[2]-s.Zo)
                - s.R*s.R;
            D=b*b-4*a*c;
            if ( D>=0 ) {
                to=(-b-sqrt( D ))/2;
                if ( to < T ) {
                    T=to;
                    ID=i;
                }
            }
        }

        if ( primitives[i] instanceof Plane ) {
            if (E[1]!=0 ) {
                Plane p = new Plane();
                p=(Plane)primitives[i];
                to=p.Yo/E[1];
                if ((to>=0)&&(to<T)) {
                    T=to;
                    ID=i;
                }
            }
        }
    }

    return (ID<0)?false:true;
}

Primitive[] primitives;

void setup() {
    background(40);
    size(400, 400);

    primitives=new Primitive[OBJ_NUM];
    primitives[0]=new Sphere(100, 0, 0, 100, 0.3, 0, 0, 0.7, 0.3, 0.3);
    primitives[1]=new Sphere(100, 200, 0, 200, 0, 0.3, 0, 0.3, 0.7, 0.3);
    primitives[2]=new Sphere(100, -200, 0, 300, 0.3, 0.3, 0, 1, 1, 0.3);
    primitives[3]=new Plane(-100, 1, 1, 1, 1, 1, 1);

    normalize(L);

    for ( int iy=-WINDOW_HEIGHT/2; iy<WINDOW_HEIGHT/2; iy=iy+1 ) {
        for ( int ix=-WINDOW_WIDTH/2; ix<WINDOW_WIDTH/2; ix=ix+1 ) {
            E[0]=ix-V[0];
            E[1]=iy-V[1];
            E[2]=-V[2]; // perspective
            normalize(E);
            set( ix+WINDOW_WIDTH/2, WINDOW_HEIGHT/2-iy, RayTrace() );
        }
    }
    text("phong model", 10, 20);
}
