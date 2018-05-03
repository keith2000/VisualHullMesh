function pVec = ConvexPolyhedronFacesToDualPoints( pPolyhedron )
    kPolyhedron = convhulln( pPolyhedron' )';
    
    pVec = NaN( size(pPolyhedron,1), size(kPolyhedron,2) );
    for faceLoop = 1:size(kPolyhedron,2)
        A = ( pPolyhedron(:, kPolyhedron(:,faceLoop)) ); %form a matrix consisting of the vertices of the current face
        A = [A; ones(1, size(A,2) )]' ;
        [~,~,V] = svd(A);
        theJoin = V(:,end); %right nullspace is the plane/point in homogeneous coords
        pVec(:,faceLoop) = theJoin(1:3)/theJoin(4); %convert to inhomogeneous coords
    end
end