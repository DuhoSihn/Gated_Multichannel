function vars = GM_stimulation_distProj_stims( vars )

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

% -------------------------------------------------------------------------

vars.projs = cell( vars.infoStims( 4 ), 1 );
for ch = 1 : vars.infoStims( 4 )
    h = 1;
    X = nan( vars.areas( 2 ), nStims * vars.infoStims( 2 ) );
    for t = 1 : nStims
        X( :, ( t - 1 ) * vars.infoStims( 2 ) + [ 1 : vars.infoStims( 2 ) ] ) = vars.stims( :, randBegin( ch, t ) + [ 0 : vars.infoStims( 2 ) - 1 ] );
    end
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

% projection metric
vars.projMetric = nan( vars.infoStims( 4 ), vars.infoStims( 4 ), 1 );
for ch1 = 1 : vars.infoStims( 4 ) - 1
    for ch2 = ch1 + 1 : vars.infoStims( 4 )
        h = 1;
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

% dot product between projection vectors
% vars.prodProj = cell( vars.infoStims( 4 ), vars.infoStims( 4 ), 1 );
% vars.prodProjAll = [];
vars.prodProj = nan( vars.infoStims( 4 ), vars.infoStims( 4 ), 1 );
for ch1 = 1 : vars.infoStims( 4 ) - 1
    for ch2 = ch1 + 1 : vars.infoStims( 4 )
        h = 1;
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
