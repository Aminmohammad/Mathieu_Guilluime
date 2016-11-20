function [cellout] = cell_cleaner(cellin)

    % function [cellout] = cell_cleaner(cellin)
    % =====================================================================
    % IN
    % cellin (cellarray)   : Cellarray containing the compensated preamble
    %
    % OUT
    % cellout (cellarray) : Cellarray containing the compensated preamble
    %
    % cell_cleaner(cellin)) Calculates the success rate for the
	% Compensation via function bench_test (cellin). The
	% Cells whose compensation was not successful.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    [~,max] = bench_test(cellin);
    
    % seuil de réussite de la compensation
    ind = find(max < 800);
    
    cellin(ind) = [];
    cellout = cellin(~cellfun('isempty',cellin));
end