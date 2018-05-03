function fovBound = CommonFovBoundBox( cameraVec )
    
    %Compute polyhedron representing the common field of view
    %uses a dual space approach so that convhulln can be used for halfspace
    %intersections
    
    pImageVec = NaN(2, length(cameraVec) );
    
    for camLoop = 1:length(cameraVec)
        pImageVec(1,camLoop) = cameraVec(camLoop).width / 2;
        pImageVec(2,camLoop) = cameraVec(camLoop).height / 2;
    end
    
    centrePoint = LinearTriang( pImageVec, cameraVec );
    pDualVec = [];
    for camLoop = 1:length(cameraVec)
        efl = cameraVec(camLoop).efl;
        width = cameraVec(camLoop).width;
        height = cameraVec(camLoop).height;
        u0 = cameraVec(camLoop).u0;
        v0 = cameraVec(camLoop).v0;
        rectCam = [[1-u0;1-v0;efl], [1-u0;height-v0;efl], [width-u0;height-v0;efl], [width-u0;1-v0;efl]];
        invRbt = inv(cameraVec(camLoop).pose);
        invRbt(1:3, 4) = invRbt(1:3, 4) - centrePoint;
        rectWorld = invRbt(1:3,:) * [rectCam; [1,1,1,1]];
        vA = rectWorld-repmat(invRbt(1:3,4), 1, 4);
        vB = circshift(vA, [0 1]);
        faceNormal = cross(vA,vB);
        d = - dot(faceNormal, repmat(invRbt(1:3,4), 1, 4) );
        thisVec = faceNormal./repmat(d, 3, 1);
        pDualVec = [pDualVec, thisVec];
    end
    
    fovBound = ConvexPolyhedronFacesToDualPoints( pDualVec );
    fovBound = fovBound + repmat(centrePoint, 1, size(fovBound,2) );
    
end

function pWorld = LinearTriang( pImageVec, cameraVec )
    assert( size(pImageVec, 1)==2 )
    assert( size(pImageVec, 2)== length(cameraVec) )
    for camLoop = 1:length(cameraVec)
        K = [cameraVec(camLoop).efl, 0, cameraVec(camLoop).u0;...
            0, cameraVec(camLoop).efl,  cameraVec(camLoop).v0;...
            0, 0, 1 ];
        KRt = K * cameraVec(camLoop).pose(1:3,:);
        A( (camLoop-1) * 2 + 1, : ) = ( KRt(1,1:3) - pImageVec(1, camLoop) * KRt(3,1:3) );
        b( (camLoop-1) * 2 + 1, 1 ) = pImageVec(1, camLoop) * KRt(3,4) - KRt(1,4);
        A( (camLoop-1) * 2 + 2, : ) = ( KRt(2,1:3) - pImageVec(2, camLoop) * KRt(3,1:3) );
        b( (camLoop-1) * 2 + 2, 1 ) = pImageVec(2, camLoop) * KRt(3,4) - KRt(2,4);
    end
    A = A((~isnan(A(:,1))),:);
    b = b((~isnan(b(:,1))),:);
    [U,Sigma,V] = svd(A);
    diags = [diag(1./diag(Sigma)), zeros( size(Sigma,2), size(Sigma,1)-size(Sigma,2))];
    pWorld = V * diags * ( U.' * b);
    
end

