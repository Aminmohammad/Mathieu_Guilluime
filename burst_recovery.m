
function [cellout] = burst_recovery(vectin)

    % function [cellout] = burst_recovery(vectin)
    % =====================================================================
    % IN
    % vectin (vecteur) : vecteur contenant plusieurs burst de communication
    % zigbee
    %
    % OUT
    % cellout (cellarray) : cellarray contenant chaque communication zigbee
    % séparé
    %
    % burst_recovery(vectin): recupère les bursts de communications zigbee
    % dans les vecteurs provenant du USRP. Cette fonction retourne chaque 
    % burst de communication dans une cellule d'un cellarray.
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016
    
    % recupération du data != 0
    indices = find(vectin);
    vectin = vectin(indices); 
    vectin = full(vectin)';
    
    % on trouve les indices de différents paquets
    d_indices = diff(indices);
    [~,loc_indice] = findpeaks(d_indices,'Threshold',1e3);
    
    % init des variable pour l'insertion des 0
    padding = zeros(1,100); 
    long = length(loc_indice);
    cell_temp = cell(1,long);
    
    for i = 1:1:long;
        if i == 1
           cell_temp{i} = vectin(1:loc_indice(i));
        elseif i == long
            cell_temp{i} = vectin(loc_indice(i):end);
        else
            cell_temp{i} = vectin(loc_indice(i):loc_indice(i+1));
        end
    end
    
    % We put the passage between the vectors.
    vectin = cellfun( @(x) [x padding],cell_temp,'un',0);
    vectin = horzcat(vectin{:}); vectin = vectin';

    % calcul de phase
    phase = unwrap(angle(vectin));
    dphase = abs(diff(phase));
    
    % Each of the packets
    [~,loc] = findpeaks(dphase,'MinPeakHeight',0.75,'MinPeakDistance',10e3);
    long = length(loc) - 1;
    cell_int = cell(1,long);
    
    for i = 1:1:long;
        % We put the burst separates in the cell array
        if i < long 
            cell_int{i} = vectin(loc(i):loc(i+1));
        % Management of possible errors at the end of the vector
        elseif i == long
            if length(vectin(loc(i):end)) < 10000
                break
            else
                cell_int{i} = vectin(loc(i):loc(i+1));
            end
        end
    end
    cellout = cell_int;
end