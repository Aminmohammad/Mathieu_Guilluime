function [F_a_N,F_phi_N,F_f_N] =  stat_computation_N(vectin)


    % function [F_a,F_phi,F_f] = stat_computation_N(vectin)
    % =====================================================================
    % IN
    % vectin (vecteur) :Vector containing the preamble
    %
    % OUT
    % F_a_N (vecteur) : Vector of stat. Normalized on the amplitude
    % F_phi_N (vecteur): Vector of stat. Standardized on the phase
    % F_f_N (vecteur) : Vector of stat. Standardized on the frequency
	% Instantaneous
    %
    % stat_computation_N(vectin): Performs the same statistical calculations
	% Than stat_computation (vectin), but here we normalize each of the
	% Values in order to be able to use them in the graphs of RF-DNA.
    %
    % TODO:
    % - adjust the calculation of fs as a function of frequency
	% Sampling at the division of zones (32)
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
 
% Put in function of fs
if length(vectin) > 2560
    ind = trig_preambule(vectin); vectin = vectin(ind:ind+2559);
end

% Put in function of fs
ts = 1/20e6;

% The vector is divided into the 32 regions
data_n = reshape(vectin,[80,32]);

% We calculate the different parameters of the 32 regions
a_n = abs(data_n);
phi_n = angle(data_n);
f_n = diff(phi_n)./(2*pi*ts);

% The various parameters are calculated over the whole of the preamble
a_sig = abs(vectin);
phi_sig = angle(vectin);
f_sig = diff(phi_sig)./(2*pi*ts);

% Standardization of stats for all three parameters
% amplitude
amp_var = [var(a_n) var(a_sig)]; N = max(amp_var); amp_var = amp_var ./ N;
amp_skew = [skewness(a_n) skewness(a_sig)]; N = max(amp_skew); amp_skew = amp_skew ./ N;
amp_kurt = [kurtosis(a_n) kurtosis(a_sig)]; N = max(amp_kurt); amp_kurt = amp_kurt ./ N;

% phase
phi_var = [var(phi_n) var(phi_sig)]; N = max(phi_var); phi_var = phi_var ./ N;
phi_skew = [skewness(phi_n) skewness(phi_sig)]; N = max(phi_skew); phi_skew = phi_skew ./ N;
phi_kurt = [kurtosis(phi_n) kurtosis(phi_sig)]; N = max(phi_kurt); phi_kurt = phi_kurt ./ N;

% instantaneous frequency
f_var = [var(f_n) var(f_sig)]; N = max(f_var); f_var = f_var ./ N;
f_skew = [skewness(f_n) skewness(f_sig)]; N = max(f_skew); f_skew = f_skew ./ N;
f_kurt = [kurtosis(f_n) kurtosis(f_sig)]; N = max(f_kurt); f_kurt = f_kurt ./ N;


% The stats are formatted
F_a_N   = [amp_var amp_skew amp_kurt]; 
F_phi_N = [phi_var phi_skew phi_kurt];  
F_f_N = [f_var f_skew f_kurt];  
    
end