 function [dataout,dataout_NC,dataraw,indices] = data_recover(data_location,fs)

    % function [dataout,dataraw,indices] = data_recover(data_location,fs)
    % =====================================================================
    % IN
    % data_location (string): Path to the directory where the
	% ".mat" files to import into matlab.
    % fs (float) (optionnel): Sampling frequency with which
	% Zigbee signals were sampled. Optional argument,
	% Default value is 20 MHz.
    %
    % OUT
    % dataout       (cellarray) : Cellarray containing the compensated preambles
    % dataout_NC (cellarray) : Cellarray containing uncompensated preambles
    % dataraw       (cellarray) : Cellarray containing full zigbee signals
    % indices        (vecteur)   : The content of the indices from which the
	% Beginnings of preambles in dataraw
    %
    % data_recover(data_location,fs): This function is the hand that
	% Performs all operations to retrieve the preambles
	% Synchronized.
    %
    % TODO 
    % - Ensure that all sub-scripts can work with a fs
	%   Different from 20 MHz
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016

    % on va chercher le data
    data = getfile(data_location);
    disp('Data imported')
    % recupère les burst
    
    dataraw = cellfun(@burst_recovery,data,'un',0); clear data;    
    dataraw = horzcat(dataraw{:});
    disp('Burst recovered')
    tic;
    % Recovery of the indices
    if nargin == 2
        l = length(dataraw); fss = cell(1,l); fss(:) = {fs};
        indices = cellfun(@trig_preambule,dataraw,fss,'un',0);
        indices = cell2mat(indices);
    else
        indices = cellfun(@trig_preambule,dataraw,'un',0);
        indices = cell2mat(indices);
    end
    toc;
    disp('Preambule recoverd')
    % compensation en phase
    nb_vect = length(dataraw);
    dataout = cell(1,nb_vect);
    dataout_NC = cell(1,nb_vect);
    tic;
    for i = 1:1:nb_vect;
        if nargin == 2            
            [dataout{i},nb_echantillon] = comp(dataraw{i},indices(i),fs);
            dataout_NC{i} = dataraw{i}(indices(i):indices(i)+nb_echantillon);
        else
            [dataout{i},nb_echantillon] = comp(dataraw{i},indices(i));
            dataout_NC{i} = dataraw{i}(indices(i):indices(i)+nb_echantillon);
        end
    end
    dataraw = dataraw(~cellfun('isempty',dataout));     
    dataout_NC = dataout_NC(~cellfun('isempty',dataout));     
    dataout = dataout(~cellfun('isempty',dataout));
    indices = indices(find(indices));
    toc;
    disp('Signal recovered')
 end