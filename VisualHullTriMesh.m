function [pMesh, kMesh, fovBound] = VisualHullTriMesh( cameraVec, imgCell, doTet, cellWid, numStartPoints, howFar )

%author: Keith Forbes
%keith@cogency.co.za
%September 2009

if ~exist('doTet', 'var'),  doTet = 0; end %0 or 1 for two types of triangulation
if ~exist('cellWid', 'var'),  cellWid = NaN; end %NaN for auto compute based on size of common FOV
if ~exist('numStartPoints', 'var'),  numStartPoints = 1e6; end %number of random starting points to try in fov box to find a point in the visual hull
if ~exist('howFar', 'var'),  howFar = 1e6; end %some large number -- shouldn't be needed

fovBound = CommonFovBoundBox( cameraVec );

boundBox = [min(fovBound,[],2), max(fovBound,[],2)];

if isnan(cellWid)
    cellWid = min(diff( boundBox' )) / 50;
end

[pMesh, kMesh] = VisualHullTriMeshMex(...
    cameraVec, imgCell, boundBox, [cellWid, howFar, numStartPoints, doTet] );


