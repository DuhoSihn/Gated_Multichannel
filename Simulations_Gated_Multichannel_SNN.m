% Simulations_Gated_Multichannel_SNN
clear; close all; clc



%% SNN_Simul1_0
% 
% clear vars
% 
% vars.dt = 0.5;% time resolution (ms)
% vars.t_memory = 30;% time memory (ms)
% 
% vars.tau_E = 20;% E neuron resting membrane time constant (ms)
% vars.tau_I = 20;% I neuron resting membrane time constant (ms)
% vars.E_L_E = -70;% E neuron resting potential (mV)
% vars.E_L_I = -62;% I neuron resting potential (mV)
% vars.Delta_T_E = 2;% E neuron EIF slope factor (mV)
% vars.Delta_T_I = 2;% I neuron EIF slope factor (mV)
% vars.C = 300;% Capacitance (pF)
% vars.E_E = 0;% E reverse potential (mV)
% vars.E_I = -75;% I reverse potential (mV)
% vars.V_T = -52;% threshold potential (mV)
% vars.A_T = 10;% Post spike threshold potential increase (mV)
% vars.tau_T = 30;% Adaptive threshold time scale (ms)
% vars.V_re = -60;% Reset potential (mV)
% vars.tau_abs = 1;% Absolute refractory period (ms)
% vars.a_w = 4;% Subthreshold adaptation (nS)
% vars.b_w = 0.805;% Spike-triggered adaptation (pA)
% vars.tau_w = 150;% Spike-triggered adaptation time scale (ms)
% vars.V_ap = 20;% action potential threshold potention (mV)
% vars.V_lb = -75;% lower bound potential (mV) := vars.E_I
% 
% vars.N_E = [ 500, 500, 500 ];% the number of excitatory neurons
% vars.N_I = [ 125, 125, 125 ];% the number of excitatory neurons
% % vars.N_E = [ 1000, 1000, 1000 ];% the number of excitatory neurons
% % vars.N_I = [ 250, 250, 250 ];% the number of excitatory neurons
% vars.p_C = 2.5 * 0.2;% connection probability via chemical synapses
% % vars.scaleWeight = 0.15;% parameter for re-scaling of synaptic weights
% vars.scaleWeight = 0.1;% parameter for re-scaling of synaptic weights
% % vars.p_E = 0.2;% connection probability via electrical synapses
% vars.tau_r_E = 1;% rise time for E synapses (ms)
% vars.tau_d_E = 6;% decay time for E synapses (ms)
% vars.tau_r_I = 0.5;% rise time for I synapses (ms)
% vars.tau_d_I = 2;% decay time for I synapses (ms)
% vars.r_ext_EE = 6 * 500;% Rate of external input to E neurons (Hz)
% vars.r_ext_IE = 12 * 500;% Rate of external input to I neurons (Hz)
% vars.J_EE_min = 1.78;% minimum E to E synaptic weight (pF)
% % vars.J_EE_max = 21.4;% maximum E to E synaptic weight (pF)
% vars.J_EE_max = 1.2 * 24 * 2.76;% maximum E to E synaptic weight (pF)
% % vars.J_EE_O = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O1 = 24 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O2 = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O3 = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EI_min = 48.7;% minimum I to E synaptic weight (pF)
% vars.J_EI_max = 243;% maximum I to E synaptic weight (pF)
% vars.J_EI_O = 3 * 48.7;% initial I to E synaptic weight (pF)
% vars.J_IE_val = 1.27;% value of E to I synaptic weight (pF)
% vars.J_II_val = 16.2;% value of I to I synaptic weight (pF)
% % vars.J_GII_val = 0;% value of I to I gap junction weight (pF)
% vars.J_ext_EE = vars.J_EE_min;
% vars.J_ext_IE = vars.J_IE_val;
% vars.period_scaling = 20;% period of synaptic scaling (ms)
% 
% vars.A_LTD = 0.0008;% Long-term depression (LTD) strength (pA mV^-1)
% vars.A_LTP = 0.0014;% Long-term potentiation (LTP) strength (pA mV^-2)
% vars.theta_LTD = -70;% Threshold to recruit LTD (mV)
% vars.theta_LTP = -49;% Threshold to recruit LTP (mV)
% vars.tau_u = 10;% Time constant of low-pass filtered membrane voltage (for LTD) (ms)
% vars.tau_v = 7;% Time constant of low-pass filtered membrane voltage (for LTP) (ms)
% vars.tau_x = 15;% Time constant low-pass filtered spike train (for LTP) (ms)
% 
% vars.tau_y = 20;% Time constant of low-pass filtered spike train (ms)
% vars.eta = 1;% Synaptic plasticity learning rate (pA)
% vars.r_O = 3;% Target firing rate (Hz)
% 
% % vars.triplet_tau_plus = 16.8;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_minus = 33.7;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_x = 101;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_y = 125;% parameter of triplet plasticity (ms)
% % vars.triplet_A_2_plus = 7.5 * 10 ^ (-10);% parameter of triplet plasticity
% % vars.triplet_A_3_plus = 9.3 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_2_minus = 7 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_3_minus = 2.3 * 10 ^ (-4);% parameter of triplet plasticity
% 
% vars.V_E = [];% voltages of E (mV)
% vars.V_I = [];% voltages of I (mV)
% vars.Vu_E = [];% low-pass filtered valtage of E (mV)
% vars.Vv_E = [];% low-pass filtered valtage of E (mV)
% 
% vars.s_E = [];% spike train of E
% vars.sx_E = [];% low-pass filtered spike train of E
% vars.sy_E = [];% low-pass filtered spike train of E
% vars.s_I = [];% spike train of I
% vars.sy_I = [];% low-pass filtered spike train of I
% 
% vars.V_T_E = [];% thereshold of E
% vars.ww_E = [];% adaptation current of E
% 
% vars.s_ext_EE = [];% external stimulation to E
% vars.s_ext_IE = [];% external stimulation to I
% 
% vars.ct_abs_E = [];% count of absolute refractory period for E neurons
% vars.ct_abs_I = [];% count of absolute refractory period for I neurons
% 
% % vars.triplet_r_1 = [];% variable of triplet plasticity
% % vars.triplet_r_2 = [];% variable of triplet plasticity
% % vars.triplet_o_1 = [];% variable of triplet plasticity
% % vars.triplet_o_2 = [];% variable of triplet plasticity
% 
% % vars.connScale = [ 1, 1, 4 ];% [ orthodromic, antidromic, within area ]
% vars.connScale = [ 1, 1, 1 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.N_E ), length( vars.N_E ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 2, 1 ) = vars.connScale( 1 ) * vars.N_E( 1 );
% % vars.connects( 1, 2 ) = vars.connScale( 2 ) * vars.N_E( 2 );
% vars.connects( 2, 2 ) = vars.connScale( 3 ) * vars.N_E( 2 );
% vars.connects( 3, 2 ) = vars.connScale( 1 ) * vars.N_E( 2 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.N_E( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% vars.connects( isnan( vars.connects ) ) = 0;
% vars.connects( vars.connects > 0 ) = 1;
% 
% vars.nChannels = 5;% the number of channels
% vars.infoStims = [ 10000, 1000, 0.0002, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_SNN_define_interaction( vars );
% vars = GM_SNN_initiation( vars );
% 
% 
% save( 'SNN_Simul1_0.mat', 'vars' )
% clear vars
% 

%% SNN_Simul1_0M
% 
% clear vars
% 
% vars.dt = 0.5;% time resolution (ms)
% vars.t_memory = 30;% time memory (ms)
% 
% vars.tau_E = 20;% E neuron resting membrane time constant (ms)
% vars.tau_I = 20;% I neuron resting membrane time constant (ms)
% vars.E_L_E = -70;% E neuron resting potential (mV)
% vars.E_L_I = -62;% I neuron resting potential (mV)
% vars.Delta_T_E = 2;% E neuron EIF slope factor (mV)
% vars.Delta_T_I = 2;% I neuron EIF slope factor (mV)
% vars.C = 300;% Capacitance (pF)
% vars.E_E = 0;% E reverse potential (mV)
% vars.E_I = -75;% I reverse potential (mV)
% vars.V_T = -52;% threshold potential (mV)
% vars.A_T = 10;% Post spike threshold potential increase (mV)
% vars.tau_T = 30;% Adaptive threshold time scale (ms)
% vars.V_re = -60;% Reset potential (mV)
% vars.tau_abs = 1;% Absolute refractory period (ms)
% vars.a_w = 4;% Subthreshold adaptation (nS)
% vars.b_w = 0.805;% Spike-triggered adaptation (pA)
% vars.tau_w = 150;% Spike-triggered adaptation time scale (ms)
% vars.V_ap = 20;% action potential threshold potention (mV)
% vars.V_lb = -75;% lower bound potential (mV) := vars.E_I
% 
% vars.N_E = [ 500, 500, 500 ];% the number of excitatory neurons
% vars.N_I = [ 125, 125, 125 ];% the number of excitatory neurons
% % vars.N_E = [ 1000, 1000, 1000 ];% the number of excitatory neurons
% % vars.N_I = [ 250, 250, 250 ];% the number of excitatory neurons
% vars.p_C = 2.5 * 0.2;% connection probability via chemical synapses
% % vars.scaleWeight = 0.15;% parameter for re-scaling of synaptic weights
% vars.scaleWeight = 0.13;% parameter for re-scaling of synaptic weights
% % vars.p_E = 0.2;% connection probability via electrical synapses
% vars.tau_r_E = 1;% rise time for E synapses (ms)
% vars.tau_d_E = 6;% decay time for E synapses (ms)
% vars.tau_r_I = 0.5;% rise time for I synapses (ms)
% vars.tau_d_I = 2;% decay time for I synapses (ms)
% vars.r_ext_EE = 6 * 500;% Rate of external input to E neurons (Hz)
% vars.r_ext_IE = 12 * 500;% Rate of external input to I neurons (Hz)
% vars.J_EE_min = 1.78;% minimum E to E synaptic weight (pF)
% % vars.J_EE_max = 21.4;% maximum E to E synaptic weight (pF)
% vars.J_EE_max = 1.2 * 2 * 16 * 2.76;% maximum E to E synaptic weight (pF)
% % vars.J_EE_O = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O1 = 2 * 16 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O2 = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O3 = 2.76;% initial E to E synaptic weight (pF)
% vars.J_EI_min = 48.7;% minimum I to E synaptic weight (pF)
% vars.J_EI_max = 243;% maximum I to E synaptic weight (pF)
% vars.J_EI_O = 3 * 48.7;% initial I to E synaptic weight (pF)
% vars.J_IE_val = 1.27;% value of E to I synaptic weight (pF)
% vars.J_II_val = 16.2;% value of I to I synaptic weight (pF)
% % vars.J_GII_val = 0;% value of I to I gap junction weight (pF)
% vars.J_ext_EE = vars.J_EE_min;
% vars.J_ext_IE = vars.J_IE_val;
% vars.period_scaling = 20;% period of synaptic scaling (ms)
% 
% vars.A_LTD = 0.0008;% Long-term depression (LTD) strength (pA mV^-1)
% vars.A_LTP = 0.0014;% Long-term potentiation (LTP) strength (pA mV^-2)
% vars.theta_LTD = -70;% Threshold to recruit LTD (mV)
% vars.theta_LTP = -49;% Threshold to recruit LTP (mV)
% vars.tau_u = 10;% Time constant of low-pass filtered membrane voltage (for LTD) (ms)
% vars.tau_v = 7;% Time constant of low-pass filtered membrane voltage (for LTP) (ms)
% vars.tau_x = 15;% Time constant low-pass filtered spike train (for LTP) (ms)
% 
% vars.tau_y = 20;% Time constant of low-pass filtered spike train (ms)
% vars.eta = 1;% Synaptic plasticity learning rate (pA)
% vars.r_O = 3;% Target firing rate (Hz)
% 
% % vars.triplet_tau_plus = 16.8;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_minus = 33.7;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_x = 101;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_y = 125;% parameter of triplet plasticity (ms)
% % vars.triplet_A_2_plus = 7.5 * 10 ^ (-10);% parameter of triplet plasticity
% % vars.triplet_A_3_plus = 9.3 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_2_minus = 7 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_3_minus = 2.3 * 10 ^ (-4);% parameter of triplet plasticity
% 
% vars.V_E = [];% voltages of E (mV)
% vars.V_I = [];% voltages of I (mV)
% vars.Vu_E = [];% low-pass filtered valtage of E (mV)
% vars.Vv_E = [];% low-pass filtered valtage of E (mV)
% 
% vars.s_E = [];% spike train of E
% vars.sx_E = [];% low-pass filtered spike train of E
% vars.sy_E = [];% low-pass filtered spike train of E
% vars.s_I = [];% spike train of I
% vars.sy_I = [];% low-pass filtered spike train of I
% 
% vars.V_T_E = [];% thereshold of E
% vars.ww_E = [];% adaptation current of E
% 
% vars.s_ext_EE = [];% external stimulation to E
% vars.s_ext_IE = [];% external stimulation to I
% 
% vars.ct_abs_E = [];% count of absolute refractory period for E neurons
% vars.ct_abs_I = [];% count of absolute refractory period for I neurons
% 
% % vars.triplet_r_1 = [];% variable of triplet plasticity
% % vars.triplet_r_2 = [];% variable of triplet plasticity
% % vars.triplet_o_1 = [];% variable of triplet plasticity
% % vars.triplet_o_2 = [];% variable of triplet plasticity
% 
% % vars.connScale = [ 1, 1, 4 ];% [ orthodromic, antidromic, within area ]
% vars.connScale = [ 1, 1, 1 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.N_E ), length( vars.N_E ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 2, 1 ) = vars.connScale( 1 ) * vars.N_E( 1 );
% % vars.connects( 1, 2 ) = vars.connScale( 2 ) * vars.N_E( 2 );
% vars.connects( 2, 2 ) = vars.connScale( 3 ) * vars.N_E( 2 );
% vars.connects( 3, 2 ) = vars.connScale( 1 ) * vars.N_E( 2 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.N_E( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% vars.connects( isnan( vars.connects ) ) = 0;
% vars.connects( vars.connects > 0 ) = 1;
% 
% vars.nChannels = 1;% the number of channels
% vars.infoStims = [ 10000, 1000, 0.0002, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
% vars = GM_SNN_define_interaction( vars );
% vars = GM_SNN_initiation( vars );
% 
% 
% save( 'SNN_Simul1_0M.mat', 'vars' )
% clear vars
% 

%% SNN_Simul1_3
% 
% load( 'SNN_Simul1_0.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'SNN_Simul1_3_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'SNN_Simul1_3_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 

%% SNN_Simul1_3M
% 
% load( 'SNN_Simul1_0M.mat' )
% 
% 
% N_iter = 1000;
% for iter = 1 : N_iter
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1 ];% in area
%     vars = GM_SNN_stimulation( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'SNN_Simul1_3M_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'SNN_Simul1_3M_', num2str( iter ), '.mat' ], 'vars' )
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
%% SNN_projMetricAlls_1_3
% 
% warning off
% 
% N_iter = 10;
% projMetricAlls1 = cell( 3, 21 );
% projMetricAlls2 = cell( 3, 21 );
% prodProjAlls1 = cell( 3, 21 );
% prodProjAlls2 = cell( 3, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'SNN_Simul1_0.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'SNN_Simul1_3_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'SNN_Simul1_3_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.inputs = [ 1 ];% in area
%         vars.infoStims = [ 100000, 1000, 0.0002, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars.binSize = 50;% bin size (ms)
%         vars = GM_SNN_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 3 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 3, t } = [ projMetricAlls1{ 3, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 3 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 3, t } = [ prodProjAlls1{ 3, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.inputs = [ 1 ];% in area
%         vars.infoStims = [ 100000, 1000, 0.0005, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars.binSize = 50;% bin size (ms)
%         vars = GM_SNN_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 3 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 3, t } = [ projMetricAlls2{ 3, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 3 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 3, t } = [ prodProjAlls1{ 3, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'SNN_projMetricAlls_1_3.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 
% warning on
% 

%% SNN_projMetricAlls_1_3M
% 
% warning off
% 
% N_iter = 10;
% projMetricAlls1 = cell( 3, 21 );
% projMetricAlls2 = cell( 3, 21 );
% prodProjAlls1 = cell( 3, 21 );
% prodProjAlls2 = cell( 3, 21 );
% for t = 1 : size( projMetricAlls1, 2 )
% 
%     if t == 1
%         fname = 'SNN_Simul1_0M.mat';
%     elseif t > 1
%         if ( t - 1 ) * 50 < 100
%             fname = [ 'SNN_Simul1_3M_0', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         else
%             fname = [ 'SNN_Simul1_3M_', num2str( ( t - 1 ) * 50 ), '.mat' ];
%         end
%     end
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.inputs = [ 1 ];% in area
%         vars.infoStims = [ 100000, 1000, 0.0002, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars.binSize = 50;% bin size (ms)
%         vars = GM_SNN_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 1, t } = [ projMetricAlls1{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 2, t } = [ projMetricAlls1{ 2, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 3 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls1{ 3, t } = [ projMetricAlls1{ 3, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 3 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls1{ 3, t } = [ prodProjAlls1{ 3, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     for iter = 1 : N_iter
%         load( fname )
%         vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%         vars.inputs = [ 1 ];% in area
%         vars.infoStims = [ 100000, 1000, 0.0005, 5, 10, 10 ^ (-1) ];% recording duration (ms), stimulation duration (ms), probability of stimulation, the number of channels, the number of stimulations, the probability of interactions ];
%         vars.binSize = 50;% bin size (ms)
%         vars = GM_SNN_stimulation_distProj( vars );
%         projMetric = vars.projMetric( :, :, 1 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 1, t } = [ projMetricAlls2{ 1, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 2 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 2, t } = [ projMetricAlls2{ 2, t }; projMetric ];
%         projMetric = vars.projMetric( :, :, 3 );
%         projMetric = projMetric( : );
%         projMetric = projMetric( ~isnan( projMetric ) );
%         projMetricAlls2{ 3, t } = [ projMetricAlls2{ 3, t }; projMetric ];
%         prodProj = vars.prodProj( :, :, 1 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 1, t } = [ prodProjAlls1{ 1, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 2 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 2, t } = [ prodProjAlls1{ 2, t }; prodProj ];
%         prodProj = vars.prodProj( :, :, 3 );
%         prodProj = prodProj( : );
%         prodProj = prodProj( ~isnan( prodProj ) );
%         prodProjAlls2{ 3, t } = [ prodProjAlls1{ 3, t }; prodProj ];
%         clear vars projMetric prodProj
%     end; clear iter
% 
%     clear fname
% 
% end; clear t
% 
% save( 'SNN_projMetricAlls_1_3M.mat', 'projMetricAlls1', 'projMetricAlls2', 'prodProjAlls1', 'prodProjAlls2' )
% clear N_iter projMetricAlls1 projMetricAlls2 prodProjAlls1 prodProjAlls2
% 
% warning on
% 

%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% SNN_Simul3_0
% 
% clear vars
% 
% vars.dt = 0.5;% time resolution (ms)
% vars.t_memory = 30;% time memory (ms)
% 
% vars.tau_E = 20;% E neuron resting membrane time constant (ms)
% vars.tau_I = 20;% I neuron resting membrane time constant (ms)
% vars.E_L_E = -70;% E neuron resting potential (mV)
% vars.E_L_I = -62;% I neuron resting potential (mV)
% vars.Delta_T_E = 2;% E neuron EIF slope factor (mV)
% vars.Delta_T_I = 2;% I neuron EIF slope factor (mV)
% vars.C = 300;% Capacitance (pF)
% vars.E_E = 0;% E reverse potential (mV)
% vars.E_I = -75;% I reverse potential (mV)
% vars.V_T = -52;% threshold potential (mV)
% vars.A_T = 10;% Post spike threshold potential increase (mV)
% vars.tau_T = 30;% Adaptive threshold time scale (ms)
% vars.V_re = -60;% Reset potential (mV)
% vars.tau_abs = 1;% Absolute refractory period (ms)
% vars.a_w = 4;% Subthreshold adaptation (nS)
% vars.b_w = 0.805;% Spike-triggered adaptation (pA)
% vars.tau_w = 150;% Spike-triggered adaptation time scale (ms)
% vars.V_ap = 20;% action potential threshold potention (mV)
% vars.V_lb = -75;% lower bound potential (mV) := vars.E_I
% 
% vars.N_E = [ 500, 500, 1000 ];% the number of excitatory neurons
% vars.N_I = [ 125, 125, 250 ];% the number of excitatory neurons
% % vars.N_E = [ 1000, 1000, 2000 ];% the number of excitatory neurons
% % vars.N_I = [ 250, 250, 500 ];% the number of excitatory neurons
% vars.p_C = 2.5 * 0.2;% connection probability via chemical synapses
% % vars.scaleWeight = 0.15;% parameter for re-scaling of synaptic weights
% vars.scaleWeight = 0.13;% parameter for re-scaling of synaptic weights
% % vars.p_E = 0.2;% connection probability via electrical synapses
% vars.tau_r_E = 1;% rise time for E synapses (ms)
% vars.tau_d_E = 6;% decay time for E synapses (ms)
% vars.tau_r_I = 0.5;% rise time for I synapses (ms)
% vars.tau_d_I = 2;% decay time for I synapses (ms)
% vars.r_ext_EE = 6 * 500;% Rate of external input to E neurons (Hz)
% vars.r_ext_IE = 12 * 500;% Rate of external input to I neurons (Hz)
% vars.J_EE_min = 1.78;% minimum E to E synaptic weight (pF)
% % vars.J_EE_max = 21.4;% maximum E to E synaptic weight (pF)
% % vars.J_EE_max = 1 * 8 * 2.76;% maximum E to E synaptic weight (pF)
% vars.J_EE_max = 1 * 6 * 2.76;% maximum E to E synaptic weight (pF)
% % vars.J_EE_O = 2.76;% initial E to E synaptic weight (pF)
% % vars.J_EE_O1 = 8 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O1 = 6 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O2 = 2.76;% initial E to E synaptic weight (pF)
% % vars.J_EE_O3 = 8 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O3 = 6 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O4 = 2.76;% initial E to E synaptic weight (pF)
% % vars.J_EE_O5 = 1.0 * 8 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EE_O5 = 1.0 * 6 * 2.76;% initial E to E synaptic weight (pF)
% vars.J_EI_min = 48.7;% minimum I to E synaptic weight (pF)
% vars.J_EI_max = 243;% maximum I to E synaptic weight (pF)
% vars.J_EI_O = 3 * 48.7;% initial I to E synaptic weight (pF)
% vars.J_IE_val = 1.27;% value of E to I synaptic weight (pF)
% vars.J_II_val = 16.2;% value of I to I synaptic weight (pF)
% % vars.J_GII_val = 0;% value of I to I gap junction weight (pF)
% vars.J_ext_EE = vars.J_EE_min;
% vars.J_ext_IE = vars.J_IE_val;
% vars.period_scaling = 20;% period of synaptic scaling (ms)
% 
% vars.A_LTD = 0.0008;% Long-term depression (LTD) strength (pA mV^-1)
% vars.A_LTP = 0.0014;% Long-term potentiation (LTP) strength (pA mV^-2)
% vars.theta_LTD = -70;% Threshold to recruit LTD (mV)
% vars.theta_LTP = -49;% Threshold to recruit LTP (mV)
% vars.tau_u = 10;% Time constant of low-pass filtered membrane voltage (for LTD) (ms)
% vars.tau_v = 7;% Time constant of low-pass filtered membrane voltage (for LTP) (ms)
% vars.tau_x = 15;% Time constant low-pass filtered spike train (for LTP) (ms)
% 
% vars.tau_y = 20;% Time constant of low-pass filtered spike train (ms)
% vars.eta = 1;% Synaptic plasticity learning rate (pA)
% vars.r_O = 3;% Target firing rate (Hz)
% 
% % vars.triplet_tau_plus = 16.8;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_minus = 33.7;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_x = 101;% parameter of triplet plasticity (ms)
% % vars.triplet_tau_y = 125;% parameter of triplet plasticity (ms)
% % vars.triplet_A_2_plus = 7.5 * 10 ^ (-10);% parameter of triplet plasticity
% % vars.triplet_A_3_plus = 9.3 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_2_minus = 7 * 10 ^ (-3);% parameter of triplet plasticity
% % vars.triplet_A_3_minus = 2.3 * 10 ^ (-4);% parameter of triplet plasticity
% 
% vars.V_E = [];% voltages of E (mV)
% vars.V_I = [];% voltages of I (mV)
% vars.Vu_E = [];% low-pass filtered valtage of E (mV)
% vars.Vv_E = [];% low-pass filtered valtage of E (mV)
% 
% vars.s_E = [];% spike train of E
% vars.sx_E = [];% low-pass filtered spike train of E
% vars.sy_E = [];% low-pass filtered spike train of E
% vars.s_I = [];% spike train of I
% vars.sy_I = [];% low-pass filtered spike train of I
% 
% vars.V_T_E = [];% thereshold of E
% vars.ww_E = [];% adaptation current of E
% 
% vars.s_ext_EE = [];% external stimulation to E
% vars.s_ext_IE = [];% external stimulation to I
% 
% vars.ct_abs_E = [];% count of absolute refractory period for E neurons
% vars.ct_abs_I = [];% count of absolute refractory period for I neurons
% 
% % vars.triplet_r_1 = [];% variable of triplet plasticity
% % vars.triplet_r_2 = [];% variable of triplet plasticity
% % vars.triplet_o_1 = [];% variable of triplet plasticity
% % vars.triplet_o_2 = [];% variable of triplet plasticity
% 
% vars.connScale = [ 1, 1, 1 ];% [ orthodromic, antidromic, within area ]
% vars.connects = zeros( length( vars.N_E ), length( vars.N_E ) );% vars.connects( j, i ): from area i to area j.
% vars.connects( 3, 1 ) = vars.connScale( 1 ) * vars.N_E( 3 );
% % vars.connects( 1, 3 ) = vars.connScale( 2 ) * vars.N_E( 3 );
% % vars.connects( 2, 3 ) = vars.connScale( 1 ) * vars.N_E( 3 );
% vars.connects( 3, 2 ) = vars.connScale( 2 ) * vars.N_E( 3 );
% vars.connects( 3, 3 ) = vars.connScale( 3 ) * vars.N_E( 3 );
% vars.connects = vars.connects ./ sum( vars.connects, 2 );
% vars.connects( isnan( vars.connects ) ) = 0;
% vars.connects( vars.connects > 0 ) = 1;
% 
% vars.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
% vars = GM_SNN_initiation_MI( vars );
% 
% 
% save( 'SNN_Simul3_0.mat', 'vars' )
% clear vars
% 

%% SNN_Simul3_3
% 
% load( 'SNN_Simul3_0.mat' )
% 
% 
% N_iter = 100;
% for iter = 1 : N_iter
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars = GM_SNN_stimulation_MI( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 1;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars = GM_SNN_stimulation_MI( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars = GM_SNN_stimulation_MI( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     vars.mode = 0.5;% the current balance between synaptic weights ( 1:= lateral, 0:= recurrent ), \in [ 0, 1 ].
%     vars.inputs = [ 1, 2 ];% in areas
%     % vars.inputs = [ 1 ];% in areas
%     vars.infoStims_MI = [ 12000, 1000, 200, 5, 10 ];% recording duration (ms), stimulation duration (ms), rest duration (ms), the number of classes, the number of stimulations per a class ];
%     vars = GM_SNN_stimulation_MI( vars );
%     vars = GM_SNN_simulation_GPU( vars );
% 
%     if mod( iter, 50 ) == 0
%         if iter < 100
%             save( [ 'SNN_Simul3_3_0', num2str( iter ), '.mat' ], 'vars' )
%         else
%             save( [ 'SNN_Simul3_3_', num2str( iter ), '.mat' ], 'vars' )
%         end
%     end
% 
% end; clear iter
% 
% 
% clear vars N_iter
% 
