%VisualHullMeshDemo5b
close all
clear all
drawnow

if 3 ~= exist( 'VisualHullTriMeshMex', 'file' ) 
   disp('The mex file VisualHullTriMeshMex needs to be created for your system') 
   disp('Press any key to try to do this')
   pause
   CompileVisualHullTriMeshMex;
end
    
cameraVec(1).efl = 8980.53;%effective focal length in pixels
cameraVec(1).u0 = 331.694;% horizontal component of principal point (in pixels)
cameraVec(1).v0 = 231.562;% vertical component of principal point (in pixels)
cameraVec(1).pose = [[0.352547;-0.201696;-0.9138;0],[-0.201696;0.937167;-0.284669;0],[0.9138;0.284669;0.289714;0],[-1.11022e-014;2.77556e-015;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(2).efl = 9063.67;%effective focal length in pixels
cameraVec(2).u0 = 332.143;% horizontal component of principal point (in pixels)
cameraVec(2).v0 = 231.511;% vertical component of principal point (in pixels)
cameraVec(2).pose = [[0.455115;0.49759;-0.738427;0],[0.49759;0.5456;0.674333;0],[0.738427;-0.674333;0.000715;0],[-0;1.11022e-014;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(3).efl = 8951.53;%effective focal length in pixels
cameraVec(3).u0 = 331.322;% horizontal component of principal point (in pixels)
cameraVec(3).v0 = 232.324;% vertical component of principal point (in pixels)
cameraVec(3).pose = [[0.0626438;-0.623095;-0.779634;0],[-0.623095;0.585806;-0.518251;0],[0.779634;0.518251;-0.35155;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(4).efl = 8980.36;%effective focal length in pixels
cameraVec(4).u0 = 332.142;% horizontal component of principal point (in pixels)
cameraVec(4).v0 = 231.712;% vertical component of principal point (in pixels)
cameraVec(4).pose = [[-0.45999;0.271097;-0.845527;0],[0.271097;0.949662;0.157001;0],[0.845527;-0.157001;-0.510328;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(5).efl = 9051.09;%effective focal length in pixels
cameraVec(5).u0 = 331.935;% horizontal component of principal point (in pixels)
cameraVec(5).v0 = 231.57;% vertical component of principal point (in pixels)
cameraVec(5).pose = [[0.482037;0.796741;-0.364478;0],[0.796741;-0.225563;0.560647;0],[0.364478;-0.560647;-0.743526;0],[-1.11022e-014;1.11022e-014;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(6).efl = 8958.04;%effective focal length in pixels
cameraVec(6).u0 = 331.255;% horizontal component of principal point (in pixels)
cameraVec(6).v0 = 232.19;% vertical component of principal point (in pixels)
cameraVec(6).pose = [[0.779412;-0.526269;-0.339938;0],[-0.526269;-0.255548;-0.811009;0],[0.339938;0.811009;-0.476136;0],[1.11022e-014;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(7).efl = 8946.08;%effective focal length in pixels
cameraVec(7).u0 = 331.183;% horizontal component of principal point (in pixels)
cameraVec(7).v0 = 232.191;% vertical component of principal point (in pixels)
cameraVec(7).pose = [[0.863728;-0.0817456;-0.497285;0],[-0.0817456;0.950963;-0.298306;0],[0.497285;0.298306;0.814691;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(8).efl = 9032.22;%effective focal length in pixels
cameraVec(8).u0 = 331.599;% horizontal component of principal point (in pixels)
cameraVec(8).v0 = 231.513;% vertical component of principal point (in pixels)
cameraVec(8).pose = [[0.987141;0.0450234;-0.153381;0],[0.0450234;0.84236;0.537031;0],[0.153381;-0.537031;0.829501;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(9).efl = 8984.95;%effective focal length in pixels
cameraVec(9).u0 = 332.161;% horizontal component of principal point (in pixels)
cameraVec(9).v0 = 232.208;% vertical component of principal point (in pixels)
cameraVec(9).pose = [[-0.974551;0.0402389;-0.220524;0],[0.0402389;0.99918;0.004494;0],[0.220524;-0.004494;-0.975371;0],[2.77556e-015;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(10).efl = 8940.43;%effective focal length in pixels
cameraVec(10).u0 = 331.243;% horizontal component of principal point (in pixels)
cameraVec(10).v0 = 231.426;% vertical component of principal point (in pixels)
cameraVec(10).pose = [[0.992915;0.083993;-0.084059;0],[0.083993;0.00432547;0.996457;0],[0.084059;-0.996457;-0.00276;0],[1.38778e-015;8.67362e-017;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(11).efl = 9040.35;%effective focal length in pixels
cameraVec(11).u0 = 332.033;% horizontal component of principal point (in pixels)
cameraVec(11).v0 = 231.521;% vertical component of principal point (in pixels)
cameraVec(11).pose = [[0.586904;0.220262;-0.77912;0],[0.220262;0.882557;0.415425;0],[0.77912;-0.415425;0.469461;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame
cameraVec(12).efl = 8924.8;%effective focal length in pixels
cameraVec(12).u0 = 330.849;% horizontal component of principal point (in pixels)
cameraVec(12).v0 = 232.283;% vertical component of principal point (in pixels)
cameraVec(12).pose = [[0.919948;-0.186002;-0.345108;0],[-0.186002;0.567822;-0.801861;0],[0.345108;0.801861;0.48777;0],[-0;-0;100;1]];% 4x4 matrix to transform coordinates from the world ref frame to the camera ref frame

imgCell = cell(size(cameraVec));
for viewLoop = 1:length(cameraVec),
    imgFilename = sprintf('%s/Human%02d.png', fileparts(mfilename('fullpath')), viewLoop);
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
[pMesh, kMesh] = VisualHullTriMesh( cameraVec, imgCell, 1, 0.06 );

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
