
for i=1:4
 load(['Data_Eval_E_' num2str(i) '.mat']);
 data2(i,:) = data;
 s2(i)= median(abs(data2(i))/0.675 , 1);
 spikeTimes2(i,1:length(spikeTimes))= spikeTimes;
 spike_Class(i, 1:length(spikeClass)) = spikeClass;
end
find_peaks2
find_indices
find_peaks_3
