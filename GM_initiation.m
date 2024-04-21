function vars = GM_initiation( vars )

vars.idxMat = false( length( vars.areas ), sum( vars.areas, 2 ) );
vars.idxMatCh = false( length( vars.areas ), sum( vars.areas, 2 ), vars.nChannels );
vars.idxMatChAll = false( length( vars.areas ) * vars.nChannels, sum( vars.areas, 2 ) );
vars.idxInputs = false( sum( vars.areas, 2 ), 1 );
vars.idxInputsInd = false( sum( vars.areas, 2 ), length( vars.inputs ) );
ct1 = 0;
ct2 = 0;
ct3 = 0;
for h = 1 : length( vars.areas )
    vars.idxMat( h, ct1 + [ 1 : vars.areas( h ) ] ) = true;
    areaPartition = round( linspace( 0, vars.areas( h ), vars.nChannels + 1 ) );
    for ch = 1 : vars.nChannels
        vars.idxMatCh( h, ct1 + [ areaPartition( ch ) + 1 : areaPartition( ch + 1 ) ], ch ) = true;
        ct3 = ct3 + 1;
        vars.idxMatChAll( ct3, : ) = vars.idxMatCh( h, :, ch );
    end
    if ismember( h, vars.inputs )
        ct2 = ct2 + 1;
        vars.idxInputs( ct1 + [ 1 : vars.areas( h ) ], 1 ) = true;
        vars.idxInputsInd( ct1 + [ 1 : vars.areas( h ) ], ct2 ) = true;
    end
    ct1 = ct1 + vars.areas( h );
end

% vars.actExt = transpose( sum( transpose( vars.areas ) .* vars.idxMat, 1 ) );
vars.actExt = transpose( sum( sum( vars.idxMatChAll, 2 ) .* vars.idxMatChAll, 1 ) );
vars.actThrs = transpose( vars.actThr * vars.idxMat );

% initiation of weights
vars.idxWeights = false( sum( vars.areas, 2 ), sum( vars.areas, 2 ) );
vars.scaleWeights = zeros( sum( vars.areas, 2 ), sum( vars.areas, 2 ) );
vars.weights = zeros( sum( vars.areas, 2 ), sum( vars.areas, 2 ) );
for h1 = 1 : length( vars.areas )
    for h2 = 1 : length( vars.areas )
        if vars.connects( h1, h2 ) > 0
            if h1 ~= h2
                for ch = 1 : vars.nChannels
                    vars.idxWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = true;
                    vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = 1;
                end
            elseif h1 == h2
                vars.idxWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = true;
                vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = 1;
                if vars.nChannels > 1
                    for ch = 1 : vars.nChannels
                        vars.idxWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = false;
                        vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = 0;
                    end
                end
            end
            if h1 ~= h2
                for ch = 1 : vars.nChannels
                    vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = rand( sum( vars.idxMatCh( h1, :, ch ), 2 ), sum( vars.idxMatCh( h2, :, ch ), 2 ) );
                end
            elseif h1 == h2
                vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = ones( vars.areas( h1 ), vars.areas( h2 ) );
                if vars.nChannels > 1
                    for ch = 1 : vars.nChannels
                        vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = zeros( sum( vars.idxMatCh( h1, :, ch ), 2 ), sum( vars.idxMatCh( h2, :, ch ), 2 ) );
                    end
                end
            end
        end
    end
end

% synaptic scaling
for h1 = 1 : length( vars.areas )
    for h2 = 1 : length( vars.areas )
        if vars.connects( h1, h2 ) > 0
            if h1 ~= h2
                for ch = 1 : vars.nChannels
                    vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = vars.connects( h1, h2 ) * ( vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                    vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = vars.connects( h1, h2 ) * ( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                end
            elseif h1 == h2
                vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = vars.connects( h1, h2 ) * ( vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
                vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = vars.connects( h1, h2 ) * ( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
            end
        end
    end
end
