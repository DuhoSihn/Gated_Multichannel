function vars = GM_SNN_initiation_MI( vars )

N_E = vars.N_E;
N_I = vars.N_I;

p_C = vars.p_C;
% p_E = vars.p_E;

J_EE_min = vars.J_EE_min;
J_EE_max = vars.J_EE_max;
% J_EE_O = vars.J_EE_O;
J_EE_O1 = vars.J_EE_O1;
J_EE_O2 = vars.J_EE_O2;
J_EE_O3 = vars.J_EE_O3;
J_EE_O4 = vars.J_EE_O4;
J_EE_O5 = vars.J_EE_O5;
J_EI_min = vars.J_EI_min;
J_EI_max = vars.J_EI_max;
J_EI_O = vars.J_EI_O;
J_IE_val = vars.J_IE_val;
J_II_val = vars.J_II_val;
% J_GII_val = vars.J_GII_val;

nChannels = length( vars.N_E ) - 1;% the number of channels
nStims = vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 );
% nStimsS = round( vars.infoStims_MI( 5 ) / 2.5 );
% nStimsS = round( vars.infoStims_MI( 5 ) / 1.25 );
nStimsS = round( vars.infoStims_MI( 5 ) / 5 );
nStimsS5 = round( vars.infoStims_MI( 5 ) / 5 );

% -------------------------------------------------------------------------

idxMat_E = false( length( N_E ), sum( N_E, 2 ) );
idxMatCh_E = false( length( N_E ), sum( N_E, 2 ), nChannels );
idxMatChAll_E = false( ( length( N_E ) - 1 ) + nChannels, sum( N_E, 2 ) );
ct1 = 0;
ct3 = 0;
for h = 1 : length( N_E )
    idxMat_E( h, ct1 + [ 1 : N_E( h ) ] ) = true;
    if h < length( N_E )
        ch = h;
        idxMatCh_E( h, ct1 + [ 1 : N_E( h ) ], ch ) = true;
        ct3 = ct3 + 1;
        idxMatChAll_E( ct3, : ) = idxMatCh_E( h, :, ch );
    elseif h == length( N_E )
        areaPartition = round( linspace( 0, N_E( h ), nChannels + 1 ) );
        for ch = 1 : nChannels
            idxMatCh_E( h, ct1 + [ areaPartition( ch ) + 1 : areaPartition( ch + 1 ) ], ch ) = true;
            ct3 = ct3 + 1;
            idxMatChAll_E( ct3, : ) = idxMatCh_E( h, :, ch );
        end
    end
    ct1 = ct1 + N_E( h );
end
idxMat_I = false( length( N_I ), sum( N_I, 2 ) );
idxMatCh_I = false( length( N_I ), sum( N_I, 2 ), nChannels );
idxMatChAll_I = false( ( length( N_I ) - 1 ) + nChannels, sum( N_I, 2 ) );
ct1 = 0;
ct3 = 0;
for h = 1 : length( N_I )
    idxMat_I( h, ct1 + [ 1 : N_I( h ) ] ) = true;
    if h < length( N_I )
        ch = h;
        idxMatCh_I( h, ct1 + [ 1 : N_I( h ) ], ch ) = true;
        ct3 = ct3 + 1;
        idxMatChAll_I( ct3, : ) = idxMatCh_I( h, :, ch );
    elseif h == length( N_I )
        areaPartition = round( linspace( 0, N_I( h ), nChannels + 1 ) );
        for ch = 1 : nChannels
            idxMatCh_I( h, ct1 + [ areaPartition( ch ) + 1 : areaPartition( ch + 1 ) ], ch ) = true;
            ct3 = ct3 + 1;
            idxMatChAll_I( ct3, : ) = idxMatCh_I( h, :, ch );
        end
    end
    ct1 = ct1 + N_I( h );
end

% -------------------------------------------------------------------------
% initiation of weights

idx_J_EE = false( sum( N_E, 2 ), sum( N_E, 2 ) );
idx_J_EI = false( sum( N_E, 2 ), sum( N_I, 2 ) );
idx_J_IE = false( sum( N_I, 2 ), sum( N_E, 2 ) );
idx_J_II = false( sum( N_I, 2 ), sum( N_I, 2 ) );

