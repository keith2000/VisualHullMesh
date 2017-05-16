#include "MatlabCameraView.h"

#include "mex.h"
#define COMPLEXPRINT(str) mexPrintf("%% %s: %+g %+gi\n", #str, real(str), imag(str) );
#define DOUBLEPRINT(str) mexPrintf("%% %s: %g\n", #str, str );
#define BOOLPRINT(str) mexPrintf("%% %s: %s\n", #str, str?"true":"false" );
#define INTEGERPRINT(str) mexPrintf("%% %s: %d\n", #str, str );
#define P2DPRINT(str) mexPrintf(" %s= [%g; %g]\n", #str, str.X(), str.Y() );
#define P3DPRINT(str) mexPrintf("%% %s: [%g; %g; %g]\n", #str, str.X(), str.Y() , str.Z() );
#define M4PRINT(str) mexPrintf("%% %s= [[%g,%g,%g,%g];[%g,%g,%g,%g];[%g,%g,%g,%g];[%g,%g,%g,%g]]\n", #str, str(0,0), str(0,1), str(0,2), str(0,3), str(1,0), str(1,1), str(1,2), str(1,3), str(2,0), str(2,1), str(2,2), str(2,3), str(3,0), str(3,1), str(3,2), str(3,3) );
#define M3PRINT(str) mexPrintf("%% %s= [[%g,%g,%g];[%g,%g,%g];[%g,%g,%g]]\n", #str, str(0,0), str(0,1), str(0,2), str(1,0), str(1,1), str(1,2), str(2,0), str(2,1), str(2,2) );
#define MSASSERT(str) if (!(str)) throw(string("failed assertion:") + string(#str));



MatlabCameraView::MatlabCameraView( )
{
}

MatlabCameraView::MatlabCameraView( const unsigned int widthVal,
								   const unsigned int heightVal,
								   const double u0Val, const double v0Val, const double eflVal,
								   const double * poseData, 
								   const double * dataVal):
width(widthVal),
height(heightVal),
u0(u0Val),
v0(v0Val),
efl(eflVal),
data(dataVal)
{

	for (int rr = 0; rr < 4; ++rr)
		for (int cc = 0; cc < 4; ++cc)		
			pose[rr][cc] = poseData[rr+cc*4];

}


double MatlabCameraView::ImageIntensity( const double u,  const double v) const
{

	const int cc = int(u+0.5);
	const int rr = int(v+0.5);

	if ( cc < 0 || rr < 0 || rr >= height || cc >= width )
		return 0;
	return data[rr + cc * height];

}


double MatlabCameraView::ImageIntensityOfProjection( const double xW,  const double yW, const double zW ) const
{

	//DOUBLEPRINT(xW);
	//DOUBLEPRINT(yW);
	//DOUBLEPRINT(zW);

	const double xC = pose[0][0] * xW + pose[0][1] * yW  + pose[0][2] * zW +  + pose[0][3];
	const double yC = pose[1][0] * xW + pose[1][1] * yW  + pose[1][2] * zW +  + pose[1][3];
	const double zC = pose[2][0] * xW + pose[2][1] * yW  + pose[2][2] * zW +  + pose[2][3];

	//DOUBLEPRINT(xC);
	//DOUBLEPRINT(yC);
	//DOUBLEPRINT(zC);


	//DOUBLEPRINT(pose[0][0]);
	//DOUBLEPRINT(pose[0][1]);
	//DOUBLEPRINT(pose[0][2]);
	//DOUBLEPRINT(pose[0][3]);

	//DOUBLEPRINT(efl);
	//DOUBLEPRINT(u0);
	//DOUBLEPRINT(v0);


	const double u = efl * xC/zC + u0;
	const double v = efl * yC/zC + v0;

	return ImageIntensity(u, v);

}
