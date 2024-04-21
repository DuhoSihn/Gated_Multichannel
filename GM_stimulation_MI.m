function vars = GM_stimulation_MI( vars )

vars.idxInputs = false( sum( vars.areas, 2 ), 1 );
vars.idxInputsInd = false( sum( vars.areas, 2 ), length( vars.inputs ) );
ct1 = 0;
ct2 = 0;
for h = 1 : length( vars.areas )
    if ismember( h, vars.inputs )
        ct2 = ct2 + 1;
        vars.idxInputs( ct1 + [ 1 : vars.areas( h ) ], 1 ) = true;
        vars.idxInputsInd( ct1 + [ 1 : vars.areas( h ) ], ct2 ) = true;
    end
    ct1 = ct1 + vars.areas( h );
end

N_tr = floor( vars.infoStims_MI( 1 ) / ( vars.infoStims_MI( 2 ) + vars.infoStims_MI( 3 ) ) );
vars.classes = nan( 1, N_tr );
for tr = 1 : N_tr
    if length( vars.infoStims_MI ) == 5
        vars.classes( 1, tr ) = randperm( vars.infoStims_MI( 4 ), 1 );
    elseif length( vars.infoStims_MI ) >= 6
        vars.classes( 1, tr ) = vars.infoStims_MI( 6 );
    end
end

% vars.stims = [];
% for h = 1 : length( vars.inputs )
%
%     idxClass = false( vars.infoStims_MI( 4 ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
%     ct_c = 0;
%     for c = 1 : vars.infoStims_MI( 4 )
%         idxClass( c, ct_c + [ 1 : vars.infoStims_MI( 5 ) ] ) = true;
%         ct_c = ct_c + vars.infoStims_MI( 5 );
%     end
%
%     % gaussTunCurve = circshift( normpdf( linspace( -15, 15, vars.areas( vars.inputs( h ) ) ), 0, 0.25 ), -floor( vars.areas( vars.inputs( h ) ) / 2 ) );
%     gaussTunCurve = circshift( normpdf( linspace( -8, 8, vars.areas( vars.inputs( h ) ) ), 0, 0.25 ), -floor( vars.areas( vars.inputs( h ) ) / 2 ) );
%     egStim = ones( vars.areas( vars.inputs( h ) ), vars.infoStims_MI( 2 ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
%     for s = 1 : vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 )
%         egStim( :, :, s ) = repmat( transpose( circshift( gaussTunCurve, ( s - 1 ) * ( vars.areas( vars.inputs( h ) ) / ( vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) ) ) ) ), [ 1, vars.infoStims_MI( 2 ), 1 ] );
%     end
%     actTrend = [ linspace( 0, 1, round( vars.infoStims_MI( 2 ) / 2 ) ), linspace( 1, 0, vars.infoStims_MI( 2 ) - round( vars.infoStims_MI( 2 ) / 2 ) ) ];
%     egStim = egStim .* actTrend;
%     egStim = egStim + 1;
%     egStim = egStim ./ mean( egStim, 1 );
%
%
%     Stim = ones( vars.areas( vars.inputs( h ) ), vars.infoStims_MI( 1 ) );
%     ct_t = 0;
%     for tr = 1 : N_tr
%         idxStim = find( idxClass( vars.classes( tr ), : ) );
%         Stim( :, ct_t + [ 1 : vars.infoStims_MI( 2 ) ] ) = egStim( :, :, idxStim( randperm( vars.infoStims_MI( 5 ), 1 ) ) );
%         ct_t = ct_t + vars.infoStims_MI( 2 );
%         ct_t = ct_t + vars.infoStims_MI( 3 );
%     end
%
%     vars.stims = [ vars.stims; Stim ];
%
% end

vars.stims = [];
for h = 1 : length( vars.areas )

    if ismember( h, vars.inputs )

        idxClass = false( vars.infoStims_MI( 4 ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
        ct_c = 0;
        for c = 1 : vars.infoStims_MI( 4 )
            idxClass( c, ct_c + [ 1 : vars.infoStims_MI( 5 ) ] ) = true;
            ct_c = ct_c + vars.infoStims_MI( 5 );
        end

        % gaussTunCurve = circshift( normpdf( linspace( -15, 15, vars.areas( h ) ), 0, 0.25 ), -floor( vars.areas( h ) / 2 ) );
        gaussTunCurve = circshift( normpdf( linspace( -8, 8, vars.areas( h ) ), 0, 0.25 ), -floor( vars.areas( h ) / 2 ) );
        egStim = ones( vars.areas( h ), vars.infoStims_MI( 2 ), vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) );
        for s = 1 : vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 )
            egStim( :, :, s ) = repmat( transpose( circshift( gaussTunCurve, ( s - 1 ) * ( vars.areas( h ) / ( vars.infoStims_MI( 4 ) * vars.infoStims_MI( 5 ) ) ) ) ), [ 1, vars.infoStims_MI( 2 ), 1 ] );
        end
        actTrend = [ linspace( 0, 1, round( vars.infoStims_MI( 2 ) / 2 ) ), linspace( 1, 0, vars.infoStims_MI( 2 ) - round( vars.infoStims_MI( 2 ) / 2 ) ) ];
        egStim = egStim .* actTrend;
        egStim = egStim + 1;
        egStim = egStim ./ mean( egStim, 1 );


        Stim = ones( vars.areas( h ), vars.infoStims_MI( 1 ) );
        ct_t = 0;
        for tr = 1 : N_tr
            idxStim = find( idxClass( vars.classes( tr ), : ) );
            if length( vars.infoStims_MI ) <= 6
                Stim( :, ct_t + [ 1 : vars.infoStims_MI( 2 ) ] ) = egStim( :, :, idxStim( randperm( vars.infoStims_MI( 5 ), 1 ) ) );
            elseif length( vars.infoStims_MI ) == 7
                Stim( :, ct_t + [ 1 : vars.infoStims_MI( 2 ) ] ) = egStim( :, :, idxStim( vars.infoStims_MI( 7 ) ) );
            end
            ct_t = ct_t + vars.infoStims_MI( 2 );
            ct_t = ct_t + vars.infoStims_MI( 3 );
        end

    elseif ~ismember( h, vars.inputs )

        Stim = ones( vars.areas( h ), vars.infoStims_MI( 1 ) );

    end

    vars.stims = [ vars.stims; Stim ];

end
