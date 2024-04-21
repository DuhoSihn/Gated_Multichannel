function vars = GM_SNN_stimulation_distProj( vars )

r_ext_EE = vars.r_ext_EE / 1000;
r_ext_IE = vars.r_ext_IE / 1000;

N_unit_whole = vars.N_E( vars.inputs );
N_unit_channel = floor( N_unit_whole / vars.infoStims( 4 ) );
% cosTunCurve = cos( linspace( 0, 2 * pi, N_unit_channel ) );
gaussTunCurve = circshift( normpdf( linspace( -3, 3, N_unit_channel ), 0, 0.25 ), -floor( N_unit_channel / 2 ) );

Stims = ones( N_unit_channel, vars.infoStims( 2 ) / vars.dt, vars.infoStims( 5 ) );
for s = 1 : vars.infoStims( 5 )
    % Stims( :, :, s ) = repmat( transpose( circshift( cosTunCurve, ( s - 1 ) * ( N_unit_channel / vars.infoStims( 5 ) ) ) ), [ 1, vars.infoStims( 2 ) / vars.dt, 1 ] );
    Stims( :, :, s ) = repmat( transpose( circshift( gaussTunCurve, ( s - 1 ) * ( N_unit_channel / vars.infoStims( 5 ) ) ) ), [ 1, vars.infoStims( 2 ) / vars.dt, 1 ] );
end
% actTrend = [ linspace( 0, 1, round( ( vars.infoStims( 2 ) / vars.dt ) / 2 ) ), linspace( 1, 0, ( vars.infoStims( 2 ) / vars.dt ) - round( ( vars.infoStims( 2 ) / vars.dt ) / 2 ) ) ];
% Stims = Stims .* actTrend;
Stims = Stims + 1;
Stims = Stims ./ mean( Stims, 1 );

nStims = round( ( vars.infoStims( 1 ) / vars.dt ) * vars.infoStims( 3 ) );

randBegin = nan( vars.infoStims( 4 ), nStims );
for ch = 1 : vars.infoStims( 4 )
    randBegin( ch, : ) = sort( randperm( ( vars.infoStims( 1 ) / vars.dt ) - ( vars.infoStims( 2 ) / vars.dt ) + 1, nStims ) );
end

vars.ext_stim_E = zeros( sum( vars.N_E, 2 ), vars.infoStims( 1 ) / vars.dt );
vars.ext_stim_I = zeros( sum( vars.N_I, 2 ), vars.infoStims( 1 ) / vars.dt );
ct_E_h = 0;
ct_E_h_Inputs = 0;
ct_I_h = 0;
for h = 1 : length( vars.N_E )
    ext_stim_E = ones( N_unit_whole, vars.infoStims( 1 ) / vars.dt );
    tItv = 1 : ( vars.infoStims( 1 ) / vars.dt ) / nStims : ( vars.infoStims( 1 ) / vars.dt );
    for t = 1 : nStims
        tInter = vars.infoStimsInter( randperm( length( vars.infoStimsInter ), 1 ) );
        tInterIdx = nan( 1, vars.infoStims( 4 ) );
        str0 = '';
        str1 = '';
        for ch = 1 : vars.infoStims( 4 )
            if ch == 1
                str0 = [ str0, '[ tInterIdx( 1 ), ' ];
                str1 = [ str1, '[ vars.infoStims( 5 ), ' ];
            elseif ch > 1 && ch < vars.infoStims( 4 )
                str0 = [ str0, 'tInterIdx( ', num2str( ch ), ' ), ' ];
                str1 = [ str1, 'vars.infoStims( 5 ), ' ];
            elseif ch > 1 && ch == vars.infoStims( 4 )
                str0 = [ str0, 'tInterIdx( ', num2str( ch ), ' ) ] = ' ];
                str1 = [ str1, 'vars.infoStims( 5 ) ]' ];
            end
        end
        str0 = [ str0, 'ind2sub( ', str1, ', ', num2str( tInter ), ' );' ];
        eval( str0 );
        for ch = 1 : vars.infoStims( 4 )
            if t < nStims
                tIdx = randBegin( ch, : ) >= tItv( t ) & randBegin( ch, : ) < tItv( t + 1 );
            elseif t == nStims
                tIdx = randBegin( ch, : ) >= tItv( t ) & randBegin( ch, : ) <= vars.infoStims( 1 );
            end
            ttIdx = find( tIdx == 1 );
            if ~isempty( ttIdx )
                for tt = 1 : length( ttIdx )
                    ext_stim_E( ( ch - 1 ) * N_unit_channel + [ 1 : N_unit_channel ], randBegin( ch, ttIdx( tt ) ) + [ 0 : ( vars.infoStims( 2 ) / vars.dt ) - 1 ] ) = Stims( :, :, tInterIdx( ch ) );
                end
            end
        end
    end
    % ext_stim_E = ext_stim_E - min( [ 0.6, min( ext_stim_E( : ), [], 1 ) ], [], 2 );
    ext_stim_E = ext_stim_E - min( ext_stim_E( : ), [], 1 );
    if ismember( h, vars.inputs )
        vars.ext_stim_E( ct_E_h + [ 1 : vars.N_E( h ) ], : ) = ext_stim_E;
        ct_E_h_Inputs = ct_E_h_Inputs + vars.N_E( h );
    elseif ~ismember( h, vars.inputs )
        ext_stim_I = abs( pinknoise( vars.N_I( h ), ( vars.infoStims( 1 ) / vars.dt ) ) );
        ext_stim_I = ext_stim_I / max( ext_stim_I( : ), [], 1 );
        vars.ext_stim_I( ct_I_h + [ 1 : vars.N_I( h ) ], : ) = ext_stim_I;
    end
    ct_E_h = ct_E_h + vars.N_E( h );
    ct_I_h = ct_I_h + vars.N_I( h );
