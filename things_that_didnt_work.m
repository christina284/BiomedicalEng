%       elseif  ( length(data2(i,:)) -  center(i,j) < 32 )
%           a = 32-center(i,j) +1;
%           recenter=padarray(data2(i,:),[0 a],'past');
%           SpikesEst(j,:,i)=recenter(i,-32+center(i,j)+a:center(i,j)+a+32);
%           plot( SpikesEst(j,:,i))
%           hold on
%       else 
%           a = 32-center(i,j) +1;
%           recenter=padarray(data2(i,:),[0 a],'pre');
%           SpikesEst(j,:,i)=recenter(i,-32+center(i,j)+a:center(i,j)+a+32);
%           plot( SpikesEst(j,:,i))      
%           hold on
%       end
% 
%     end
%     hold off
%      
%      
     
     %find overlap
%     for j = 1:NumOfSpikes2(i)
%        SpikesEst(j,:,i) = data2(i, -32+spikeTimesEst(i,j):32+spikeTimesEst(i,j));
%        spots = find(SpikesEst(j,:,i)>0.5);
%        if sum(spots<20) > 0 
%            sumz(i) = sumz(i) + 1;
%            spikes_ovl(i,j)=1;
%        end
%        plot(SpikesEst(j,:,i))
%        hold on







%     for m = 1:length(data2(i,:))
%         if data2(i,:) < (-T2_2(i))
%             neg = neg + 1;
%             idx_of_neg(i,:) = m;
%         end
%     end
    