idx_J_EE_1 = false( sum( N_E, 2 ), sum( N_E, 2 ) );
idx_J_EI_1 = false( sum( N_E, 2 ), sum( N_I, 2 ) );
idx_J_IE_1 = false( sum( N_I, 2 ), sum( N_E, 2 ) );
idx_J_II_1 = false( sum( N_I, 2 ), sum( N_I, 2 ) );

J_EE = zeros( sum( N_E, 2 ), sum( N_E, 2 ) );
J_EI = zeros( sum( N_E, 2 ), sum( N_I, 2 ) );
J_IE = zeros( sum( N_I, 2 ), sum( N_E, 2 ) );
J_II = zeros( sum( N_I, 2 ), sum( N_I, 2 ) );

for h1 = 1 : length( N_E )
    if h1 < length( N_E )
        h2 = length( N_E );
        if vars.connects( h1, h2 ) > 0
            ch = h1;
            idx_J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
            idx_J_EE_1( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
            J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = J_EE_O2;
            init_Conn = false( N_E( h1 ), sum( idxMatCh_E( h2, :, ch ), 2 ) );
            ct4 = 0;
            ct5 = 0;
            for stim = 1 : nStims
                for sStim = -nStimsS : nStimsS
                    init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                    init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                    init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                end
                init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims );
                ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims );
            end
            temp_J_EE = J_EE( idxMat_E( h1, : ), idxMatCh_E( h2, :, ch ) );
            temp_J_EE( init_Conn ) = J_EE_O1;
            J_EE( idxMat_E( h1, : ), idxMatCh_E( h2, :, ch ) ) = temp_J_EE;
            init_Conn = false( N_E( h1 ), sum( idxMatCh_E( h2, :, ch ), 2 ) );
            ct4 = 0;
            ct5 = 0;
            for stim = 1 : nStims
                for sStim = -nStimsS5 : nStimsS5
                    init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                    init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                    init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                end
                init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims );
                ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims );
            end
            temp_J_EE = J_EE( idxMat_E( h1, : ), idxMatCh_E( h2, :, ch ) );
            temp_J_EE( init_Conn ) = J_EE_O5;
            J_EE( idxMat_E( h1, : ), idxMatCh_E( h2, :, ch ) ) = temp_J_EE;
        end
        h2 = h1;
        if vars.connects( h1, h2 ) > 0
            ch = h1;
            idx_J_EI( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
            idx_J_EI_1( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
            idx_J_IE( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
            idx_J_IE_1( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
            idx_J_II( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
            idx_J_II_1( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
            J_EI( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = J_EI_O;
            J_IE( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = J_IE_val;
            J_II( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = J_II_val;
        end
    elseif h1 == length( N_E )
        for h2 = 1 : length( N_E )
            if vars.connects( h1, h2 ) > 0
                if h1 ~= h2
                    ch = h2;
                    idx_J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
                    idx_J_EE_1( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
                    J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = J_EE_O2;
                    init_Conn = false( sum( idxMatCh_E( h1, :, ch ), 2 ), sum( idxMatCh_E( h2, :, ch ), 2 ) );
                    ct4 = 0;
                    ct5 = 0;
                    for stim = 1 : nStims
                        for sStim = -nStimsS : nStimsS
                            init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                            init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                            init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                        end
                        init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                        ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims );
                        ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims );
                    end
                    temp_J_EE = J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) );
                    temp_J_EE( init_Conn ) = J_EE_O1;
                    J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = temp_J_EE;
                    init_Conn = false( sum( idxMatCh_E( h1, :, ch ), 2 ), sum( idxMatCh_E( h2, :, ch ), 2 ) );
                    ct4 = 0;
                    ct5 = 0;
                    for stim = 1 : nStims
                        for sStim = -nStimsS5 : nStimsS5
                            init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                            init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                            init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ), 2 );
                        end
                        init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims ) ] ) = true;
                        ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch ), 2 ) / nStims );
                        ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch ), 2 ) / nStims );
                    end
                    temp_J_EE = J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) );
                    temp_J_EE( init_Conn ) = J_EE_O5;
                    J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = temp_J_EE;
                elseif h1 == h2
                    idx_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) = true;
                    J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) = J_EE_O4;
                    for ch = 1 : nChannels
                        idx_J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = false;
                        idx_J_EI( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
                        idx_J_EI_1( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
                        idx_J_IE( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
                        idx_J_IE_1( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = true;
                        idx_J_II( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
                        idx_J_II_1( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = true;
                        J_EE( idxMatCh_E( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = 0;
                        J_EI( idxMatCh_E( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = J_EI_O;
                        J_IE( idxMatCh_I( h1, :, ch ), idxMatCh_E( h2, :, ch ) ) = J_IE_val;
                        J_II( idxMatCh_I( h1, :, ch ), idxMatCh_I( h2, :, ch ) ) = J_II_val;
                    end
                    for ch1 = 1 : nChannels
                        for ch2 = 1 : nChannels
                            if ch1 ~= ch2
                                init_Conn = false( sum( idxMatCh_E( h1, :, ch1 ), 2 ), sum( idxMatCh_E( h2, :, ch2 ), 2 ) );
                                ct4 = 0;
                                ct5 = 0;
                                for stim = 1 : nStims
                                    for sStim = -nStimsS : nStimsS
                                        init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ), 2 );
                                        init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ) ] ) = true;
                                        init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ), 2 );
                                    end
                                    init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ) ] ) = true;
                                    ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims );
                                    ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims );
                                end
                                temp_J_EE = J_EE( idxMatCh_E( h1, :, ch1 ), idxMatCh_E( h2, :, ch2 ) );
                                temp_J_EE( init_Conn ) = J_EE_O3;
                                J_EE( idxMatCh_E( h1, :, ch1 ), idxMatCh_E( h2, :, ch2 ) ) = temp_J_EE;
                                init_Conn = false( sum( idxMatCh_E( h1, :, ch1 ), 2 ), sum( idxMatCh_E( h2, :, ch2 ), 2 ) );
                                ct4 = 0;
                                ct5 = 0;
                                for stim = 1 : nStims
                                    for sStim = -nStimsS5 : nStimsS5
                                        init_Conn = circshift( init_Conn, -sStim * ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ), 2 );
                                        init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ) ] ) = true;
                                        init_Conn = circshift( init_Conn, sStim * ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ), 2 );
                                    end
                                    init_Conn( ct4 + [ 1 : ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims ) ], ct5 + [ 1 : ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims ) ] ) = true;
                                    ct4 = ct4 + ( sum( idxMatCh_E( h1, :, ch1 ), 2 ) / nStims );
                                    ct5 = ct5 + ( sum( idxMatCh_E( h2, :, ch2 ), 2 ) / nStims );
                                end
                                temp_J_EE = J_EE( idxMatCh_E( h1, :, ch1 ), idxMatCh_E( h2, :, ch2 ) );
                                temp_J_EE( init_Conn ) = J_EE_O5;
                                J_EE( idxMatCh_E( h1, :, ch1 ), idxMatCh_E( h2, :, ch2 ) ) = temp_J_EE;
                            end
                        end
                    end
                end
            end
        end
    end
