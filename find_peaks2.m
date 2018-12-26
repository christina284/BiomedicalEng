for i=1:4
    maxj2(i) = max(data2(i,:))/s2(i);
end
for i=1:4    %gia kathe shma
     j = [0:0.1:maxj2(i)];
    for x = 1:length(j) 
        %vriskw gia ola ta k ta spikes
        ker2(i,x) = j(x);
        T2(i,x) = j(x) * s2(i); 
        %arithmos peaks gia to shma i gia kathe kerdos x
        g2(i, x) = length(findpeaks(data2(i,:),'MinPeakHeight',T2(i,x)));        
    end    
end
