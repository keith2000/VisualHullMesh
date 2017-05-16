%VisualHullMeshDemo3b
close all
clear all
drawnow

if 3 ~= exist( 'VisualHullTriMeshMex', 'file' ) 
   disp('The mex file VisualHullTriMeshMex needs to be created for your system') 
   disp('Press any key to try to do this')
   pause
   CompileVisualHullTriMeshMex;
end
    
    

cameraVec(1).efl = 82462.2;%effective focal length in pixels
cameraVec(1).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(1).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(1).pose = [[0.794636;-0.0472717;0.605243;0],[-0.605056;-0.143134;0.783211;0],[0.0496069;-0.988574;-0.142341;0],[0.500581;-1.10641;1447.18;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(2).efl = 88122.9;%effective focal length in pixels
cameraVec(2).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(2).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(2).pose = [[-0.140611;-0.747534;0.64917;0],[-0.989746;0.12278;-0.0729953;0],[-0.0251387;-0.652777;-0.757133;0],[-0.283134;-0.69467;1440.92;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(3).efl = 78553.1;%effective focal length in pixels
cameraVec(3).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(3).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(3).pose = [[0.929729;0.313252;-0.193589;0],[0.366718;-0.739811;0.564089;0],[0.0334829;-0.595443;-0.8027;0],[0.960694;0.259134;1345.61;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(4).efl = 69746.8;%effective focal length in pixels
cameraVec(4).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(4).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(4).pose = [[-0.771105;0.546986;-0.325889;0],[0.633143;0.604646;-0.483252;0],[-0.0672846;-0.578973;-0.812566;0],[-1.46358;-0.300616;1219.7;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(5).efl = 65045.5;%effective focal length in pixels
cameraVec(5).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(5).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(5).pose = [[-0.920075;-0.00826624;0.391656;0],[-0.387108;0.172517;-0.905751;0],[-0.0600802;-0.984972;-0.161929;0],[-1.0808;-0.0971316;1147.91;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(6).efl = 83015.3;%effective focal length in pixels
cameraVec(6).u0 = 512.5;% horizontal component of principal point (in pixels)
cameraVec(6).v0 = 384.5;% vertical component of principal point (in pixels)
cameraVec(6).pose = [[0.124555;0.22617;-0.966092;0],[0.992212;-0.0272136;0.121552;0],[0.00120048;-0.973708;-0.227798;0],[-0.300013;-0.540565;1477.64;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame

imgCell = cell(size(cameraVec));
dirname = fileparts(which(mfilename));
for viewLoop = 1:length(cameraVec),
    imgFilename = sprintf('%s/Blob%d.png', dirname, viewLoop);
    disp(imgFilename)
    im = imread(imgFilename);
    imgCell{viewLoop} = double(im);
    cameraVec(viewLoop).height = size(im, 1); %#ok<SAGROW>
    cameraVec(viewLoop).width = size(im, 2); %#ok<SAGROW>
end


figure, cameratoolbar, axis off, axis vis3d, axis equal, set(gcf, 'renderer', 'zbuffer')
cameratoolbar('ResetCameraAndSceneLight'), cameratoolbar togglescenelight
DisplayCamerasTwo( cameraVec )

%now we compute the visual hull:
[pMesh, kMesh] = VisualHullTriMesh( cameraVec, imgCell );

fovBound = CommonFovBoundBox( cameraVec );
patch('Faces', convhulln(fovBound'), 'Vertices', fovBound', 'FaceColor', 'none', 'EdgeColor', 'k');
patch('Faces', kMesh', 'Vertices', pMesh', 'FaceColor', 'g', 'EdgeColor', 'none');
set(gcf, 'Name', 'Visual Hull, Common Field Of View, and Cameras')

figure, cameratoolbar, axis off, axis vis3d, axis equal, set(gcf, 'renderer', 'zbuffer')
cameratoolbar('ResetCameraAndSceneLight'), cameratoolbar togglescenelight
patch('Faces', kMesh', 'Vertices', pMesh', 'FaceColor', 'g', 'EdgeColor', 'none');
patch('Faces', convhulln(fovBound'), 'Vertices', fovBound', 'FaceColor', 'none', 'EdgeColor', 'k');
set(gcf, 'Name', 'Visual Hull and Common Field Of View')

figure, cameratoolbar, axis off, axis vis3d, axis equal, set(gcf, 'renderer', 'zbuffer')
cameratoolbar('ResetCameraAndSceneLight'), cameratoolbar togglescenelight
patch('Faces', kMesh', 'Vertices', pMesh', 'FaceColor', 'g', 'EdgeColor', 'none');
set(gcf, 'Name', 'Visual Hull')


%As a check, we project the visual hull into the images:
for viewLoop = 1:length(cameraVec),
    figure, hold on
    set(gcf, 'Name', 'Visual Hull Projected Onto Original Silhouette (Zoom to Boundary to See Coverage)')
    image( imgCell{viewLoop} )
    axis tight
    axis off
    pCamRef = cameraVec(viewLoop).pose * [pMesh; ones(1,size(pMesh,2))]; %compute vh points in camera's ref frame
    pImg = cameraVec(viewLoop).efl * pCamRef([1,2],:)./pCamRef([3,3],:); %compute projection onto image plane
    pImg(1,:) = pImg(1,:) + cameraVec(viewLoop).u0;
    pImg(2,:) = pImg(2,:) + cameraVec(viewLoop).v0;
    patch( 'Faces', kMesh', 'Vertices', pImg', 'FaceColor', 'g', 'EdgeColor', 'none' )
    %patch should approximately cover the silhouette
end

