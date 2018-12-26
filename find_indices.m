spikeTimesEst = zeros(4,327);
breakpoints = zeros(4, 20);
for i=1:4
    %vriskw 2h paragwgo kai kanw smooth
     sec_der2(i,:)= gradient(gradient(g2(i,:)));
     smoothed2(i,:)=smooth(sec_der2(i,:),0.1,'loess');
     %vriskw ta shmeia sta opoia h kampili einai megaluteri apo to 0.5 ti
     %tou max tis
     [~,x] = find(smoothed2(i,:)>0.2*max(smoothed2(i,:)));
     %vriskw to shmeio to 2o pou isxuei auto kai lew oti einai to neo k
     %kathws to vrhka me ton kanona
     indxes(i) = x(end);
     plot(smoothed2(i,:));
     hold on
     %sxediazw to prwto shmeio pou spaei ->peftei katw apo 0.5%
     plot(indxes(i),smoothed2(i,indxes(i)),'r*')
     %to kerdos einai iso me to kerdos sta nea indxes
     k2(i)=ker2(i,indxes(i));
end
