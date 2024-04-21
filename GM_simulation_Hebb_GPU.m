function vars = GM_simulation_Hebb_GPU( vars, varargin )


type_plasticity_off = find( strcmpi( varargin, 'plasticity_off' ) == 1 );


vars.actScales = transpose( sum( transpose( vars.actScale ) .* vars.idxMat, 1 ) );
vars.actThrsExp = exp( vars.actScales .* vars.actThrs );

if isempty( vars.actTemp )
    vars.actTemp = ones( sum( vars.areas, 2 ), vars.t_memory );
end

N_areas = length( vars.areas );
N_units = sum( vars.areas, 2 );
L_stims = size( vars.stims, 2 );
h = 0;
h1 = 0;
h2 = 0;
ch = 0;

if isempty( vars.actMean )
    vars.actMean = ones( N_units, 1 );
end

vars.acts = zeros( N_units, L_stims );

temp_connects = vars.connects;
if vars.mode == 1
    temp_connects( eye( N_areas ) == 1 ) = ( 1 - vars.mode ) * temp_connects( eye( N_areas ) == 1 );
elseif vars.mode == 0
    temp_connects( eye( N_areas ) == 0 ) = ( vars.mode ) * temp_connects( eye( N_areas ) == 0 );
end
% temp_connects = temp_connects ./ sum( temp_connects, 2 );
temp_connects( isinf( temp_connects ) ) = nan;
temp_connects( isnan( temp_connects ) ) = 0;

