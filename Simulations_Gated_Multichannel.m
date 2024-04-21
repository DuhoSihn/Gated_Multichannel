% Simulations_Gated_Multichannel
clear; close all; clc



%% Simul1_0
% 
% clear vars
% 
% vars.t_memory = 1;% time steps
% vars.eta = 0.001;% learning rate
% vars.period = 200;% period of synaptic scaling & adjustment of lateral competition level
% 
% vars.areas = [ 500, 500, 500 ];% the number of units in each area
% vars.inputs = [ 1 ];% in areas
% 
% vars.connScale = [ 1, 1, 4 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.areas ), length( vars.areas ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 2, 1 ) = vars.connScale( 1 ) * vars.areas( 1 );
% vars.connects( 1, 2 ) = vars.connScale( 2 ) * vars.areas( 2 );
% vars.connects( 2, 2 ) = vars.connScale( 3 ) * vars.areas( 2 );
% vars.connects( 3, 2 ) = vars.connScale( 1 ) * vars.areas( 2 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.areas( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% 
% vars.actScale = 0.5 * [ 1, 1, 1 ];% initial lateral inhibition level
% vars.actScaleThr = 1.4 * [ 1, 1, 1 ];% upper threshold of lateral inhibition level
% vars.actThr = 100 * [ 1, 1, 1 ] ./ vars.actScale;% neural activity upper threshold
% vars.actMax = 2.5 * [ 1, 1, 1 ];% target maximum neural activity
% vars.eta_actScale = 0.001;% learning rate for actScale
% 
% vars.actTemp = [];
% vars.actMean = [];
% 
% vars.nChannels = 5;% the number of channels
% vars = GM_initiation( vars );
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% save( 'Simul1_0.mat', 'vars' )
% clear vars
% 

%% Simul1_0M
% 
% clear vars
% 
% vars.t_memory = 1;% time steps
% vars.eta = 0.001 * 5;% learning rate
% vars.period = 200;% period of synaptic scaling & adjustment of lateral competition level
% 
% vars.areas = [ 500, 500, 500 ];% the number of units in each area
% vars.inputs = [ 1 ];% in areas
% 
% vars.connScale = [ 1, 1, 1 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.areas ), length( vars.areas ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 2, 1 ) = vars.connScale( 1 ) * vars.areas( 1 );
% vars.connects( 1, 2 ) = vars.connScale( 2 ) * vars.areas( 2 );
% vars.connects( 2, 2 ) = vars.connScale( 3 ) * vars.areas( 2 );
% vars.connects( 3, 2 ) = vars.connScale( 1 ) * vars.areas( 2 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.areas( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% 
% vars.actScale = 0.5 * [ 1, 1, 1 ];% initial lateral inhibition level
% vars.actScaleThr = 1.4 * [ 1, 1, 1 ];% upper threshold of lateral inhibition level
% vars.actThr = 100 * [ 1, 1, 1 ] ./ vars.actScale;% neural activity upper threshold
% vars.actMax = 2.5 * [ 1, 1, 1 ];% target maximum neural activity
% vars.eta_actScale = 0.001;% learning rate for actScale
% 
% vars.actTemp = [];
% vars.actMean = [];
% 
% vars.nChannels = 1;% the number of channels
% vars = GM_initiation( vars );
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% save( 'Simul1_0M.mat', 'vars' )
% clear vars
% 

%% Simul1_1
% 
% load( 'Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_1_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_1_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_1M
% 
% load( 'Simul1_0M.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_1M_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_1M_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_2
% 
% load( 'Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_2_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_2_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_3
% 
% load( 'Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_3_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_3_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_3M
% 
% load( 'Simul1_0M.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 25;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_3M_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_3M_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_4
% 
% load( 'Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_4_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_4_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul1_5
% 
% load( 'Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul1_5_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul1_5_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_1
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_1_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_1_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_2
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-2) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_2_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_2_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_3
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-3) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_3_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_3_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_4
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-4) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_4_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_4_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_5
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_5_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_5_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_c1
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10 ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction_c1( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_c1_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_c1_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul2_c2
% 
% load( 'Simul1_0.mat' )
% 
% 
% vars.infoStims = [ 1000, 10, 0.05, 5, 10 ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_define_interaction_c2( vars );
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     vars.eta = 0.001 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars = GM_stimulation( vars );
%     vars = GM_simulation_Hebb_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul2_c2_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul2_c2_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% projMetricAlls_1_0
% 
% N_iter = 10;
% projMetricAlls0 = cell( 1, 1 );
% prodProjAlls0 = cell( 1, 1 );
% 
% fname = 'Simul1_0.mat';
% 
% for iter = 1 : N_iter
%     load( fname )
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%     vars = GM_stimulation_distProj_stims( vars );
%     projMetric = vars.projMetric( :, :, 1 );
%     projMetric = projMetric( : );
%     projMetric = projMetric( ~isnan( projMetric ) );
%     projMetricAlls0{ 1, 1 } = [ projMetricAlls0{ 1, 1 }; projMetric ];
%     prodProj = vars.prodProj( :, :, 1 );
%     prodProj = prodProj( : );
%     prodProj = prodProj( ~isnan( prodProj ) );
%     prodProjAlls0{ 1, 1 } = [ prodProjAlls0{ 1, 1 }; prodProj ];
%     clear vars projMetric prodProj
% end; clear iter
% 
% clear fname
% 
% save( 'projMetricAlls_1_0.mat', 'projMetricAlls0', 'prodProjAlls0' )
% clear N_iter projMetricAlls0 prodProjAlls0
% 

%% projMetricAlls_1_1
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_1_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_1_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_1.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_1M
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0M.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_1M_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_1M_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_1M.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_2
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_2_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_2_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_2.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_3
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_3_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_3_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_3.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_3M
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0M.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_3M_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_3M_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_3M.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_4
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_4_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_4_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_4.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_1_5
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul1_5_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul1_5_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_1_5.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_1
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_1_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_1_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-1) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_1.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_2
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_2_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_2_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-2) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-2) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_2.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_3
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_3_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_3_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-3) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-3) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_3.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_4
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_4_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_4_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-4) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-4) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_4.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_5
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_5_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_5_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_5.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_c1
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_c1_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_c1_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_c1.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% projMetricAlls_2_c2
% 
% N_iter = 10;
% projMetricAlls1 = cell( 2, 21 );
% projMetricAlls2 = cell( 2, 21 );
% prodProjAlls1 = cell( 2, 21 );
% prodProjAlls2 = cell( 2, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'Simul2_c2_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'Simul2_c2_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.infoStims = [ 4000, 10, 0.05, 5, 10, 10 ^ (-5) ];% recording duration, stimulation duration, probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars = GM_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'projMetricAlls_2_c2.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 

%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% Simul3_0
% 
% clear vars
% 
% vars.t_memory = 1;% time steps
% vars.eta = 0.001;% learning rate
% vars.period = 100;% period of synaptic scaling & adjustment of lateral competition level
% 
% vars.areas = [ 500, 500, 1000 ];% the number of units in each area
% 
% vars.connScale = [ 1, 1, 1 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.areas ), length( vars.areas ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 3, 1 ) = vars.connScale( 1 ) * vars.areas( 3 );
% vars.connects( 1, 3 ) = vars.connScale( 2 ) * vars.areas( 3 );
% vars.connects( 2, 3 ) = vars.connScale( 1 ) * vars.areas( 3 );
% vars.connects( 3, 2 ) = vars.connScale( 2 ) * vars.areas( 3 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.areas( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% 
% vars.actScale = 0.5 * [ 1, 1, 1 ];% initial lateral inhibition level
% vars.actScaleThr = 1.4 * [ 1, 1, 1 ];% upper threshold of lateral inhibition level
% vars.actThr = 100 * [ 1, 1, 1 ] ./ vars.actScale;% neural activity upper threshold
% vars.actMax = 2.5 * [ 1, 1, 1 ];% target maximum neural activity
% vars.eta_actScale = 0.001;% learning rate for actScale
% 
% vars.actTemp = [];
% vars.actMean = [];
% 
% vars = GM_initiation_MI( vars );
% 
% 
% save( 'Simul3_0.mat', 'vars' )
% clear vars
% 

%% Simul3_1
% 
% load( 'Simul3_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul3_1_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul3_1_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% Simul3_3
% 
% load( 'Simul3_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     vars.eta = 0.001 * 2 * 5;% learning rate
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 1200, 10, 2, 5, 10 ];% recording duration, stimulation duration, rest duration, the number of classes, the number of stimulations per a class ];
%     vars = GM_stimulation_MI( vars );
%     vars = GM_simulation_Hebb_MI_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'Simul3_3_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'Simul3_3_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%%

% figure; imagesc( vars.weights )
% figure; imagesc( vars.weights, [ 0, 4 ] / 1000 )
% figure; imagesc( vars.weights, [ 0, 2.5 ] / 1000 )
% figure; plot( sum( vars.weights, 2 ) )
% find( isnan( vars.acts ) )
% figure; imagesc( reshape( transpose( vars.weights( 507, 1 : 400 ) ), [ 20, 20 ] ) )
% figure; imagesc( vars.acts )
% figure; imagesc( vars.acts, 1 + 0.01 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts, 1 + 0.1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts, 1 + 0.3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts, 1 + 1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts, 1 + 3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts, 1 + 10 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 401 : 1300, 1 : 150 ), 1 + 0.1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 401 : 1300, 1 : 150 ), 1 + 0.3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 401 : 1300, 1 : 150 ), 1 + 1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 401 : 1300, 1 : 150 ), 1 + 3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 1301 : 1800, 1 : 150 ), 1 + 0.1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 1301 : 1800, 1 : 150 ), 1 + 0.3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 1301 : 1800, 1 : 150 ), 1 + 1 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 1301 : 1800, 1 : 150 ), 1 + 3 * [ -1, 1 ] ); colormap( turbo )
% figure; imagesc( vars.acts( 401 : 410, : ) )
% figure; plot( vars.acts( :, end ) )
% figure; plot( vars.actMean )
