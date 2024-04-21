function vars = GM_stimulation( vars )

N_unit_whole = vars.areas( vars.inputs );
N_unit_channel = floor( N_unit_whole / vars.infoStims( 4 ) );
% cosTunCurve = cos( linspace( 0, 2 * pi, N_unit_channel ) );
gaussTunCurve = circshift( normpdf( linspace( -3, 3, N_unit_channel ), 0, 0.25 ), -floor( N_unit_channel / 2 ) );

Stims = ones( N_unit_channel, vars.infoStims( 2 ), vars.infoStims( 5 ) );
for s = 1 : vars.infoStims( 5 )
    % Stims( :, :, s ) = repmat( transpose( circshift( cosTunCurve, ( s - 1 ) * ( N_unit_channel / vars.infoStims( 5 ) ) ) ), [ 1, vars.infoStims( 2 ), 1 ] );
    Stims( :, :, s ) = repmat( transpose( circshift( gaussTunCurve, ( s - 1 ) * ( N_unit_channel / vars.infoStims( 5 ) ) ) ), [ 1, vars.infoStims( 2 ), 1 ] );
end
actTrend = [ linspace( 0, 1, round( vars.infoStims( 2 ) / 2 ) ), linspace( 1, 0, vars.infoStims( 2 ) - round( vars.infoStims( 2 ) / 2 ) ) ];
Stims = Stims .* actTrend;
Stims = Stims + 1;
Stims = Stims ./ mean( Stims, 1 );

nStims = round( vars.infoStims( 1 ) * vars.infoStims( 3 ) );

randBegin = nan( vars.infoStims( 4 ), nStims );
for ch = 1 : vars.infoStims( 4 )
    randBegin( ch, : ) = sort( randperm( vars.infoStims( 1 ) - vars.infoStims( 2 ) + 1, nStims ) );
end

vars.stims = ones( N_unit_whole, vars.infoStims( 1 ) );
tItv = 1 : vars.infoStims( 1 ) / nStims : vars.infoStims( 1 );
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
                vars.stims( ( ch - 1 ) * N_unit_channel + [ 1 : N_unit_channel ], randBegin( ch, ttIdx( tt ) ) + [ 0 : vars.infoStims( 2 ) - 1 ] ) = Stims( :, :, tInterIdx( ch ) );
            end
        end
    end
end
