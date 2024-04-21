% Analysis_Gated_Multichannel
clear; close all; clc



%% Figure 2A
%
% load( 'Simul1_0.mat' )
%
% vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars = GM_stimulation( vars );
%
% figure( 'position', [ 100, 100, 180, 250 ] )
% for ch = 1 : 5
%     subplot( 5, 1, ch )
%     imagesc( 1 : 100, 100 * ( ch - 1 ) + [ 1 : 100 ], vars.stims( 100 * ( ch - 1 ) + [ 1 : 100 ], 1 : 100 ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
% end; clear ch
%
% % figure( 'position', [ 100, 100, 250, 150 ] )
% % imagesc( nan, 1 + 0.5 * [ -1, 1 ] )
% % colormap( gca, turbo )
% % colorbar
%

%% Figure 2D
%
% % "kde.m" is avaliable at "https://kr.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator".
% % Zdravko Botev (2023). Kernel Density Estimator (https://www.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator), MATLAB Central File Exchange.
% N_points = 2 ^ 8;
% prod_domain = linspace( -1, 1, N_points );
%
% load( 'projMetricAlls_1_0.mat' )
% [ ~ , probProdProjAlls0, ~, ~ ] = kde( prodProjAlls0{ 1, 1 }, N_points, -1, 1 );
%
% load( 'projMetricAlls_1_3.mat' )
% t = size( prodProjAlls1, 2 );
% [ ~ , probProdProjAlls11, ~, ~ ] = kde( prodProjAlls1{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls12, ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls21, ~, ~ ] = kde( prodProjAlls2{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls22, ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
%
% load( 'projMetricAlls_1_3M.mat' )
% t = size( prodProjAlls1, 2 );
% [ ~ , probProdProjAlls11M, ~, ~ ] = kde( prodProjAlls1{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls12M, ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls21M, ~, ~ ] = kde( prodProjAlls2{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls22M, ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
%
% probProdProjAlls0 = probProdProjAlls0 / max( probProdProjAlls0, [], 1 );
% probProdProjAlls11 = probProdProjAlls11 / max( probProdProjAlls11, [], 1 );
% probProdProjAlls12 = probProdProjAlls12 / max( probProdProjAlls12, [], 1 );
% probProdProjAlls21 = probProdProjAlls21 / max( probProdProjAlls21, [], 1 );
% probProdProjAlls22 = probProdProjAlls22 / max( probProdProjAlls22, [], 1 );
%
% probProdProjAlls11M = probProdProjAlls11M / max( probProdProjAlls11M, [], 1 );
% probProdProjAlls12M = probProdProjAlls12M / max( probProdProjAlls12M, [], 1 );
% probProdProjAlls21M = probProdProjAlls21M / max( probProdProjAlls21M, [], 1 );
% probProdProjAlls22M = probProdProjAlls22M / max( probProdProjAlls22M, [], 1 );
%
% line_width = 2;
% colors = [ 192, 0, 0; 0, 112, 192 ] / 255;
%
% % Input
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls0, '-', 'linewidth', line_width, 'color', 'k' )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
%
% % Area 1; Gate closed
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls11, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls11M, '-', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
%
% % Area 1; Gate open
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls21, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls21M, '-', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
%
% % Area 2; Gate closed
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls12, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls12M, '-', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
%
% % Area 2; Gate open
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls22, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls22M, '-', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
%

%% Figure 2E
%
% load( 'Simul1_3_1000.mat' )
%
% vars.infoStims = [ ( 5 * 10 ) * ( 2 * 10 ) + 10, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars = GM_stimulation_instant( vars );
% vars = GM_simulation_Hebb( vars, 'plasticity_off', 'records_on' );
%
% nStims = size( vars.stimsChTs, 2 );
%
% N_unit_cumsum = cumsum( vars.areas, 2 );
% N_unit_whole = vars.areas( 3 );
%
% middle_acts = nan( N_unit_whole, nStims );
% middle_acts0 = nan( N_unit_whole, nStims );
% for t = 1 : nStims
%     middle_acts( :, t ) = vars.acts( N_unit_cumsum( 2 ) + 1 : N_unit_cumsum( 3 ), vars.stimsChTs( 2, t ) + round( vars.infoStims( 2 ) / 2 ) );
%     middle_acts0( :, t ) = vars.acts( N_unit_cumsum( 2 ) + 1 : N_unit_cumsum( 3 ), vars.stimsChTs( 2, t ) + round( vars.infoStims( 2 ) / 2 ) - vars.infoStims( 2 ) );
% end
%
% accDecoding = [];% decoding accuracy: [ 0, 1 ]
% for ch1 = 1 : 5
%     for ch2 = 1 : 5
%
%         data_1 = transpose( middle_acts( :, vars.stimsChTs( 1, : ) == ch1 ) );
%         idx_1 = 1 * ones( sum( vars.stimsChTs( 1, : ) == ch1, 2 ), 1 );
%         data_2 = transpose( middle_acts0( :, vars.stimsChTs( 1, : ) == ch2 ) );
%         idx_2 = 2 * ones( sum( vars.stimsChTs( 1, : ) == ch2, 2 ), 1 );
%
%         Mdl1 = fitcecoc( data_1, idx_1 );% linear SVM
%         Mdl2 = fitcecoc( data_2, idx_2 );% linear SVM
%
%         if ch1 == ch2
%             CVMdl1 = crossval( Mdl1 );
%             accDecoding( ch1, ch2 ) = 1 - kfoldLoss( CVMdl1 );
%         else
%             idx_out = predict( Mdl1, data_2 );
%             accDecoding( ch1, ch2 ) = mean( idx_out == idx_2, 1 );
%         end
%
%     end
% end
%
% figure( 'position', [ 100, 100, 100, 100 ] )
% imagesc( accDecoding, [ 0, 1 ] )
% colormap( gca, spring )
% axis image
% axis xy
% set( gca, 'xtick', [ 1 : 5 ], 'ytick', [ 1 : 5 ] )
% ylabel( 'Channel' )
% xlabel( 'Channel' )
%
% % figure( 'position', [ 100, 100, 100, 100 ] )
% % imagesc( nan, [ 0, 1 ] )
% % colormap( gca, spring )
% % colorbar( 'TickLabels', {} )
%

%% Figure 2F
%
% load( 'Simul1_3_1000.mat' )
%
% unit = 1;
% ch1 = 1;
% ch2 = 2;
%
% vars.infoStims = [ ( 5 * 10 ) * ( 2 * 10 ) + 10, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% % vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars = GM_stimulation_instant( vars );
% vars = GM_simulation_Hebb( vars, 'plasticity_off', 'records_on' );
%
% nStims = size( vars.stimsChTs, 2 );
%
% N_unit_cumsum = cumsum( vars.areas, 2 );
% N_unit_whole = vars.areas( 3 );
%
% middle_acts = nan( N_unit_whole, nStims );
% for t = 1 : nStims
%     middle_acts( :, t ) = vars.acts( N_unit_cumsum( 2 ) + 1 : N_unit_cumsum( 3 ), vars.stimsChTs( 2, t ) + round( vars.infoStims( 2 ) / 2 ) );
% end
%
% neuronalRes1_c = middle_acts( unit, vars.stimsChTs( 1, : ) == ch1 );
% neuronalRes2_c = middle_acts( unit, vars.stimsChTs( 1, : ) == ch2 );
%
% vars.infoStims = [ ( 5 * 10 ) * ( 2 * 10 ) + 10, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars = GM_stimulation_instant( vars );
% vars = GM_simulation_Hebb( vars, 'plasticity_off', 'records_on' );
%
% nStims = size( vars.stimsChTs, 2 );
%
% N_unit_cumsum = cumsum( vars.areas, 2 );
% N_unit_whole = vars.areas( 3 );
%
% middle_acts = nan( N_unit_whole, nStims );
% for t = 1 : nStims
%     middle_acts( :, t ) = vars.acts( N_unit_cumsum( 2 ) + 1 : N_unit_cumsum( 3 ), vars.stimsChTs( 2, t ) + round( vars.infoStims( 2 ) / 2 ) );
% end
%
% neuronalRes1_o = middle_acts( unit, vars.stimsChTs( 1, : ) == ch1 );
% neuronalRes2_o = middle_acts( unit, vars.stimsChTs( 1, : ) == ch2 );
%
% figure( 'position', [ 100, 100, 150, 120 ] )
% hold on
% plot( neuronalRes1_c, '-', 'color', 'm', 'linewidth', 2 )
% plot( neuronalRes1_o, ':', 'color', 'g', 'linewidth', 2 )
% plot( [ 1, 10 ], [ 1, 1 ], ':k', 'linewidth', 1 )
% set( gca, 'xlim', [ 0.5, 10.5 ], 'ylim', 1 + 0.004 * [ -1, 1 ] )
% set( gca, 'ytick', [] )
% ylabel( 'Neural activity' )
% xlabel( 'Stimulus' )
%
% figure( 'position', [ 100, 100, 150, 120 ] )
% hold on
% plot( neuronalRes2_c, '-', 'color', 'm', 'linewidth', 2 )
% plot( neuronalRes2_o, ':', 'color', 'g', 'linewidth', 2 )
% plot( [ 1, 10 ], [ 1, 1 ], ':k', 'linewidth', 1 )
% set( gca, 'xlim', [ 0.5, 10.5 ], 'ylim', 1 + 0.000006 * [ -1, 1 ] )
% set( gca, 'ytick', [] )
% ylabel( 'Neural activity' )
% xlabel( 'Stimulus' )
%

%% Figure 3
%
% xticklabels_1 = cell( 1, 5 );
% for ct_fn = 1 : 5
%     xticklabels_1{ 1, ct_fn } = [ 'Gate ' , num2str( ( ct_fn - 1 ) * 25 ), '% open during learning' ];
% end; clear ct_fn
% xticklabels_1{ 1, 6 } = [ 'Non-separated connection' ];
%
%
% % "kde.m" is avaliable at "https://kr.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator".
% % Zdravko Botev (2023). Kernel Density Estimator (https://www.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator), MATLAB Central File Exchange.
% N_points = 2 ^ 8;
% prod_domain = linspace( -1, 1, N_points );
%
%
% flist_1 = dir( 'projMetricAlls_1_?.mat' );
%
% probProdProjAlls12_1 = [];
% probProdProjAlls22_1 = [];
% poolProjMetricAlls12_1 = [];
% poolProjMetricAlls22_1 = [];
% ct_fn = 0;
% for fn = 2 : 7
%     ct_fn = ct_fn + 1;
%
%     if fn <= 6
%         fname = flist_1( fn, 1 ).name;
%     else
%         fname = flist_1( 4, 1 ).name;
%         fname = [ fname( 1 : end - 4 ), 'M.mat' ];
%     end
%
%     load( fname )
%
%     t = size( prodProjAlls1, 2 );
%     [ ~ , probProdProjAlls12_1( :, ct_fn ), ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
%     [ ~ , probProdProjAlls22_1( :, ct_fn ), ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
%     poolProjMetricAlls12_1( :, ct_fn ) = projMetricAlls1{ 2, t };
%     poolProjMetricAlls22_1( :, ct_fn ) = projMetricAlls2{ 2, t };
%     clear fname
%
% end; clear fn ct_fn
%
% probProdProjAlls12_1 = probProdProjAlls12_1 ./ max( probProdProjAlls12_1, [], 1 );
% probProdProjAlls22_1 = probProdProjAlls22_1 ./ max( probProdProjAlls22_1, [], 1 );
%
%
% flist_2 = dir( 'projMetricAlls_2_?.mat' );
%
% probProdProjAlls12_2 = [];
% probProdProjAlls22_2 = [];
% ct_fn = 0;
% for fn = 1 : 5
%     ct_fn = ct_fn + 1;
%
%     fname = flist_2( fn, 1 ).name;
%
%     load( fname )
%
%     t = size( prodProjAlls1, 2 );
%     [ ~ , probProdProjAlls12_2( :, ct_fn ), ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
%     [ ~ , probProdProjAlls22_2( :, ct_fn ), ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
%     clear fname
%
% end; clear fn ct_fn
%
% probProdProjAlls12_2 = probProdProjAlls12_2 ./ max( probProdProjAlls12_2, [], 1 );
% probProdProjAlls22_2 = probProdProjAlls22_2 ./ max( probProdProjAlls22_2, [], 1 );
%
%
% xRangeM = 1;
% xRangeP = 0.15 * [ -1, 1 ];
% markersize_pts = 1;
% linewidth_line = 2;
% color_pts = [ 0, 0, 0 ];
% color_line = [ 1, 0, 1; 0, 1, 0 ];
%
% for ct_fn = 1 : 5
%     figure( 'position', [ 100, 100, 100, 80 ] )
%     hold on
%     plot( prod_domain, probProdProjAlls12_1( :, ct_fn ), '-', 'linewidth', linewidth_line, 'color', color_line( 1, : ) )
%     plot( prod_domain, probProdProjAlls22_1( :, ct_fn ), ':', 'linewidth', linewidth_line, 'color', color_line( 2, : ) )
%     set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% end; clear ct_fn
%
% figure( 'position', [ 100, 100, 500, 250 ] )
% hold on
% for ct_fn = 1 : 6
%     fct_boxplot( poolProjMetricAlls12_1( :, ct_fn ), ct_fn - 0.2 + xRangeP, markersize_pts, linewidth_line, color_pts, color_line( 1, : ) )
%     fct_boxplot( poolProjMetricAlls22_1( :, ct_fn ), ct_fn + 0.2 + xRangeP, markersize_pts, linewidth_line, color_pts, color_line( 2, : ) )
% end; clear ct_fn
% % set( gca, 'ylim', [ 1, 2.2 ], 'xlim', [ 0.5, 5.5 ] )
% % set( gca, 'xtick', [ 1 : 5 ], 'xticklabel', xticklabels_1, 'XTickLabelRotation', 15 )
% set( gca, 'ylim', [ 0, 2.2 ], 'xlim', [ 0.5, 6.5 ] )
% set( gca, 'xtick', [ 1 : 6 ], 'xticklabel', xticklabels_1, 'XTickLabelRotation', 15 )
% pVals = [];
% for ct_fn = 1 : 5
%     pVals( ct_fn, 1 ) = ranksum( poolProjMetricAlls12_1( :, ct_fn ), poolProjMetricAlls12_1( :, 6 ), 'tail', 'right' );
%     pVals( ct_fn, 2 ) = ranksum( poolProjMetricAlls22_1( :, ct_fn ), poolProjMetricAlls22_1( :, 6 ), 'tail', 'right' );
% end; clear ct_fn
% pVals( :, 1 ) = mafdr( pVals( :, 1 ), 'BHFDR', 'true' );
% pVals( :, 2 ) = mafdr( pVals( :, 2 ), 'BHFDR', 'true' );
%
% for ct_fn = 1 : 5
%     figure( 'position', [ 100, 100, 100, 80 ] )
%     hold on
%     plot( prod_domain, probProdProjAlls12_2( :, ct_fn ), '-', 'linewidth', linewidth_line, 'color', color_line( 1, : ) )
%     plot( prod_domain, probProdProjAlls22_2( :, ct_fn ), ':', 'linewidth', linewidth_line, 'color', color_line( 2, : ) )
%     set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% end; clear ct_fn
%
%
% flist_2_c1 = dir( 'projMetricAlls_2_c?.mat' );
%
% probProdProjAlls12_3 = [];
% probProdProjAlls22_3 = [];
% ct_fn = 0;
% for fn = 1 : 2
%     ct_fn = ct_fn + 1;
%
%     fname = flist_2( fn, 1 ).name;
%
%     load( fname )
%
%     t = size( prodProjAlls1, 2 );
%     [ ~ , probProdProjAlls12_3( :, ct_fn ), ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
%     [ ~ , probProdProjAlls22_3( :, ct_fn ), ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
%     clear fname
%
% end; clear fn ct_fn
%
% probProdProjAlls12_3 = probProdProjAlls12_3 ./ max( probProdProjAlls12_3, [], 1 );
% probProdProjAlls22_3 = probProdProjAlls22_3 ./ max( probProdProjAlls22_3, [], 1 );
%
%
% for ct_fn = 1 : 2
%     figure( 'position', [ 100, 100, 100, 80 ] )
%     hold on
%     plot( prod_domain, probProdProjAlls12_3( :, ct_fn ), '-', 'linewidth', linewidth_line, 'color', color_line( 1, : ) )
%     plot( prod_domain, probProdProjAlls22_3( :, ct_fn ), ':', 'linewidth', linewidth_line, 'color', color_line( 2, : ) )
%     set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% end; clear ct_fn
%

%% Figure 4C and 5A
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, [ 0, 5 * ( 10 ^ ( -3 ) ) ] )
% % colorbar
% 
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, 1 + 0.5 * [ -1, 1 ] )
% % colormap( gca, turbo )
% % colorbar
% 
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, 1 + 0.001 * [ -1, 1 ] )
% % colormap( gca, turbo )
% % colorbar
% 
% 
% load( 'Simul3_1_1000.mat' )
% 
% figure( 'position', [ 100, 100, 300, 300 ] )
% imagesc( vars.weights( 1001 : 1100, 1 : 500 ), [ 0, 5 * ( 10 ^ ( -3 ) ) ] )
% 
% 
% % acts = cell( 2, 1 );
% % for c = 1 : 2
% %     for iter = 1 : 100
% %
% %         vars0 = vars;
% %         % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% %         vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% %         % vars.inputs = [ 1, 2 ];% in areas
% %         % vars0.inputs = [ 1 ];% in areas
% %         vars0.infoStims_MI = [ 15, 10, 2, 5, 10, c ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
% %         vars0 = GM_stimulation_MI( vars0 );
% %         vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% %
% %         acts{ c, 1 }( :, :, iter) = vars0.acts;
% %         clear vars0
% %
% %         disp( iter )
% %
% %     end; clear iter
% % end; clear c
% % save( 'findTLNc12_0.mat', 'acts' )
% % load( 'findTLNc12_0.mat' )
% % TLNc12_S = [];
% % TLNc12_C = [];
% % for c = 1 : 2
% %     val = mean( acts{ c, 1 }( 1001 : 1500, 6, : ), 3 );
% %     [ ~, sort_idx ] = sort( val, 'descend' );
% %     sort_idx = sort( sort_idx( 1 : 100 ), 'ascend' );
% %     TLNc12_S = [ TLNc12_S, transpose( sort_idx ) ];
% %     clear val sort_idx
% %     val = mean( acts{ c, 1 }( 1501 : 2000, 6, : ), 3 );
% %     [ ~, sort_idx ] = sort( val, 'descend' );
% %     sort_idx = sort( sort_idx( 1 : 100 ), 'ascend' );
% %     TLNc12_C = [ TLNc12_C, transpose( sort_idx ) ];
% %     clear val sort_idx
% % end; clear c
% % save( 'findTLNc12_0.mat', 'acts', 'TLNc12_S', 'TLNc12_C' )
% 
% 
% load( 'Simul3_3_1000.mat' )
% 
% figure( 'position', [ 100, 100, 300, 300 ] )
% imagesc( vars.weights( 1001 : 1100, 1 : 500 ), [ 0, 5 * ( 10 ^ ( -3 ) ) ] )
% 
% 
% % acts = cell( 2, 1 );
% % for c = 1 : 2
% %     for iter = 1 : 100
% %
% %         vars0 = vars;
% %         % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% %         vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% %         % vars.inputs = [ 1, 2 ];% in areas
% %         % vars0.inputs = [ 1 ];% in areas
% %         vars0.infoStims_MI = [ 15, 10, 2, 5, 10, c ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
% %         vars0 = GM_stimulation_MI( vars0 );
% %         vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% %
% %         acts{ c, 1 }( :, :, iter) = vars0.acts;
% %         clear vars0
% %
% %         disp( iter )
% %
% %     end; clear iter
% % end; clear c
% % save( 'findTLNc12.mat', 'acts' )
% % load( 'findTLNc12.mat' )
% % TLNc12_S = [];
% % TLNc12_C = [];
% % for c = 1 : 2
% %     val = mean( acts{ c, 1 }( 1001 : 1500, 6, : ), 3 );
% %     [ ~, sort_idx ] = sort( val, 'descend' );
% %     sort_idx = sort( sort_idx( 1 : 100 ), 'ascend' );
% %     TLNc12_S = [ TLNc12_S, transpose( sort_idx ) ];
% %     clear val sort_idx
% %     val = mean( acts{ c, 1 }( 1501 : 2000, 6, : ), 3 );
% %     [ ~, sort_idx ] = sort( val, 'descend' );
% %     sort_idx = sort( sort_idx( 1 : 100 ), 'ascend' );
% %     TLNc12_C = [ TLNc12_C, transpose( sort_idx ) ];
% %     clear val sort_idx
% % end; clear c
% % save( 'findTLNc12.mat', 'acts', 'TLNc12_S', 'TLNc12_C' )
% 
% 
% load( 'findTLNc12_0.mat' )
% load( 'Simul3_1_1000.mat' )
% for iter = [ 1, 1, 2, 2 ]
% 
%     vars0 = vars;
%     % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     % vars.inputs = [ 1, 2 ];% in areas
%     % vars0.inputs = [ 1 ];% in areas
%     vars0.infoStims_MI = [ 15, 10, 2, 5, 10, iter ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars0 = GM_stimulation_MI( vars0 );
%     vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% 
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 0 + [ 1 : 200 ], : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1000 + TLNc12_S, : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1500 + TLNc12_C, : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 500 + [ 1 : 200 ], : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
% 
% end; clear iter
% 
% 
% load( 'findTLNc12.mat' )
% load( 'Simul3_3_1000.mat' )
% for iter = [ 1, 1, 2, 2 ]
% 
%     vars0 = vars;
%     % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     % vars.inputs = [ 1, 2 ];% in areas
%     % vars0.inputs = [ 1 ];% in areas
%     vars0.infoStims_MI = [ 15, 10, 2, 5, 10, iter ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars0 = GM_stimulation_MI( vars0 );
%     vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% 
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 0 + [ 1 : 200 ], : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1000 + TLNc12_S, : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1500 + TLNc12_C, : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 500 + [ 1 : 200 ], : ), 1 + 0.5 * [ -1, 1 ] )
%     colormap( gca, turbo )
% 
% end; clear iter
% 
% 
% load( 'findTLNc12.mat' )
% load( 'Simul3_0.mat' )
% for iter = [ 1 ]
% 
%     vars0 = vars;
%     vars0.eta = 0.001 * 2 * 5;% learning rate
%     % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.inputs = [ 1, 2 ];% in areas
%     % vars0.inputs = [ 1 ];% in areas
%     vars0.infoStims_MI = [ 15, 10, 2, 5, 10, iter ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars0 = GM_stimulation_MI( vars0 );
%     vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% 
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 0 + [ 1 : 200 ], : ), 1 + 0.001 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1000 + TLNc12_S, : ), 1 + 0.001 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 1500 + TLNc12_C, : ), 1 + 0.001 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 30, 100 ] )
%     imagesc( vars0.acts( 500 + [ 1 : 200 ], : ), 1 + 0.001 * [ -1, 1 ] )
%     colormap( gca, turbo )
% 
% end; clear iter
% 

%% Figure S2
%
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, 1 + 0.3 * [ -1, 1 ] )
% % colormap( gca, turbo )
% % colorbar
%
% load( 'Simul3_3_1000.mat' )
%
% for iter = [ 1, 1, 2, 2 ]
%
%     vars0 = vars;
%     % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     % vars.inputs = [ 1, 2 ];% in areas
%     vars0.inputs = [ 1 ];% in areas
%     vars0.infoStims_MI = [ 15, 10, 2, 5, 10, iter ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars0 = GM_stimulation_MI( vars0 );
%     vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
%
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( vars0.acts( 0 + [ 1 : 200 ], : ), 1 + 0.3 * [ -1, 1 ] )
%     colormap( gca, turbo )
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( vars0.acts( 500 + [ 1 : 200 ], : ), 1 + 0.3 * [ -1, 1 ] )
%     colormap( gca, turbo )
%
% end; clear iter
%

%% Figure 5D
% 
% load( 'findTLNc12.mat' )
% load( 'Simul3_3_1000.mat' )
% 
% 
% unit_sensory = 1;
% unit_temporal = 1;
% 
% neuralRes1 = [];
% neuralRes2 = [];
% ct_stim = 0;
% for cl = 1 : 2
%     for stim = 1 : 10
%         ct_stim = ct_stim + 1;
% 
%         vars0 = vars;
%         % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         % vars.inputs = [ 1, 2 ];% in areas
%         % vars0.inputs = [ 1 ];% in areas
%         vars0.infoStims_MI = [ 15, 10, 2, 5, 10, cl, stim ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%         vars0 = GM_stimulation_MI( vars0 );
%         vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% 
%         neuralRes1( ct_stim, 1 ) = vars0.acts( 0 + unit_sensory, 5 );
%         neuralRes2( ct_stim, 1 ) = vars0.acts( 1000 + TLNc12_S( unit_temporal ), 5 );
% 
%     end; clear stim
% end; clear cl
% 
% figure( 'position', [ 100, 100, 150, 50 ] )
% hold on
% plot( [ 1 : 10 ], neuralRes1( 1 : 10 ), '-ok', 'markerfacecolor', 'r' )
% plot( [ 11 : 20 ], neuralRes1( 11 : 20 ), '-ok', 'markerfacecolor', 'b' )
% plot( [ 1, 20 ], [ 1, 1 ], ':k' )
% set( gca, 'xlim', [ 0.5, 20.5 ], 'ylim', [ 0.8, 2.6 ], 'xtick', [] )
% 
% figure( 'position', [ 100, 100, 150, 50 ] )
% hold on
% plot( [ 1 : 10 ], neuralRes2( 1 : 10 ), '-ok', 'markerfacecolor', 'r' )
% plot( [ 11 : 20 ], neuralRes2( 11 : 20 ), '-ok', 'markerfacecolor', 'b' )
% plot( [ 1, 20 ], [ 1, 1 ], ':k' )
% set( gca, 'xlim', [ 0.5, 20.5 ], 'ylim', [ 0.9, 1.3 ], 'xtick', [] )
% 
% 
% unit_choice = 190;
% unit_temporal = 190;
% 
% neuralRes1 = [];
% neuralRes2 = [];
% ct_stim = 0;
% for cl = 1 : 2
%     for stim = 1 : 10
%         ct_stim = ct_stim + 1;
% 
%         vars0 = vars;
%         % vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         % vars.inputs = [ 1, 2 ];% in areas
%         % vars0.inputs = [ 1 ];% in areas
%         vars0.infoStims_MI = [ 15, 10, 2, 5, 10, cl, stim ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%         vars0 = GM_stimulation_MI( vars0 );
%         vars0 = GM_simulation_Hebb_MI_GPU( vars0, 'plasticity_off' );
% 
%         neuralRes1( ct_stim, 1 ) = vars0.acts( 0 + unit_choice, 5 );
%         neuralRes2( ct_stim, 1 ) = vars0.acts( 1500 + TLNc12_C( unit_temporal ), 5 );
% 
%     end; clear stim
% end; clear cl
% 
% figure( 'position', [ 100, 100, 150, 50 ] )
% hold on
% plot( [ 1 : 10 ], neuralRes1( 1 : 10 ), '-ok', 'markerfacecolor', 'r' )
% plot( [ 11 : 20 ], neuralRes1( 11 : 20 ), '-ok', 'markerfacecolor', 'b' )
% plot( [ 1, 20 ], [ 1, 1 ], ':k' )
% set( gca, 'xlim', [ 0.5, 20.5 ], 'ylim', [ 0.8, 2.6 ], 'xtick', [] )
% 
% figure( 'position', [ 100, 100, 150, 50 ] )
% hold on
% plot( [ 1 : 10 ], neuralRes2( 1 : 10 ), '-ok', 'markerfacecolor', 'r' )
% plot( [ 11 : 20 ], neuralRes2( 11 : 20 ), '-ok', 'markerfacecolor', 'b' )
% plot( [ 1, 20 ], [ 1, 1 ], ':k' )
% set( gca, 'xlim', [ 0.5, 20.5 ], 'ylim', [ 0.9, 1.3 ], 'xtick', [] )
% 
