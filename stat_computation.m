function [F_a,F_phi,F_f] = stat_computation(vectin)


    % function [F_a,F_phi,F_f] = stat_computation(vectin)
    % =====================================================================
    % IN
    % vectin (vecteur) : Vector containing the preamble
    %
    % OUT
    % F_a (vecteur) : Vector of stat. On the amplitude
    % F_phi (vector): stat vector. On the phase
	% F_f (vector): stat vector. On the instantaneous frequency
    %
    % stat_computation (vectin) is used to calculate the various statistics
	% On the preambles. The calculation of the variance, kurtosis and
	% Of skewness on amplitude, phase and instantaneous frequency.
	% The division of the statistical calculation areas follows the reference
	% Ramsey.
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
a_n   = abs(data_n);
phi_n = angle(data_n);
f_n    = diff(phi_n)./(2*pi*ts);

% The various parameters are calculated over the whole of the preamble
a_sig    = abs(vectin);
phi_sig = angle(vectin);
f_sig     = diff(phi_sig)./(2*pi*ts);


% Statistics
F_a   = [var(a_n) var(a_sig) skewness(a_n) skewness(a_sig) kurtosis(a_n) kurtosis(a_sig)];
F_phi = [var(phi_n) var(phi_sig) skewness(phi_n) skewness(phi_sig) kurtosis(phi_n) kurtosis(phi_sig)];
F_f = [var(f_n) var(f_sig ) skewness(f_n) skewness(f_sig ) kurtosis(f_n) kurtosis(f_sig )];


end