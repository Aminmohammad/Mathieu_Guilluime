
function [vect_out_m,vect_out] = stat_retrieve(cellin)

    % [vect_out,vect_out_m] = stat_retrieve(cellin)
    % =====================================================================
    % IN
	% Cellin (cellarray): cellarray containing statistics for each
	% preambles
	%
	% OUT
	% Vect_out_m (vector): average statistic arranged in column
	% Vect_out (vector): statistics arranged in column
	%
	% Disposition: VAR SKEW KURT
	%
	% Stat_retrieve (cellin): utility that retrieves statistics in
	% The cellarrays for diposing them into a vector.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
cellin = cellfun(@transpose,cellin,'un',0);
vecttemp = cell2mat(cellin);
vecttemp = vecttemp';

% recovery of variance
vec_var = vecttemp(:,1:33);
vec_var = vec_var';
vec_var_m = mean(vec_var);
vec_var = reshape(vec_var,[1 prod(size(vec_var))]);

% recovery of skewness
vec_skew = vecttemp(:,34:66);
vec_skew = vec_skew';
vec_skew_m = mean(vec_skew);
vec_skew = reshape(vec_skew,[1 prod(size(vec_var))]);

% recovery of kurtosis
vec_kurt = vecttemp(:,67:99);
vec_kurt = vec_kurt';
vec_kurt_m = mean(vec_kurt);
vec_kurt = reshape(vec_kurt,[1 prod(size(vec_var))]);

% Output vector
vect_out_m = [vec_var_m' vec_skew_m' vec_kurt_m'];
vect_out = [vec_var' vec_skew' vec_kurt'];


end