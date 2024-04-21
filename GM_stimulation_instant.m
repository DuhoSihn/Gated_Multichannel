function vars = GM_stimulation_instant( vars )

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

nStims = vars.infoStims( 4 ) * vars.infoStims( 5 );

vars.stims = ones( N_unit_whole, vars.infoStims( 1 ) );
vars.stimsChTs = nan( 2, nStims );
tItv = vars.infoStims( 2 ) + [ 1 : 2 * vars.infoStims( 2 ) : vars.infoStims( 1 ) - vars.infoStims( 2 ) ];
ch = 1;
ct_stim = 0;
for t = 1 : nStims
    ct_stim = ct_stim + 1;
    vars.stims( ( ch - 1 ) * N_unit_channel + [ 1 : N_unit_channel ], tItv( t ) + [ 0 : vars.infoStims( 2 ) - 1 ] ) = Stims( :, :, ct_stim );
    vars.stimsChTs( 1, t ) = ch;
    vars.stimsChTs( 2, t ) = tItv( t );
    if mod( t, vars.infoStims( 5 ) ) == 0
        ch = ch + 1;
        ct_stim = 0;
    end
end
