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


