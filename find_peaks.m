%initialize maxj matrix
maxj = zeros(1,8);
for i=1:8
    maxj(i) = max(data1(i,:))/s(i);
end

for i=1:8    %gia kathe shma
   j = [0:0.1:maxj(i)];
    for x = 1:length(j) 
        %pinakas p krataei tis times kerdous gia kathe shma
        ker(i,x) = j(x);
        T(i,x) = j(x) * s(i); %O tupos gia to threshold 
        %vriskw ton arithmo ton korufwn panw apo to threshold T
        %arithmos peaks gia to shma i gia kathe kerdos x
        g(i, x) = length(findpeaks(data1(i,:),'MinPeakHeight',T(i,x))); 
%         
%         if g(i,x) < spikeNum1(i) - 100 %an to kseperasei ta peaks kata 100 , kofto
%             break;
%         end
     for p=1:x
      %vriskw tin elaxisti diafora metaksi tou arithmou peaks 
      %pou thelw kai autwn pou exw ston pinaka g                
        [val,idx]=min(abs(spikeNum1(i)-g(i,:)));
          index(i)=idx;
          k(i) =  ker(i,idx);

     end
    end

end
