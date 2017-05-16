#include "IsInVisualHull.h"


//IsInVisualHull( std::vector<MatlabCameraView> & viewVecRef );	

IsInVisualHull::IsInVisualHull(const std::vector<MatlabCameraView> & viewVecRef ):
viewVec(viewVecRef)
{
}



//double IsInVisualHull::eval (double x, double y, double z)
float IsInVisualHull::eval (float x, float y, float z)
{

	int camLoop = 0;
	bool insideHull = true; 
	
	while (  ( camLoop < viewVec.size() ) && insideHull  )
	{
		

		
		if (  viewVec[camLoop].ImageIntensityOfProjection( double(x), double(y), double(z) ) == 0.0  )
			insideHull = false;
			
		camLoop++;
	}


	return insideHull?+1.0:-1.0;
}