temp_scaleWeights = zeros( size( vars.scaleWeights ) );
temp_weights = zeros( size( vars.weights ) );
% synaptic scaling
for h1 = 1 : length( vars.areas )
    for h2 = 1 : length( vars.areas )
        if temp_connects( h1, h2 ) > 0
            if h1 ~= h2
                for ch = 1 : vars.nChannels
                    temp_scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = temp_connects( h1, h2 ) * ( vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( vars.scaleWeights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                    temp_weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = temp_connects( h1, h2 ) * ( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                end
            elseif h1 == h2
                temp_scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = temp_connects( h1, h2 ) * ( vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( vars.scaleWeights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
                temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = temp_connects( h1, h2 ) * ( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
            end
        end
    end
end

temp_acts0 = vars.actTemp( :, end );
temp_acts1 = vars.actTemp( :, end );
temp_acts2 = vars.actTemp( :, end );
temp_acts3 = vars.actTemp( :, end );
temp_dWeights = zeros( N_units, N_units );
temp_actMax = zeros( 1, length( vars.areas ) );

t_domain_period = 0 : vars.period : size( vars.stims, 2 );

% GPU ----------------
vars.t_memory = gpuArray( vars.t_memory );
vars.eta = gpuArray( vars.eta );
vars.nChannels = gpuArray( vars.nChannels );
vars.idxMat = gpuArray( vars.idxMat );
vars.idxMatCh = gpuArray( vars.idxMatCh );
vars.idxMatChAll = gpuArray( vars.idxMatChAll );
vars.idxInputs = gpuArray( vars.idxInputs );
vars.actExt = gpuArray( vars.actExt );
vars.actThrs = gpuArray( vars.actThrs );
vars.idxWeights = gpuArray( vars.idxWeights );
vars.eta_actScale = gpuArray( vars.eta_actScale );
vars.actMax = gpuArray( vars.actMax );
vars.actScale = gpuArray( vars.actScale );
vars.actScales = gpuArray( vars.actScales );
vars.actScaleThr = gpuArray( vars.actScaleThr );
vars.actThrsExp = gpuArray( vars.actThrsExp );
vars.actTemp = gpuArray( vars.actTemp );
vars.actMean = gpuArray( vars.actMean );
vars.acts = gpuArray( vars.acts );
N_areas = gpuArray( N_areas );
N_units = gpuArray( N_units );
L_stims = gpuArray( L_stims );
h = gpuArray( h );
h1 = gpuArray( h1 );
h2 = gpuArray( h2 );
ch = gpuArray( ch );
temp_connects = gpuArray( temp_connects );
temp_scaleWeights = gpuArray( temp_scaleWeights );
temp_weights = gpuArray( temp_weights );
temp_acts0 = gpuArray( temp_acts0 );
temp_acts1 = gpuArray( temp_acts1 );
temp_acts2 = gpuArray( temp_acts2 );
temp_acts3 = gpuArray( temp_acts3 );
temp_dWeights = gpuArray( temp_dWeights );
temp_actMax = gpuArray( temp_actMax );
t_domain_period = gpuArray( t_domain_period );
% GPU ----------------

for t = 1 : L_stims

    % begin
    temp_acts0 = vars.actTemp( :, end );
    temp_acts0( vars.idxInputs ) = vars.stims( vars.idxInputs, t );

    % weighted sum
    temp_acts1 = temp_weights * temp_acts0;

    % exponential & thresholding (to prevent NaN)
    temp_acts2 = exp( vars.actScales .* temp_acts1 );
    temp_acts2( isinf( temp_acts2 ) ) = nan;
    temp_acts2( isnan( temp_acts2 ) ) = vars.actThrsExp( isnan( temp_acts2 ) );
    temp_acts2( temp_acts2 > vars.actThrsExp ) = vars.actThrsExp( temp_acts2 > vars.actThrsExp );

    % normalization
    temp_acts3 = temp_acts2;
    % temp_acts3 = temp_acts3 ./ transpose( sum( ( vars.idxMat * temp_acts3 ) .* vars.idxMat, 1 ) );
    temp_acts3 = temp_acts3 ./ transpose( sum( ( vars.idxMatChAll * temp_acts3 ) .* vars.idxMatChAll, 1 ) );
    temp_acts3 = temp_acts3 .* vars.actExt;

    temp_acts3( vars.idxInputs ) = vars.stims( vars.idxInputs, t );

    if vars.t_memory == 1
        vars.actTemp = temp_acts3;
    elseif vars.t_memory > 1
        vars.actTemp( :, 1 : end - 1 ) = vars.actTemp( :, 2 : end );
        vars.actTemp( :, end ) = temp_acts3;
    end

    vars.acts( :, t ) = temp_acts3;

    if isempty( type_plasticity_off )
        % Hebbian learning
        temp_dWeights = ( temp_acts3 - vars.actMean ) .* transpose( ( temp_acts0 - vars.actMean ) );
        temp_dWeights( isinf( temp_dWeights ) ) = nan;
        temp_dWeights( isnan( temp_dWeights ) ) = 0;% repair dWeights
        temp_dWeights = temp_dWeights .* temp_scaleWeights;
        temp_weights( vars.idxWeights ) = temp_weights( vars.idxWeights ) + vars.eta * temp_dWeights( vars.idxWeights );
        temp_weights( temp_weights < 0 ) = 0;

        if ismember( t, t_domain_period )
            % lateral competition level
            for h = 1 : N_areas
                temp_actMax( 1, h ) = max( max( vars.acts( vars.idxMat( h, : ), : ), [], 2 ), [], 1 );
            end
            vars.actScale = vars.actScale + vars.eta_actScale * ( vars.actMax - temp_actMax );
            vars.actScale( vars.actScale > vars.actScaleThr ) = vars.actScaleThr( vars.actScale > vars.actScaleThr );
            vars.actScales = transpose( sum( transpose( vars.actScale ) .* vars.idxMat, 1 ) );

            % synaptic scaling
            temp_weights( isinf( temp_weights ) ) = nan;
            temp_weights( isnan( temp_weights ) ) = 2 * rand( length( find( isnan( temp_weights ) ) ), 1 ) .* temp_scaleWeights( isnan( temp_weights ) );% repair weights
            for h1 = 1 : N_areas
                for h2 = 1 : N_areas
                    if temp_connects( h1, h2 ) > 0
                        if h1 ~= h2
                            for ch = 1 : vars.nChannels
                                temp_weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = temp_connects( h1, h2 ) * ( temp_weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( temp_weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                            end
                        elseif h1 == h2
                            temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = temp_connects( h1, h2 ) * ( temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
                        end
                    end
                end
            end

            vars.actMean = mean( vars.acts( :, t_domain_period( find( t == t_domain_period ) - 1 ) + 1 : t_domain_period( find( t == t_domain_period ) ) ), 2 );
        end
    end

end

% GPU ----------------
vars.t_memory = gather( vars.t_memory );
vars.eta = gather( vars.eta );
vars.nChannels = gather( vars.nChannels );
vars.idxMat = gather( vars.idxMat );
vars.idxMatCh = gather( vars.idxMatCh );
vars.idxMatChAll = gather( vars.idxMatChAll );
vars.idxInputs = gather( vars.idxInputs );
vars.actExt = gather( vars.actExt );
vars.actThrs = gather( vars.actThrs );
vars.idxWeights = gather( vars.idxWeights );
vars.eta_actScale = gather( vars.eta_actScale );
vars.actMax = gather( vars.actMax );
vars.actScale = gather( vars.actScale );
vars.actScales = gather( vars.actScales );
vars.actScaleThr = gather( vars.actScaleThr );
vars.actThrsExp = gather( vars.actThrsExp );
vars.actTemp = gather( vars.actTemp );
vars.actMean = gather( vars.actMean );
vars.acts = gather( vars.acts );
temp_weights = gather( temp_weights );
h = gather( h );
h1 = gather( h1 );
h2 = gather( h2 );
ch = gather( ch );
% GPU ----------------

% recovering at letting zero
for h1 = 1 : length( vars.areas )
    for h2 = 1 : length( vars.areas )
        if vars.mode == 1
            if h1 == h2
                temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) );
            end
        elseif vars.mode == 0
            if h1 ~= h2
                temp_weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) );
            end
        end
    end
end
vars.weights = temp_weights;
% synaptic scaling
for h1 = 1 : length( vars.areas )
    for h2 = 1 : length( vars.areas )
        if vars.connects( h1, h2 ) > 0
            if h1 ~= h2
                for ch = 1 : vars.nChannels
                    vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) = vars.connects( h1, h2 ) * ( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ) ./ sum( vars.weights( vars.idxMatCh( h1, :, ch ), vars.idxMatCh( h2, :, ch ) ), 2 ) );
                end
            elseif h1 == h2
                vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) = vars.connects( h1, h2 ) * ( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ) ./ sum( vars.weights( vars.idxMat( h1, : ), vars.idxMat( h2, : ) ), 2 ) );
            end
        end
    end
end
