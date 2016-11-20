clc
% clear all
close all
% data_location = 'U:\MAHAB\Ph.D._Files\Project_files_from_Mathieu_and_Guaillume\données expérimentales\Data\2016-06-09';
% [dataout,dataout_NC,dataraw,indices] = data_recover(data_location);
% 
% [dataout] = cell_cleaner(dataout);
[dataout] = cellarray_filter(dataout);
asasdas
[dataout_NC] = cell_cleaner(dataout_NC);
[dataout_NC] = cellarray_filter(dataout_NC);

[dataraw] = cell_cleaner(dataraw);
[dataraw] = cellarray_filter(dataraw);



[F_a,F_phi,F_f] = gen_stat(dataout,1)
[vect_out_m_a,vect_out_a] = stat_retrieve(F_a)
[vect_out_m_phi,vect_out_phi] = stat_retrieve(F_phi)
[vect_out_m_f,vect_out_f] = stat_retrieve(F_f)

size(vect_out_a)



