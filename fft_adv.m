function [vectout,axe_f,p] = fft_adv(vectin)

    % [vectout,axe_f,p] = fft_adv(vectin)
    % =====================================================================
    % IN
	% Vectin (vector): vector on which the FFT is calculated
	%
	% OUT
	% Vectout (float): amplitude of the fft
	% Axis_f (float): normalized axis in multiples of pi
	% P (float): phase of the fft
	%
	% Fft_adv (vectin): utility that calculates FFT and
	% Perform various operations such as calculating the frequency axis or
	% Shifter the DC to the center.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016

% Calculation of FFT
data = vectin;
% The number of FFT points in base 2 is found to speed up the calculation
n = 2^nextpow2(length(data));

% Calculation of FFT
data_fft = fft(data,n);

% Frequency axis
axe_f = (-1: 2/n : 1 - 2/n); % x pi
data_f_dB = 20*log10(abs(data_fft));
p = phase(data_fft);

% We shift data
vectout = fftshift(data_f_dB);


end