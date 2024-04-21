function vars = GM_SNN_stimulation_MI( vars )

r_ext_EE = vars.r_ext_EE / 1000;
r_ext_IE = vars.r_ext_IE / 1000;

N_unit_whole = sum( vars.N_E( vars.inputs ), 2 );

N_tr = floor( ( vars.infoStims_MI( 1 ) / vars.dt ) / ( ( vars.infoStims_MI( 2 ) / vars.dt ) + ( vars.infoStims_MI( 3 ) / vars.dt ) ) );
vars.classes = nan( 1, N_tr );
for tr = 1 : N_tr
    if length( vars.infoStims_MI ) == 5
        vars.classes( 1, tr ) = randperm( vars.infoStims_MI( 4 ), 1 );
    elseif length( vars.infoStims_MI ) == 6
        vars.classes( 1, tr ) = vars.infoStims_MI( 6 );
    end
end

vars.ext_stim_E = zeros( sum( vars.N_E, 2 ), vars.infoStims_MI( 1 ) / vars.dt );
vars.ext_stim_I = zeros( sum( vars.N_I, 2 ), vars.infoStims_MI( 1 ) / vars.dt );
ct_E_h = 0;
ct_E_h_Inputs = 0;
ct_I_h = 0;
for h = 1 : length( vars.N_E )

    if ismember( h, vars.inputs )

        idxClass = false( vars.infoStims_MI( 4 ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
        ct_c = 0;
        for c = 1 : vars.infoStims_MI( 4 )
            idxClass( c, ct_c + [ 1 : vars.infoStims_MI( 5 ) ] ) = true;
            ct_c = ct_c + vars.infoStims_MI( 5 );
        end

        % gaussTunCurve = circshift( normpdf( linspace( -15, 15, vars.N_E( vars.inputs( h ) ) ), 0, 0.25 ), -floor( vars.N_E( vars.inputs( h ) ) / 2 ) );
        gaussTunCurve = circshift( normpdf( linspace( -8, 8, vars.N_E( vars.inputs( h ) ) ), 0, 0.25 ), -floor( vars.N_E( vars.inputs( h ) ) / 2 ) );
        egStim = ones( vars.N_E( vars.inputs( h ) ), ( vars.infoStims_MI( 2 ) / vars.dt ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
        for s = 1 : vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 )
            egStim( :, :, s ) = repmat( transpose( circshift( gaussTunCurve, ( s - 1 ) * ( vars.N_E( vars.inputs( h ) ) / ( vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) ) ) ) ), [ 1, ( vars.infoStims_MI( 2 ) / vars.dt ), 1 ] );
        end
        % actTrend = [ linspace( 0, 1, round( ( vars.infoStims_MI( 2 ) / vars.dt ) / 2 ) ), linspace( 1, 0, ( vars.infoStims_MI( 2 ) / vars.dt ) - round( ( vars.infoStims_MI( 2 ) / vars.dt ) / 2 ) ) ];
        % egStim = egStim .* actTrend;
        egStim = egStim + 1;
        egStim = egStim ./ mean( egStim, 1 );


        ext_stim_E = ones( vars.N_E( vars.inputs( h ) ), ( vars.infoStims_MI( 1 ) / vars.dt ) );
        ct_t = 0;
        for tr = 1 : N_tr
            idxStim = find( idxClass( vars.classes( tr ), : ) );
            ext_stim_E( :, ct_t + [ 1 : ( vars.infoStims_MI( 2 ) / vars.dt ) ] ) = egStim( :, :, idxStim( randperm( vars.infoStims_MI( 5 ), 1 ) ) );
            ct_t = ct_t + ( vars.infoStims_MI( 2 ) / vars.dt );
            ct_t = ct_t + ( vars.infoStims_MI( 3 ) / vars.dt );
        end

        % ext_stim_E = ext_stim_E - min( [ 0.6, min( ext_stim_E( : ), [], 1 ) ], [], 2 );
        ext_stim_E = ext_stim_E - min( ext_stim_E( : ), [], 1 );

        vars.ext_stim_E( ct_E_h + [ 1 : vars.N_E( h ) ], : ) = ext_stim_E;
        ct_E_h_Inputs = ct_E_h_Inputs + vars.N_E( h );
    elseif ~ismember( h, vars.inputs )
        ext_stim_I = abs( pinknoise( vars.N_I( h ), ( vars.infoStims_MI( 1 ) / vars.dt ) ) );
        ext_stim_I = ext_stim_I / max( ext_stim_I( : ), [], 1 );
        vars.ext_stim_I( ct_I_h + [ 1 : vars.N_I( h ) ], : ) = ext_stim_I;
    end
    ct_E_h = ct_E_h + vars.N_E( h );
    ct_I_h = ct_I_h + vars.N_I( h );

end

vars.ext_stim_E = r_ext_EE * vars.ext_stim_E;
vars.ext_stim_I = r_ext_IE * vars.ext_stim_I;

