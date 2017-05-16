function CompileVisualHullTriMeshMex

dirname = fileparts(which('VisualHullTriMesh'));


cppFileCell = {'VisualHullTriMeshMex.cpp', 'IsInVisualHull.cpp', 'MatlabCameraView.cpp', 'polygonizer.cpp'};


str = sprintf('mex -outdir ''%s'' -v -I''%s'' ', dirname, dirname);
for jj = 1:length(cppFileCell)
    filename = sprintf('''%s/%s''', dirname, cppFileCell{jj} );
   str = [str, ' ', filename];
end

disp( str )
eval(str)