end

p_idx = rand( size( idx_J_EE ) ) > p_C;
idx_J_EE( p_idx ) = false;
idx_J_EE_1( p_idx ) = false;
J_EE( p_idx ) = 0;

p_idx = rand( size( idx_J_EI ) ) > p_C;
idx_J_EI( p_idx ) = false;
idx_J_EI_1( p_idx ) = false;
J_EI( p_idx ) = 0;

p_idx = rand( size( idx_J_IE ) ) > p_C;
idx_J_IE( p_idx ) = false;
idx_J_IE_1( p_idx ) = false;
J_IE( p_idx ) = 0;

p_idx = rand( size( idx_J_II ) ) > p_C;
idx_J_II( p_idx ) = false;
idx_J_II_1( p_idx ) = false;
J_II( p_idx ) = 0;

% -------------------------------------------------------------------------

scaleWeight = vars.scaleWeight;

fill_EE = mean( idx_J_EE( : ), 1 );
fill_EI = mean( idx_J_EI( : ), 1 );
fill_IE = mean( idx_J_IE( : ), 1 );
fill_II = mean( idx_J_II( : ), 1 );

J_EE = ( scaleWeight / fill_EE ) * J_EE;
J_EI = ( scaleWeight / fill_EI ) * J_EI;
J_IE = ( scaleWeight / fill_IE ) * J_IE;
J_II = ( scaleWeight / fill_II ) * J_II;

