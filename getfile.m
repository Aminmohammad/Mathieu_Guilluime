function [data] = getfile(data_location)
   
    % function [data] = getfile(data_location)
    % =====================================================================
    % IN
    % data_location (string): path vers le répertoir où se situe les
    % fichiers ".mat" à importer dans matlab.
    %
    % OUT
    % data (cellarray) : cellarray contenant dans chaque cellule le contenu
    % d'un fichier ".mat"
    %
    % getfile(data_location) permet d'importer les fichiers ".mat" des
    % signaux captés avec le SDR, il retourne un cellarray contenant le
    % contenue de chaque fichier mat dans une cellule
    % =====================================================================
    % Author: Mathieu Lévesque (c)
    % Laboratory : LRTS - Laval University
    % Last Modification: 15/08/2016


    tic
    % on recupere le path present
    path = pwd;
    
    
    cd(data_location);
    
    matFiles = dir('*.mat'); 
    numfiles = length(matFiles);
    mydata = cell(1, numfiles);
    
    % recupération du data dans une cellarray
    for k = 1:numfiles 
        mydata{k} = load(matFiles(k).name); 
    end
    mydata = cellfun(@struct2cell,mydata);
    
    cd(path);
    data = mydata;
    toc;
end