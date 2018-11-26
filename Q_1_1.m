clear all
%Read Data and initialize matrices
dataTot = zeros(8,1000);
spikeNum1 = zeros(1,8);
% 

for i=1:8 
 load(['Data_Test_' num2str(i) '.mat']);
 dataTot(i,:) = data(1:1000);
 data1(i,:) = data;
 spikeNum1(i) = spikeNum;
%  h = figure;
%  plot(data(1:1000));
%  saveas(h,sprintf('data_%d',i),'epsc');
 s(i)= median(abs(data(i))/0.675 , 1);
end
%erwthma 1.1 parathroume oti auksanetai o thoruvos

%initialize maxj matrix
maxj = zeros(1,8);
for i=1:8
    maxj(i) = max(data1(i,:))/s(i);
end
%ker = zeros(8,ceil(max(maxj))/0.1);
for i=1:2    %gia kathe shma
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
%         Thres(i)=T(i,idx);
%         k(i) = Thres(i)/s(i);
          k(i) =  ker(i,idx);

     end
    end
 %sxhma gia kathe shma arithmou korufwn vs timwn kerdous 
 if i==1 
 f = figure;
 end
ax(i) =  subplot(4,2,i);
 plot( ker(i,1:length(g(i,:))),g(i,:));
 title(sprintf('Signal %d', i)); 
 ylabel("Number of Peaks");
 xlabel("k");
 XData(i,:)=get(get(gca,'children'),'XData');
 YData(i,:)=get(get(gca,'children'),'YData');
%  %saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
%  dy = diff(YData)./diff(XData);
%  delta = abs(dy - YData(2:end));
%  percentageDiff = delta ./ YData(2:end);
   hold on
%plot(XData(2:end),dy)
%hold on
 plot( k(i),g(i,idx),'r*')
% hor(i) = line([0, 12], [g(i,idx),g(i,idx)]); 
% ver(i) = line( [k(i) k(i)],[-50000, 50000]);
 %par_ref(i) = XData(dy == 1);
% par(i) = dy(XData == k(i));;
end
