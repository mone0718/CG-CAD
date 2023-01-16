class Tetrahedron {
    /////////////////////////////////////////////////////////////////////////////////////
    //  Property
    /////////////////////////////////////////////////////////////////////////////////////	
	float[] P0;
	float[] P1;
	float[] P2;
	float[] P3;

	Triangle T0;
	Triangle T1;
	Triangle T2;
	Triangle T3;

    /////////////////////////////////////////////////////////////////////////////////////
    //  Constructor
    /////////////////////////////////////////////////////////////////////////////////////	
	Tetrahedron() {
		P0=new float[3]; P0[0]=-1; P0[1]=-1; P0[2]=-1;
		P1=new float[3]; P1[0]=-1; P1[1]= 1; P1[2]= 1;
		P2=new float[3]; P2[0]= 1; P2[1]=-1; P2[2]= 1;
		P3=new float[3]; P3[0]= 1; P3[1]= 1; P3[2]=-1;

		T0=new Triangle(P0,P3,P2);
		T1=new Triangle(P0,P2,P1);
		T2=new Triangle(P0,P1,P3);
		T3=new Triangle(P1,P2,P3);
	}

    /////////////////////////////////////////////////////////////////////////////////////
    //  Method
    /////////////////////////////////////////////////////////////////////////////////////	
	void draw() {
		T0.draw(0,200,200);
		T1.draw(200,0,200);
		T2.draw(200,200,0);
		T3.draw(0,0,200);
	}

}