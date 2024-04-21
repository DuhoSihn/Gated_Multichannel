% Analysis_Gated_Multichannel
clear; close all; clc



%% Figure S1
% 
% load( 'SNN_Simul1_3_1000.mat' )
% 
% vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
% vars.inputs = [ 1 ];% in area
% vars = GM_SNN_stimulation( vars );
% [ vars, records ] = GM_SNN_simulation_GPU( vars, 'plasticity_off', 'records_on' );
% 
% dt = 100;% ms
% dur = 10000;% ms
% tranMat = zeros( ( dur / vars.dt ), ( dur / vars.dt ) / dt );
% ct_dt = 0;
% for t = 1 : ( dur / vars.dt ) / dt
%     tranMat( ct_dt + [ 1 : dt ], t ) = 1;
%     ct_dt = ct_dt + dt;
% end; clear t
% tranMat = tranMat * ( 1000 / dt );
% 
% s_E = records.s_E( :, [ 1 : ( dur / vars.dt ) ] ) * tranMat;
% 
% 
% figure( 'position', [ 100, 100, 180, 250 ] )
% for ch = 1 : 5
%     subplot( 5, 1, ch )
%     imagesc( linspace( 0, 10000, 200 ), 100 * ( ch - 1 ) + [ 1 : 100 ], s_E( 0 * 500 + 100 * ( ch - 1 ) + [ 1 : 100 ], 1 : 200 ), [ 0, 50 ] )
%     colormap( gca, hot )
% end; clear ch
% 
% figure( 'position', [ 100, 100, 180, 250 ] )
% for ch = 1 : 5
%     subplot( 5, 1, ch )
%     imagesc( linspace( 0, 10000, 200 ), 100 * ( ch - 1 ) + [ 1 : 100 ], s_E( 1 * 500 + 100 * ( ch - 1 ) + [ 1 : 100 ], 1 : 200 ), [ 0, 50 ] )
%     colormap( gca, hot )
% end; clear ch
% 
% figure( 'position', [ 100, 100, 180, 250 ] )
% for ch = 1 : 5
%     subplot( 5, 1, ch )
%     imagesc( linspace( 0, 10000, 200 ), 100 * ( ch - 1 ) + [ 1 : 100 ], s_E( 2 * 500 + 100 * ( ch - 1 ) + [ 1 : 100 ], 1 : 200 ), [ 0, 50 ] )
%     colormap( gca, hot )
% end; clear ch
% 
% % -------------------------------------------------------------------------
% 
% % "kde.m" is avaliable at "https://kr.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator".
% % Zdravko Botev (2023). Kernel Density Estimator (https://www.mathworks.com/matlabcentral/fileexchange/14034-kernel-density-estimator), MATLAB Central File Exchange.
% N_points = 2 ^ 8;
% prod_domain = linspace( -1, 1, N_points );
% 
% load( 'SNN_projMetricAlls_1_3.mat' )
% t = size( prodProjAlls1, 2 );
% [ ~ , probProdProjAlls11, ~, ~ ] = kde( prodProjAlls1{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls12, ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls13, ~, ~ ] = kde( prodProjAlls1{ 3, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls21, ~, ~ ] = kde( prodProjAlls2{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls22, ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls23, ~, ~ ] = kde( prodProjAlls2{ 3, t }, N_points, -1, 1 );
% 
% load( 'SNN_projMetricAlls_1_3M.mat' )
% t = size( prodProjAlls1, 2 );
% [ ~ , probProdProjAlls11M, ~, ~ ] = kde( prodProjAlls1{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls12M, ~, ~ ] = kde( prodProjAlls1{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls13M, ~, ~ ] = kde( prodProjAlls1{ 3, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls21M, ~, ~ ] = kde( prodProjAlls2{ 1, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls22M, ~, ~ ] = kde( prodProjAlls2{ 2, t }, N_points, -1, 1 );
% [ ~ , probProdProjAlls23M, ~, ~ ] = kde( prodProjAlls2{ 3, t }, N_points, -1, 1 );
% 
% probProdProjAlls11 = probProdProjAlls11 / max( probProdProjAlls11, [], 1 );
% probProdProjAlls12 = probProdProjAlls12 / max( probProdProjAlls12, [], 1 );
% probProdProjAlls13 = probProdProjAlls13 / max( probProdProjAlls13, [], 1 );
% probProdProjAlls22 = probProdProjAlls22 / max( probProdProjAlls22, [], 1 );
% probProdProjAlls23 = probProdProjAlls23 / max( probProdProjAlls23, [], 1 );
% 
% probProdProjAlls12M = probProdProjAlls12M / max( probProdProjAlls12M, [], 1 );
% probProdProjAlls13M = probProdProjAlls13M / max( probProdProjAlls13M, [], 1 );
% probProdProjAlls22M = probProdProjAlls22M / max( probProdProjAlls22M, [], 1 );
% probProdProjAlls23M = probProdProjAlls23M / max( probProdProjAlls23M, [], 1 );
% 
% line_width = 2;
% colors = [ 192, 0, 0; 0, 112, 192 ] / 255;
% 
% % Input
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls11, '-', 'linewidth', line_width, 'color', 'k' )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% 
% % Area 1; Gate closed
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls12, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls12M, ':', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% 
% % Area 1; Gate open
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls22, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls22M, ':', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% 
% % Area 2; Gate closed
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls13, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls13M, ':', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% 
% % Area 2; Gate open
% figure( 'position', [ 100, 100, 100, 80 ] )
% hold on
% plot( prod_domain, probProdProjAlls23, '-', 'linewidth', line_width, 'color', colors( 1, : ) )
% plot( prod_domain, probProdProjAlls23M, ':', 'linewidth', line_width, 'color', colors( 2, : ) )
% set( gca, 'xlim', [ -1, 1 ], 'ylim', [ 0, 1 ], 'ytick', [] )
% 

%% Figure S3
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, [ 0, 20 ] )
% % colorbar
% 
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, [ 0, 1 ] )
% % colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
% % colorbar( 'ticks', [ 0, 1 ], 'ticklabels', { 'Empty', 'Spike' } )
% 
% 
% % figure( 'position', [ 100, 100, 200, 80 ] )
% % imagesc( nan, [ 0, 50 ] )
% % colormap( gca, hot )
% % colorbar
% 
% 
% load( 'SNN_Simul3_0.mat' )
% 
% figure( 'position', [ 100, 100, 300, 300 ] )
% imagesc( vars.J_EE( 1001 : 1500, 1 : 500 ), [ 0, 20 ] )
% 
% 
% load( 'SNN_Simul3_3_100.mat' )
% 
% figure( 'position', [ 100, 100, 300, 300 ] )
% imagesc( vars.J_EE( 1001 : 1500, 1 : 500 ), [ 0, 20 ] )
% 
% 
% dt = 100;% ms
% dur = 1000;% ms
% tranMat = zeros( ( dur / vars.dt ), ( dur / vars.dt ) / dt );
% ct_dt = 0;
% for t = 1 : ( dur / vars.dt ) / dt
%     tranMat( ct_dt + [ 1 : dt ], t ) = 1;
%     ct_dt = ct_dt + dt;
% end; clear t
% tranMat = tranMat * ( 1000 / dt );
% 
% 
% for iter = [ 1, 1, 2, 2 ]
% 
%     vars0 = vars;
%     vars0.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars0.inputs = [ 1, 2 ];% in areas
%     % vars0.inputs = [ 1 ];% in areas
%     % vars0.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars0.infoStims_MI = [ 1500, 1000, 200, 5, 10, iter ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars0 = GM_SNN_stimulation_MI( vars0 );
%     [ vars0, records0 ] = GM_SNN_simulation_GPU( vars0, 'plasticity_off', 'records_on' );
% 
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 0 + [ 1 : 200 ], [ 1 : 2000 ] ), [ 0, 1 ] )
%     colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 1500 + [ 1 : 200 ], [ 1 : 2000 ] ), [ 0, 1 ] )
%     colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 500 + [ 1 : 200 ], [ 1 : 2000 ] ), [ 0, 1 ] )
%     colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
% 
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 0 + [ 1 : 200 ], [ 1 : ( dur / vars.dt ) ] ) * tranMat, [ 0, 50 ] )
%     % colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
%     colormap( gca, hot )
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 1500 + [ 1 : 200 ], [ 1 : ( dur / vars.dt ) ] ) * tranMat, [ 0, 50 ] )
%     % colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
%     colormap( gca, hot )
%     figure( 'position', [ 100, 100, 50, 100 ] )
%     imagesc( [ 0.5 : 0.5 : 1000 ], [ 1 : 200 ], records0.s_E( 500 + [ 1 : 200 ], [ 1 : ( dur / vars.dt ) ] ) * tranMat, [ 0, 50 ] )
%     % colors = colormap( gray( 2 ) ); colormap( gca, flipud( colors ) )
%     colormap( gca, hot )
% 
% end; clear iter
% 
