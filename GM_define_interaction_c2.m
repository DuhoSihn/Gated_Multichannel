function vars = GM_define_interaction_c2( vars )
% ( 1, 1, 1, 1, 1 ), ( 2, 2, 2, 2, 2 ), ( 3, 3, 3, 3, 3 ), ......

vars.infoStimsInter = [];
for k = 1 : vars.infoStims( 5 )
    str = '';
    str = [ str, 'tInterIdxk = sub2ind( vars.infoStims( 5 ) * ones( 1, vars.infoStims( 4 ) )' ];
    for d = 1 : vars.infoStims( 4 )
        str = [ str, ', ', num2str( k ) ];
    end
    str = [ str, ' );' ];
    eval( str )
    vars.infoStimsInter = [ vars.infoStimsInter, tInterIdxk ];
end
