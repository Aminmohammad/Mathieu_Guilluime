function [cellout] = cellarray_filter(cellin)
    % function [cellout] = cellarray_filter(cellin)
    % =====================================================================
    % IN
    % cellin (cellarray) : Cell content of signals
    %
    % OUT
    % cellout (cellarray) : The filtered signals
    %
    % cellarray_filter(cellin) Utility that filters the signals
	% By importing the coefficients.
    %
    % Info: lp coeff -> filter of order 507 with pass = 2 Mhz, f stop = 2.1% MHz
    %
    % TODO:
    % Remove the transistor from the vectors as a function of the order of the
	% filter
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    % Import of coefficients
    load('lp_coeff.mat')
    filt = cell(1,length(cellin));  filt(:) = {lp};
    cellout = cellfun(@conv,cellin,filt,'un',0)
    nb_vect = length(cellout) - 1
    
    for i = 1:1:nb_vect;
        % voir TODO
        cellout{i} = cellout{i}(256:256+2559);
    end
end