%VisualHullMeshDemo4b
close all
clear all
drawnow

if 3 ~= exist( 'VisualHullTriMeshMex', 'file' ) 
   disp('The mex file VisualHullTriMeshMex needs to be created for your system') 
   disp('Press any key to try to do this')
   pause
   CompileVisualHullTriMeshMex;
end
    
    
cameraVec(1).efl = 15499.1;%effective focal length in pixels
cameraVec(1).u0 = 331.558;% horizontal component of principal point (in pixels)
cameraVec(1).v0 = 231.812;% vertical component of principal point (in pixels)
cameraVec(1).pose = [[-0.792527;-0.00173618;-0.609835;0],[-0.00297251;0.999995;0.00101604;0],[0.60983;0.00261797;-0.792528;0],[-1.13687e-013;-4.44089e-016;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(2).efl = 15545.1;%effective focal length in pixels
cameraVec(2).u0 = 331.302;% horizontal component of principal point (in pixels)
cameraVec(2).v0 = 231.579;% vertical component of principal point (in pixels)
cameraVec(2).pose = [[0.828626;-0.527436;-0.187592;0],[-0.527436;-0.62328;-0.57735;0],[0.187592;0.57735;-0.794654;0],[1.38778e-014;5.55112e-014;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(3).efl = 15487.2;%effective focal length in pixels
cameraVec(3).u0 = 331.8;% horizontal component of principal point (in pixels)
cameraVec(3).v0 = 231.844;% vertical component of principal point (in pixels)
cameraVec(3).pose = [[-0.174616;0.853409;0.491123;0],[0.853409;0.379962;-0.356822;0],[-0.491123;0.356822;-0.794655;0],[5.55112e-014;-0;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(4).efl = 15484.2;%effective focal length in pixels
cameraVec(4).u0 = 331.264;% horizontal component of principal point (in pixels)
cameraVec(4).v0 = 231.678;% vertical component of principal point (in pixels)
cameraVec(4).pose = [[-0.174616;-0.853409;0.491123;0],[-0.853409;0.379962;0.356822;0],[-0.491123;-0.356822;-0.794655;0],[5.55112e-014;-0;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(5).efl = 15534.3;%effective focal length in pixels
cameraVec(5).u0 = 331.937;% horizontal component of principal point (in pixels)
cameraVec(5).v0 = 231.091;% vertical component of principal point (in pixels)
cameraVec(5).pose = [[0.828626;0.527436;-0.187592;0],[0.527436;-0.62328;0.57735;0],[0.187592;-0.57735;-0.794654;0],[1.38778e-014;-5.55112e-014;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(6).efl = 15500.1;%effective focal length in pixels
cameraVec(6).u0 = 331.612;% horizontal component of principal point (in pixels)
cameraVec(6).v0 = 231.763;% vertical component of principal point (in pixels)
cameraVec(6).pose = [[-0.187592;0;-0.982247;0],[0;1;0;0],[0.982247;0;-0.187592;0],[-1.38778e-014;-0;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(7).efl = 15535.7;%effective focal length in pixels
cameraVec(7).u0 = 331.3;% horizontal component of principal point (in pixels)
cameraVec(7).v0 = 231.702;% vertical component of principal point (in pixels)
cameraVec(7).pose = [[0.886595;-0.349025;-0.303531;0],[-0.349025;-0.0741872;-0.934172;0],[0.303531;0.934172;-0.187592;0],[2.77556e-014;-0;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(8).efl = 15494.8;%effective focal length in pixels
cameraVec(8).u0 = 331.763;% horizontal component of principal point (in pixels)
cameraVec(8).v0 = 232.034;% vertical component of principal point (in pixels)
cameraVec(8).pose = [[0.222711;0.564734;0.794654;0],[0.564734;0.589697;-0.57735;0],[-0.794654;0.57735;-0.187592;0],[5.55112e-014;5.55112e-014;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(9).efl = 15497;%effective focal length in pixels
cameraVec(9).u0 = 331.306;% horizontal component of principal point (in pixels)
cameraVec(9).v0 = 231.894;% vertical component of principal point (in pixels)
cameraVec(9).pose = [[0.222711;-0.564734;0.794654;0],[-0.564734;0.589697;0.57735;0],[-0.794654;-0.57735;-0.187592;0],[5.55112e-014;-5.55112e-014;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(10).efl = 15518;%effective focal length in pixels
cameraVec(10).u0 = 331.656;% horizontal component of principal point (in pixels)
cameraVec(10).v0 = 231.533;% vertical component of principal point (in pixels)
cameraVec(10).pose = [[0.886595;0.349025;-0.303531;0],[0.349025;-0.0741872;0.934172;0],[0.303531;-0.934172;-0.187592;0],[2.77556e-014;-0;500;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame

imgCell = cell(size(cameraVec));
for viewLoop = 1:length(cameraVec),
    imgFilename = sprintf('%s/Elephant%02d.png', fileparts(mfilename('fullpath')), viewLoop);
    fprintf('loading %s...\n', imgFilename )
    im = imread( imgFilename );
    imgCell{viewLoop} = double(im);
    cameraVec(viewLoop).height = size(im, 1); %#ok<SAGROW>
    cameraVec(viewLoop).width = size(im, 2); %#ok<SAGROW>
end


figure, cameratoolbar, axis off, axis vis3d, axis equal, set(gcf, 'renderer', 'zbuffer')
cameratoolbar('ResetCameraAndSceneLight'), cameratoolbar togglescenelight
DisplayCamerasTwo( cameraVec )

%now we compute the visual hull:
[pMesh, kMesh] = VisualHullTriMesh( cameraVec, imgCell, 0, 0.2);

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
