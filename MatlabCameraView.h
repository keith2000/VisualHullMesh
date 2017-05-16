//MatlabCameraView
#ifndef MATLABCAMERAVIEW_H
#define MATLABCAMERAVIEW_H

class MatlabCameraView
{
public:

	MatlabCameraView( );
	MatlabCameraView( const unsigned int widthVal,
	 const unsigned int heightVal,
	 const double u0Val, const double v0Val, const double eflVal, const double * poseData, const double * data);
	
	double ImageIntensity( const double u,  const double v) const;
	double ImageIntensityOfProjection( const double xW,  const double yW, const double zW ) const;
private:
	unsigned int width;
	unsigned int height;
	double u0; //horizontal component of the principal point
	double v0; //vertical component of the principal point
	double efl; //focal length in pixels
	const double * data; //image data
	double pose[4][4];
};

#endif
