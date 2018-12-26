sumz(4,1)=0;
spikeTimes2 = uint64(spikeTimes2);
neg = 0;
for i=1:4   
    % gia kathe shma
    T2_2(i) = k2(i) * s2(i); 
     %arithmos peaks gia to shma i gia kathe kerdos x
    NumOfSpikes2(i) = length(findpeaks(data2(i,:),'MinPeakHeight',T2_2(i)));

%             
%      %apothikeuw tis xronikes stigmes pou einai ta spikes
    [Spikes(i, 1:NumOfSpikes2(i)), spikeTimesEst(i, 1:NumOfSpikes2(i))]= findpeaks(data2(i,:),'MinPeakHeight',T2_2(i));
%     %for every signal(i), a row for each spike-for spike 1 of first signal the first row 
    %kentrarismenes -- exei panw apo 1 spike omws sta 64 deigmata :/ 
    %plottare tes kiolas
   figure(i)
    for j=1:(sum(spikeTimesEst(i,:)~=0))
        k_j = (-32 + spikeTimesEst(i,j)):(spikeTimesEst(i,j) + 32);
        %valta mes to if
         g_j = (-32 + spikeTimesEst(i,j):length(data2(i,:)));
         p_j = (spikeTimesEst(i,j):(spikeTimesEst(i,j) + 32));
         difference(i,j) = length(data2(i,:)) - spikeTimesEst(i,j);
         
% % %         
       if spikeTimesEst(i,j) > 32
 
                  if ( difference(i,j) > 32 )
                      [value_of_max(i,j), idx_of_max(i,j)] = max( data2( i, k_j ));
                      [value_of_min(i,j), idx_of_min(i,j)] = min( data2( i, k_j ));

                      %thewrw oti to spike ksekinaei 20 deigmata prin to akrotato tou
                      if idx_of_max(i,j) < idx_of_min(i,j)
                         center(i,j) = spikeTimesEst(i,j);
                      else
                         center(i,j) =  spikeTimesEst(i,j) - ( idx_of_max(i,j) -idx_of_min(i,j));
                      end

                 else
                      [value_of_max(i,j), idx_of_max(i,j)] = max( data2( i, padarray(g_j, ( 32 - difference(i,j) ),'past' )));
                      [value_of_min(i,j), idx_of_min(i,j)] = min( data2( i, padarray(g_j, ( 32 - difference(i,j) ),'past' )));

                      %thewrw oti to spike ksekinaei 20 deigmata prin to akrotato tou
                      if idx_of_max(i,j) < idx_of_min(i,j)
                         center(i,j) =  spikeTimesEst(i,j);
                      else
                          center(i,j) =  spikeTimesEst(i,j) - ( idx_of_max(i,j) -idx_of_min(i,j));                    
                      end
      
                 end
        
      else
              [value_of_max(i,j), idx_of_max(i,j)] = max( data2( i, padarray(p_j, ( 32 - spikeTimesEst(i,j) ),'pre' )));
              [value_of_min(i,j), idx_of_min(i,j)] = min( data2( i, padarray(p_j, ( 32 - spikeTimesEst(i,j) ),'pre' )));

              if idx_of_max(i,j) < idx_of_min(i,j)
                 center(i,j) = spikeTimesEst(i,j);
              else
                 center(i,j) =  spikeTimesEst(i,j) - ( idx_of_max(i,j) -idx_of_min(i,j));
              end
      
      end
      
      
% 
%       
           SpikesEst(j,:,i) = data2(i,-32+center(i,j):center(i,j)+32);
% 
           plot( SpikesEst(j,:,i))
           hold on
%erwthma 2.3
%vriskw tin diafora anamesa stis pragmatikes kai autes pou vrhka
      dif(i,j) = length(SpikesEst(:,j,i)) -(spikeTimes2(i,j));

     end

end

