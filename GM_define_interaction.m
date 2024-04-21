function vars = GM_define_interaction( vars )

vars.infoStimsInter = sort( randperm( vars.infoStims( 5 ) .^ vars.infoStims( 4 ), round( vars.infoStims( 6 ) * ( vars.infoStims( 5 ) .^ vars.infoStims( 4 ) ) ) ) );
