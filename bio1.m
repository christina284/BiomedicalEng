%% Ερώτημα 1.1
Data_Test = struct('data',{},'spikeNum',{});
s = zeros(1,8);

for i=1:8
    Data_Test(i) = load(['Data_Test_' num2str(i) '.mat']);
    s(i)= median(abs(Data_Test(i).data(:))/0.675 , 1);
end

figure;

for i=1:8
    subplot(4,2,i);
    plot( Data_Test(i).data(1:10000) );
    title(sprintf('Signal %d, σ=%f', i, s(i) )); 
    ylabel("Amplitude");
    xlabel("Samples");
end

clearvars('i','ax');

%erwthma 1.1 parathroume oti auksanetai o thoruvos

%% Ερώτημα 1.2

step = 100;
k_array = zeros(8,step);
g = zeros(8,step);
k_optimal = struct('idx',{},'val',{});

for i=1:8    %gia kathe shma
    data_max = max(Data_Test(i).data(:));
    k_max = data_max / s(i);
    k_step = k_max / (step+1);
    k_min = k_step;
    k_array(i,:) = k_min :k_step: k_max-k_step;
    
    for x = 1:step 
        T = k_array(i,x) * s(i); %O tupos gia to threshold 
        %vriskw ton arithmo ton korufwn panw apo to threshold T
        %arithmos peaks gia to shma i gia kathe kerdos x
        fprintf("Data_Test(%d) [max_data=%f], testing for k=%f,T=%f  %dof%d\n",...
            i,data_max,k_array(i,x),T,x,step);
        g(i, x) = length(findpeaks(Data_Test(i).data(:),'MinPeakHeight',T));
    end
    [~,k_optimal(i).idx]=min(abs(Data_Test(i).spikeNum-g(i,:)));
    k_optimal(i).val =  k_array(i,k_optimal(i).idx);
end

clearvars('i','k_max','k_min','k_step','T','x','s');

figure;
for i=1:8
    subplot(4,2,i);
    plot( k_array(i,:) , g(i,:) );
    title(sprintf('Signal %d', i)); 
    ylabel("Number of Peaks");
    xlabel("k");
    hold on;
    plot( k_optimal(i).val , g(i,k_optimal(i).idx),'r*');
    hold off;
 end

%% Ερρώτημα 1.3

g_der1  = zeros(8,step);
g_der2  = zeros(8,step);
g_der2s = zeros(8,step);

for i=1:8
    g_der1 (i,:) = gradient (g(i,:));
    g_der2 (i,:) = gradient (g_der1(i,:));
    g_der2s(i,:) = g_der2(i,:)./min(g_der2(i,:));
end

figure;
for i=1:8
    subplot(4,2,i);
    plot( k_array(i,:), g_der1(i,:) );
    title(sprintf('Signal %d', i));
    ylabel("(NP)'");
    xlabel("k");
    hold on;
    plot( k_optimal(i).val , g_der1(i,k_optimal(i).idx),'r*');
    hold off;
end

figure;
for i=1:8
    subplot(4,2,i);
    plot( k_array(i,:), g_der2(i,:) );
    title(sprintf('Signal %d', i));
    ylabel("(NP)''");
    xlabel("k");
    hold on
    plot( k_optimal(i).val , g_der2(i,k_optimal(i).idx),'r*');
end

figure;
for i=1:8
    subplot(4,2,i);
    plot( k_array(i,:), g_der2s(i,:) );
    title(sprintf('Signal %d', i));
    ylabel("special (NP)''");
    xlabel("k");
    hold on
    plot( k_optimal(i).val , g_der2s(i,k_optimal(i).idx),'r*');
    plot( k_array(i,:),ones(step)*(-.5) );
end

clearvars('i');