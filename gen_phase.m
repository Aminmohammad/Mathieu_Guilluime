function [phase_ref,phase_cycle,signal,fs] = gen_phase(fs)

    % function [phase_ref,phase_cycle,signal,fs] = gen_phase(fs)
    % =====================================================================
    % IN
    % fs (integer) (optionnel):Sampling frequency with which
	% Zigbee signals were sampled. Optional argument,
	% Default value is 20 MHz.
    %
    % OUT
    % phase_ref (vecteur) : Reference phase for the 8 symbols
    % complex
    % phase_cycle (vecteur) : Reference phase for the 8 symbols complex
    % signal (vecteur) : Complex reference signal of the preamble
    % fs (integer) : Sampling frequency used to create the
	% Reference vectors
    %
    % gen_phase(fs) Generates the reference signal in order to
	% To compensate for the effects of the channel, and to recover
	% Consistent signal.
    %
    % TODO:
    % Adjust the code for a sampling frequency other than 20
    % MHz
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    
if nargin < 1
   fs = 20e6;
end
fc = 2e6;
ts = 1/fs;

%Tc given in the IEEE standard
tc = 1/fc;
ratio = tc/ts;

% Init preamble
preambule = [ 1 1 0 1 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 1 0 1 1 1 0 ];

% Init i & Q
I = preambule(1:2:end);
Q = preambule(2:2:end);

% Transfer to NRZ
I = I*2 - 1; Q = Q*2 - 1;

% Creation of pulse shaping in sin
k = (0:ts:2*tc-ts);
pulse_shape = sin((pi.*k)/(2*tc)); 
pulse_shape = repmat(pulse_shape(:)', 16, 1); 

% Oversamplage of I & Q and blocker order 0
Iup = repmat(I(:)', 2*ratio, 1); 
Qup = repmat(Q(:)', 2*ratio, 1); 

% Signal pulse shaping
Iup = Iup.*pulse_shape'; Qup = Qup.*pulse_shape';

% Wave shaping
Iup = reshape(Iup,[1,16*2*ratio]);
Qup = reshape(Qup,[1,16*2*ratio]);

% Repeat the matrix for the 8 symbols
I8up = repmat(Iup,1,8); Q8up = repmat(Qup,1,8);

% Application of 90 degree offset on Q for reference only
Iup(end+10) = 0;
Qup(end+10) = 0;
Qup = circshift(Qup,[0,10]);
%Construction of a phase cycle
signal = Iup + 1i.*Qup; phase_cycle = unwrap(angle(signal));
phase_cycle(320:330) = []; phase_cycle(1:10) = [];

% Applying the 90 degree offset on Q
I8up(end+10) = 0;
Q8up(end+10) = 0;
Q8up = circshift(Q8up,[0,10]);

% Complex signal shaping
signal = I8up + 1i.*Q8up;

% Creation of the theoretical phase
phase_ref = unwrap(angle(signal));
phase_ref(1:10) = [];
end