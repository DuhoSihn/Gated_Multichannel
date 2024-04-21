function vars = GM_define_interaction_c1( vars )
% ( 1, 2, 1, 2, 1 ), ( 1, 1, 2, 1, 2 ), ( 2, 1, 1, 2, 1 ), ...

temp_infoStimsInter = perms( [ 1 * ones( 1, ceil( vars.infoStims( 4 ) / 2 ) ), 2 * ones( 1, floor( vars.infoStims( 4 ) / 2 ) ) ] );
temp_infoStimsInter = temp_infoStimsInter( randperm( size( temp_infoStimsInter, 1 ), vars.infoStims( 5 ) ), : );

vars.infoStimsInter = [];
for k = 1 : vars.infoStims( 5 )
    str = '';
    str = [ str, 'tInterIdxk = sub2ind( vars.infoStims( 5 ) * ones( 1, vars.infoStims( 4 ) )' ];
    for d = 1 : vars.infoStims( 4 )
        str = [ str, ', ', num2str( temp_infoStimsInter( k, d ) ) ];
    end
    str = [ str, ' );' ];
    eval( str )
    vars.infoStimsInter = [ vars.infoStimsInter, tInterIdxk ];
end
