function [d_mean,d_min,d_max] = dist_compute(vectin)

    % function [d_mean,d_min,d_max] = dist_compute(vectin)
    % =====================================================================
    % IN
	% Vectin (vector): vector with data arranged in columns
	%
	% OUT
	% D_mean (float): average distance
	% D_min (float): minimum distance
	% D_max (float): maximum distance
	%
	% Dist_compute (vectin) calculates the Euclidean distance
	% Between all points of the vectors to then calculate the mean and
	% Retrieve the minimum and maximum value.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    pair = nchoosek(1:length(vectin),2);
    x1 = vectin(pair(:,1),:,:);
    x2 = vectin(pair(:,2),:,:);
    x = x1 - x2; x = sum(x,2);
    x = x.^2; x = sqrt(x);
    d_mean = mean(x);d_min = min(x);d_max = max(x);
end