This Matlab code is for creating visual hull meshes from images. You will need to know the camera pose, principal point and effective focal length (in pixel units) associated with each image.

The code uses Bloomenthal's polygonizer:
http://www.unchainedgeometry.com/jbloom/papers.html 


To get going run the Matlab demo VisualHullMeshDemo3b.m.

If you use this code and would like to cite a publication, then use my thesis which provides a brief overview of the methodology (page 139: 3rd paragraph of 7.4.3):
Keith Forbes. "Calibration, Recognition, and Shape from Silhouettes of Stones". PhD thesis, University of Cape Town, June 2007. 


Keith Forbes
10 September 2009
keith2000@gmail.com


[2009-10-01]: Run VisualHullMeshDemo4b.m to see a demo with a more interesting shape: a toy elephant.

[2009-10-02]: VisualHullMeshDemo5b.m shows an example with a human shape and 12 cameras.

[2011-12-02]: Created DisplayCamerasTwo.m that now works with coplanar cameras. (Thanks to Boram Kim for pointing out the problem.)

[2014-12-08]: Added Win64 mex file and minor change to CompileVisualHullTriMeshMex.m

[2018-05-03]: works on R2018a