J_EE_min = ( scaleWeight / fill_EE ) * J_EE_min;
J_EE_max = ( scaleWeight / fill_EE ) * J_EE_max;
% J_EE_O = ( scaleWeight / fill_EE ) * J_EE_O;
J_EI_min = ( scaleWeight / fill_EI ) * J_EI_min;
J_EI_max = ( scaleWeight / fill_EI ) * J_EI_max;

% -------------------------------------------------------------------------

% init_J_EE = J_EE_O * idx_J_EE;
init_J_EE = double( idx_J_EE );
for h1 = 1 : length( N_E )
    for h2 = 1 : length( N_E )
        if vars.connects( h1, h2 ) > 0
            temp_init = sum( J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ), 2 ) ./ sum( idx_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ), 2 );
            temp_init = repmat( temp_init, [ 1, sum( idxMat_E( h2, : ), 2 ) ] );
            temp_init( ~idx_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) ) = 0;
            init_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) = temp_init;
        end
    end
end

% Synaptic scaling
for h1 = 1 : length( N_E )
    for h2 = 1 : length( N_E )
        if vars.connects( h1, h2 ) > 0
            J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) = J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) - idx_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) .* ( sum( J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ) - init_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ), 2 ) ./ sum( idx_J_EE( idxMat_E( h1, : ), idxMat_E( h2, : ) ), 2 ) );
        end
    end
end
J_EE( isnan( J_EE ) ) = 0;
J_EE( idx_J_EE & J_EE < J_EE_min ) = J_EE_min;
J_EE( idx_J_EE & J_EE > J_EE_max ) = J_EE_max;

vars.idx_J_EE = idx_J_EE;
vars.idx_J_EI = idx_J_EI;
vars.idx_J_IE = idx_J_IE;
vars.idx_J_II = idx_J_II;
% vars.idx_J_GII = idx_J_GII;

vars.idx_J_EE_1 = idx_J_EE_1;
vars.idx_J_EI_1 = idx_J_EI_1;
vars.idx_J_IE_1 = idx_J_IE_1;
vars.idx_J_II_1 = idx_J_II_1;

vars.J_EE = J_EE;
vars.J_EI = J_EI;
vars.J_IE = J_IE;
vars.J_II = J_II;
% vars.J_GII = J_GII;

% vars.J_EE_1 = J_EE_1;
% vars.J_EI_1 = J_EI_1;
% vars.J_IE_1 = J_IE_1;
% vars.J_II_1 = J_II_1;

vars.init_J_EE = init_J_EE;
vars.idxMat_E = idxMat_E;

vars.J_EE_min = J_EE_min;
vars.J_EE_max = J_EE_max;
% vars.J_EE_O = J_EE_O;
vars.J_EI_min = J_EI_min;
vars.J_EI_max = J_EI_max;

% -------------------------------------------------------------------------
%
% figure
%
% subplot( 2, 5, 1 )
% imagesc( idx_J_EE )
% subplot( 2, 5, 2 )
% imagesc( idx_J_EI )
% subplot( 2, 5, 3 )
% imagesc( idx_J_IE )
% subplot( 2, 5, 4 )
% imagesc( idx_J_II )
% subplot( 2, 5, 5 )
% imagesc( idx_J_GII )
%
% subplot( 2, 5, 5 + 1 )
% imagesc( J_EE )
% subplot( 2, 5, 5 + 2 )
% imagesc( J_EI )
% subplot( 2, 5, 5 + 3 )
% imagesc( J_IE )
% subplot( 2, 5, 5 + 4 )
% imagesc( J_II )
% subplot( 2, 5, 5 + 5 )
% imagesc( J_GII )