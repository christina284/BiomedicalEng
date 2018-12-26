 %kumatomorfh gia kathe shma arithmou korufwn vs timwn kerdous 
  f = figure(5);
 for i=1:4
   ax(i) =  subplot(2,2,i);
   plot( ker2(i,1:length(g2(i,:))),g2(i,:));
   title(sprintf('Signal %d', i)); 
   ylabel("Number of Peaks");
   xlabel("k");
   parag(i,:)=gradient(g2(i,:));
   prwto_akr(:,i)=find(parag(i,:)==0,  1,'first');
%  saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
%  hold on
%  TF1(i,:) = imregionalmin(g2(i,:));%problemmmmmm 
%  hey(i) = find(TF1(i,:)==1);
%  plot(ker2(i,1:length(g2(i,:))),g2(i,:),ker2(i,1:length(g2(i,TF1))),g2(i,TF1))
  end
 
