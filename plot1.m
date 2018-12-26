
%sxhma gia kathe shma arithmou korufwn vs timwn kerdous 
 f = figure(1);
 for i=1:8
 ax(i) =  subplot(4,2,i);
 plot( ker(i,1:length(g(i,:))),g(i,:));
 title(sprintf('Signal %d', i)); 
 ylabel("Number of Peaks");
 xlabel("k");
 %saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
   hold on
 plot( k(i),g(i,index(i)),'r*')
 
 end
 
  f = figure(2);
 for i=1:8
 ax(i) =  subplot(4,2,i);
 plot( ker(i,1:length(g(i,:))),gradient(g(i,:)));
 title(sprintf('1st der of %d', i)); 
 ylabel("Number of Peaks");
 xlabel("k");
 %saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
   hold on
 plot( k(i),g(i,index(i)),'r*')
 
 end
 
   f = figure(3);
 for i=1:8
 ax(i) =  subplot(4,2,i);
 sec_der(i,:)= gradient(gradient(g(i,:)));
 smoothed(i,:)=smooth(sec_der(i,:),0.1,'loess');
 plot( ker(i,1:length(g(i,:))),smoothed(i,:));
 title(sprintf('2nd der of %d', i)); 
 ylabel("Number of Peaks");
 xlabel("k");
 %saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
   hold on
 %plot( k(i),g(i,index(i)),'r*')
 plot( k(i),0,'r*')
 end
 
 
    f = figure(4);
 for i=1:8
 ax(i) =  subplot(4,2,i);
 plot( ker(i,1:length(g(i,:))),smoothed(i,:));
 title(sprintf('2nd der of %d', i)); 
 ylabel("Number of Peaks");
 xlabel("k");
 %saveas(f,sprintf('kerdos_shmatos_%d',i),'png');
   hold on
 %plot( k(i),g(i,index(i)),'r*')
 plot( k(i),0.5*smoothed(i,index(i)),'r*')
 end