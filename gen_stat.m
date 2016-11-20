function [F_a,F_phi,F_f] = gen_stat(cellin,bool)
    
    % function [F_a,F_phi,F_f] = gen_stat(cellin,bool)
    % =====================================================================
    % IN
    % cellin (cellarray) : Vector containing the preamble
	% Bool (bool): True (1) if you want the stats. Normalized, False (0)
	% If we want the stats. Not standardized.
    %
    % OUT
    % F_a (cellarray) : Cellarray which contains the stat vector. sure
	% Amplitude
    % F_phi(cellarray): Cellarray which contains the stat vector on the
	% phase
    % F_f (cellarray) : Cellarray which contains the stat vector on the
	% Instantaneous frequency
    %
    % gen_stat(cellin,bool)Transfer the calculation of statistics on
	% Elements contained in these cells, this is a wrapper of two
	% Other scripts.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    tic
    if bool == 1
        [F_a,F_phi,F_f] = cellfun(@stat_computation_N,cellin,'un',0);
    else
        [F_a,F_phi,F_f] = cellfun(@stat_computation,cellin,'un',0);
    end
    toc
end