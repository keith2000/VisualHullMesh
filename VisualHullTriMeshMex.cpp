//VisualHullTriMeshMex.cpp
//author: Keith Forbes
//keith@cogency.co.za
//September 2009

#include <string>
extern "C" {
#include "mex.h"
}
#include "polygonizer.h"
#include "IsInVisualHull.h"

#define COMPLEXPRINT(str) mexPrintf("%% %s: %+g %+gi\n", #str, real(str), imag(str) );
#define DOUBLEPRINT(str) mexPrintf("%% %s: %g\n", #str, str );
#define BOOLPRINT(str) mexPrintf("%% %s: %s\n", #str, str?"true":"false" );
#define INTEGERPRINT(str) mexPrintf("%% %s: %d\n", #str, str );
#define P2DPRINT(str) mexPrintf(" %s= [%g; %g]\n", #str, str.X(), str.Y() );
#define P3DPRINT(str) mexPrintf("%% %s: [%g; %g; %g]\n", #str, str.X(), str.Y() , str.Z() );
#define M4PRINT(str) mexPrintf("%% %s= [[%g,%g,%g,%g];[%g,%g,%g,%g];[%g,%g,%g,%g];[%g,%g,%g,%g]]\n", #str, str(0,0), str(0,1), str(0,2), str(0,3), str(1,0), str(1,1), str(1,2), str(1,3), str(2,0), str(2,1), str(2,2), str(2,3), str(3,0), str(3,1), str(3,2), str(3,3) );
#define M3PRINT(str) mexPrintf("%% %s= [[%g,%g,%g];[%g,%g,%g];[%g,%g,%g]]\n", #str, str(0,0), str(0,1), str(0,2), str(1,0), str(1,1), str(1,2), str(2,0), str(2,1), str(2,2) );
#define MSASSERT(str) if (!(str)) throw(string("failed assertion:") + string(#str));

using namespace std;



void mexFunction( int nlhs, mxArray *plhs[], int nrhs, const mxArray  *prhs[] )
{


	try
	{	
		
		const int lOS = __LINE__+1; //NB: Don't leave spaces between lines. This generates input order.
		const int prhsCameraVec =		__LINE__-lOS;//
		const int prhsImgCell =		__LINE__-lOS;//
		const int prhsFovBound =	__LINE__-lOS;		
		const int prhsParams =	__LINE__-lOS;
		const int numMatlabInputs =	__LINE__-lOS;

		MSASSERT(numMatlabInputs==nrhs);		
		MSASSERT(3==mxGetM(prhs[prhsFovBound]));
		MSASSERT(2==mxGetN(prhs[prhsFovBound]));
		MSASSERT(mxGetNumberOfElements(prhs[prhsCameraVec])==mxGetNumberOfElements(prhs[prhsImgCell]));
		MSASSERT(mxGetNumberOfElements(prhs[prhsCameraVec])>=2);
		MSASSERT( mxGetPr(prhs[prhsFovBound])[0+0] < mxGetPr(prhs[prhsFovBound])[0+3] );
		MSASSERT( mxGetPr(prhs[prhsFovBound])[1+0] < mxGetPr(prhs[prhsFovBound])[1+3] );
		MSASSERT( mxGetPr(prhs[prhsFovBound])[2+0] < mxGetPr(prhs[prhsFovBound])[2+3] );
		 
		const int lOS2 = __LINE__+1; //NB: Don't leave spaces between lines. This generates input order.					
		const double cellWid = mxGetPr(prhs[prhsParams])[__LINE__-lOS2];
		const int howFar = int( mxGetPr(prhs[prhsParams])[__LINE__-lOS2] );				
		const int numStartPoints = int( mxGetPr(prhs[prhsParams])[__LINE__-lOS2] );				
		const bool doTet =  mxGetPr(prhs[prhsParams])[__LINE__-lOS2] > 0;		
		const int numParams =		__LINE__-lOS2;		
		MSASSERT( numParams==mxGetNumberOfElements( prhs[prhsParams] )  );	

		vector<MatlabCameraView> viewVec( mxGetNumberOfElements(prhs[prhsCameraVec]) );

		for( int viewLoop = 0; viewLoop < viewVec.size(); ++viewLoop )
		{

			const double efl = mxGetPr((mxGetField( prhs[prhsCameraVec], viewLoop, "efl" ) ) )[0];
			const double u0 = mxGetPr((mxGetField( prhs[prhsCameraVec], viewLoop, "u0" ) ) )[0];
			const double v0 = mxGetPr((mxGetField( prhs[prhsCameraVec], viewLoop, "v0" ) ) )[0]; 
			const double * poseData = mxGetPr((mxGetField( prhs[prhsCameraVec], viewLoop, "pose" ) ) );
			mxArray * matlabImg =  mxGetCell(prhs[prhsImgCell],viewLoop);

			const unsigned int width = mxGetN(matlabImg);
			const unsigned int height = mxGetM(matlabImg);

			viewVec[viewLoop] = MatlabCameraView( 
				width, height, u0, v0, efl, poseData, mxGetPr(matlabImg) );

		}


		IsInVisualHull vhull( viewVec );

		bool foundPoint = false;
		int counter = 0;

		vector<double> startPoint(3);

		while (!foundPoint)
		{
			if ( counter > numStartPoints )
				throw( string("Could not find starting point inside visual hull") );
		
			for( int dim = 0; dim < 3;++dim)
			{
				const double randVal = double( rand()+1.0 ) / double(RAND_MAX+2.0);
				const double lb = mxGetPr(prhs[prhsFovBound])[dim+0];
				const double ub = mxGetPr(prhs[prhsFovBound])[dim+3];
				startPoint[dim] = lb + (ub-lb) * randVal;
			}
			counter++;


			//mexPrintf("%d: [%g %g %g]\n", counter, startPoint[0], startPoint[1], startPoint[2] );

			foundPoint =   vhull.eval ( startPoint[0], startPoint[1], startPoint[2] ) > 0;

		}

		
		Polygonizer pol( &vhull, cellWid, howFar );

		pol.march(doTet, startPoint[0], startPoint[1], startPoint[2] );

		plhs[0]= mxCreateDoubleMatrix( 3, pol.no_vertices(), mxREAL);	

		for( int vertLoop = 0; vertLoop < pol.no_vertices(); vertLoop++ )
		{
			(mxGetPr(plhs[0]))[vertLoop*3 + 0] = (pol.get_vertex( vertLoop )).x;
			(mxGetPr(plhs[0]))[vertLoop*3 + 1] = (pol.get_vertex( vertLoop )).y;
			(mxGetPr(plhs[0]))[vertLoop*3 + 2] = (pol.get_vertex( vertLoop )).z;
		}


		plhs[1]= mxCreateDoubleMatrix( 3, pol.no_triangles(), mxREAL);	

		for( int triLoop = 0; triLoop < pol.no_triangles(); triLoop++ )
		{
			(mxGetPr(plhs[1]))[triLoop*3 + 0] = (pol.get_triangle( triLoop )).v0 + 1;// +1 since matlab counts array indices from 1 not 0 like C++ does
			(mxGetPr(plhs[1]))[triLoop*3 + 1] = (pol.get_triangle( triLoop )).v1 + 1;
			(mxGetPr(plhs[1]))[triLoop*3 + 2] = (pol.get_triangle( triLoop )).v2 + 1;
		}


	}
	catch ( const string & errMssg )
	{
		mexPrintf("%s\n", errMssg.c_str()  );
	}
	catch ( ... )
	{
		mexPrintf("Caught an unspecified error\n" );
	}
}




