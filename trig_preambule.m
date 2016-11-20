function [indice,dphase] = trig_preambule(vectin,fs);
    
    
    % function [indices,dphase] = trig_preambule(vectin)
    % =====================================================================
    % IN
    % vectin (vecteur) : signal de communication
    % fs (integer): Sampling frequency with which the signals
    % Zigbee were sampled
    %
    % OUT
    % indice (integer) :Index of the vectin vector with respect to the beginning
    % Of preamble
    % dphase (vecteur) : Phase variation vector
    %
    % trig_preambule(vectin) Finds the beginning of the preamble of the
	% Zigbee signal of an input vector by returning the index where
	% Locates the preamble, as well as the phase variation vector. We
	% Correlates the theoretical phase change with the
	% Practical phase variation to find the beginning of the preamble.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016

   % calcul de la phase du signal d'entrée
   phase = unwrap(angle(vectin));
   
   % calcul de la différence de phase 
   dphase = diff(phase); dphase = dphase';
   
   % génération de la phase théorique
   [~,p1ref,~,fs] = gen_phase();
   
   % calcul de la différence de phase théorique
   dp = diff(p1ref);
  
   % calcul de la correlation
   convolution = conv(full(dphase),fliplr(dp));
   
   % At the beginning of the vector
   t = (20e-6)*fs; t = int32(t);
   convolution(1:t) = 0;
   
   % TODO
   % The preamble should be approximately in the first 300 seconds
   %t = (300e-6)*fs; t = int32(t);
   %convolution(t:end) = 0;
   
   % We find the first Peak
   [~,loc] = findpeaks(convolution,'MinPeakHeight',4,'NPeaks',1); clear peaks;
   
   % We remove the length to find the beginning
   l = length(p1ref);
   indice = loc - l;

end