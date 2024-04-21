function vars = GM_SNN_stimulation( vars )

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
                tIdx = randBegin( ch, : ) >= tItv( t ) & randBegin( ch, : ) <= ( vars.infoStims( 1 ) / vars.dt );
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