end

vars.ext_stim_E = r_ext_EE * vars.ext_stim_E;
vars.ext_stim_I = r_ext_IE * vars.ext_stim_I;

% -------------------------------------------------------------------------

[ vars, records ] = GM_SNN_simulation( vars, 'plasticity_off', 'records_on' );
% [ vars, records ] = GM_SNN_simulation_GPU( vars, 'plasticity_off', 'records_on' );

% -------------------------------------------------------------------------

vars.projs = cell( vars.infoStims( 4 ), length( vars.N_E ) );
for ch = 1 : vars.infoStims( 4 )
    for h = 1 : length( vars.N_E )
        X = nan( vars.N_E( h ), nStims * ( vars.infoStims( 2 ) / vars.dt ) );
        cumAreas = [ 0, cumsum( vars.N_E ) ];
        for t = 1 : nStims
            X( :, ( t - 1 ) * ( vars.infoStims( 2 ) / vars.dt ) + [ 1 : ( vars.infoStims( 2 ) / vars.dt ) ] ) = records.s_E( cumAreas( h ) + 1 : cumAreas( h + 1 ), randBegin( ch, t ) + [ 0 : ( vars.infoStims( 2 ) / vars.dt ) - 1 ] );
        end
        transBinMat = zeros( size( X, 2 ), floor( size( X, 2 ) / ( vars.binSize / vars.dt ) ) );
        ct_bin = 0;
        for b = 1 : floor( size( X, 2 ) / ( vars.binSize / vars.dt ) )
            transBinMat( ct_bin + [ 1 : ( vars.binSize / vars.dt ) ], b ) = 1;
            ct_bin = ct_bin + ( vars.binSize / vars.dt );
        end
        X = X * transBinMat;
        X = transpose( X );
        

        [ coeff, score, latent, tsquared, explained, mu ] = pca( X );

        try
            proj = inv( transpose( coeff ) );% inverse
        catch
            proj = coeff * inv( transpose( coeff ) * coeff );% pseudo-inverse
            disp( 'Calculate, pseudo-inverse!' )
        end

        % vars.projs{ ch, h } = proj( :, explained >= 1 );
        vars.projs{ ch, h } = proj( :, 1 : vars.infoStims( 5 ) );
        vars.projs{ ch, h } = vars.projs{ ch, h } ./ sqrt( sum( vars.projs{ ch, h } .^ 2, 1 ) );% make sure, orthonomal
    end
end

% projection metric
vars.projMetric = nan( vars.infoStims( 4 ), vars.infoStims( 4 ), length( vars.N_E ) );
for ch1 = 1 : vars.infoStims( 4 ) - 1
    for ch2 = ch1 + 1 : vars.infoStims( 4 )
        for h = 1 : length( vars.N_E )
            proj1 = vars.projs{ ch1, h };
            proj2 = vars.projs{ ch2, h };
            minDim = min( [ size( proj1, 2 ), size( proj2, 2 ) ], [], 2 );
            proj1 = proj1( :, 1 : minDim );
            proj2 = proj2( :, 1 : minDim );
            [ ~, PA, ~ ] = svd( transpose( proj1 ) * proj2 );% principal angles
            PA = diag( PA );% principal angles
            vars.projMetric( ch1, ch2, h ) = sqrt( length( PA ) - sum( PA .^ 2, 1 ) );
        end
    end
end

% dot product between projection vectors
% vars.prodProj = cell( vars.infoStims( 4 ), vars.infoStims( 4 ), length( vars.N_E ) );
% vars.prodProjAll = [];
vars.prodProj = nan( vars.infoStims( 4 ), vars.infoStims( 4 ), length( vars.N_E ) );
for ch1 = 1 : vars.infoStims( 4 ) - 1
    for ch2 = ch1 + 1 : vars.infoStims( 4 )
        for h = 1 : length( vars.N_E )
            proj1 = vars.projs{ ch1, h };
            proj2 = vars.projs{ ch2, h };
            %             prod12 = [];
            %             for p1 = 1 : size( proj1, 2 )
            %                 for p2 = 1 : size( proj2, 2 )
            %                     prod12( p1, p2 ) = transpose( proj1( :, p1 ) ) * proj2( :, p2 );
            %                 end
            %             end
            %             vars.prodProj{ ch1, ch2, h } = prod12;
            vars.prodProj( ch1, ch2, h ) = transpose( proj1( :, 1 ) ) * proj2( :, 1 );
            % vars.prodProjAll = [ vars.prodProjAll; prod12( : ) ];
        end
    end
end
