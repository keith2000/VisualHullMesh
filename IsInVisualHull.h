//IsInVisualHull
#ifndef ISINVISUALHULL_H
#define ISINVISUALHULL_H

#include <vector>
#include "polygonizer.h"
#include "MatlabCameraView.h"


class IsInVisualHull: public ImplicitFunction 
{
public:
	
	IsInVisualHull( const std::vector<MatlabCameraView> & viewVecRef );		
	float eval (float x, float y, float z);

private:
	const std::vector<MatlabCameraView> & viewVec;
};

#endif
