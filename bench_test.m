function [corel,max_corel,min_corel,loc] = bench_test(cellin)
    % function [corel,max_corel,min_corel,loc] = bench_test(vectin)
    % =====================================================================
    % IN
    % cellin (cellarray) : cellarray contenant les préambules compensées
    %
    % OUT
    % corel (cellarray) : cellarray contenant les résultats de la
    % convolution
    % max_corel (vecteur): Cellarray containing the results of
	% convolution
    % min_corel (integer) : Minimum correlation in the maximums of
    % correlations
    % loc (integer) : Index of the variable min_corel
    %
    % bench_test(cellin): Correlates between Part I of the
	% Reference signal and I of the compensated signals. One can then
	% See what signals have been difficult to compensate.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016

    [pref,pc,signal] = gen_phase(); clear pref pc;
    
    
    nb_vect = length (cellin) - 1;
    corel     = cell     (1,nb_vect);
    
    tic;
    % The correlation is applied to Part I
    for i = 1:1:nb_vect;
        corel{i} = conv(real(full(cellin{i})),fliplr(real(signal)));
    end
    toc;
    % We find the max of correlation
    max_corel = cellfun(@max,corel,'un',0); max_corel = cell2mat(max_corel);
    % We find the minimun of correlation therefore the place or the compensation
	% Was the least effective
    [min_corel,loc] = min(max_corel);
end