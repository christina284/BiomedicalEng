%% Ερώτημα 2.1
Data_Eval = struct('data',{},'spikeClass',{},'spikeTimes',{});
s = zeros(1,4);

for i=1:4
    Data_Eval(i) = load(['Data_Eval_E_' num2str(i) '.mat']);
    s(i)= median(abs(Data_Eval(i).data(:))/0.675 , 1);
end

figure;

for i=1:4
    subplot(2,2,i);
    plot( Data_Eval(i).data(1:10000) );
    title(sprintf('Signal %d, σ=%f', i, s(i) )); 
    ylabel("Amplitude");
    xlabel("Samples");
end

clearvars('i');

step = 100;
k_array = zeros(4,step);
g = zeros(4,step);
k = struct('idx',{},'val',{});

for i=1:4    %gia kathe shma
    data_max = max(Data_Eval(i).data(:));
    k_max = 5;
    k_step = k_max / (step);
    k_min = k_step;
    k_array(i,:) = k_min :k_step: k_max;
    
    for x = 1:step 
        T = k_array(i,x) * s(i); %O tupos gia to threshold 
        %vriskw ton arithmo ton korufwn panw apo to threshold T
        %arithmos peaks gia to shma i gia kathe kerdos x
        fprintf("Data_Eval(%d) [max_data=%f], testing for k=%f,T=%f  %dof%d\n",...
            i,data_max,k_array(i,x),T,x,step);
        g(i, x) = length(findpeaks(Data_Eval(i).data(:),...
            'MinPeakHeight',T));
    end
end

clearvars('i','k_max','k_min','k_step','T','x');

figure;
for i=1:4
    subplot(2,2,i);
    plot( k_array(i,:) , g(i,:) );
    title(sprintf('Signal %d', i)); 
    ylabel("Number of Peaks");
    xlabel("k");
end
 

g_der1  = zeros(4,step);
g_der1s = zeros(4,step);
g_der2  = zeros(4,step);
g_der2s = zeros(4,step);

for i=1:4
    g_der1 (i,:) = gradient (g(i,:));
    g_der1s(i,:) = g_der1(i,:)./min(g_der1(i,:));
    g_der2 (i,:) = gradient (g_der1(i,:));
    g_der2s(i,:) = g_der2(i,:)./min(g_der2(i,:)); % delete
    
    % εν τέλη καλύτερος ήταν απλότερος κανόνας του μηδενισμού της 2ης παρ.
    temp = find (g_der1s(i,:)<0.2,1);
    for n=temp:step-1
        if g_der2(i,n)*g_der2(i,n+1)<=0
            k(i).val = k_array(i,n);
            k(i).idx = n;
            break;
        end
    end
end

figure;
for i=1:4
    subplot(2,2,i);
    plot( k_array(i,:) , g_der1s(i,:) );
    title(sprintf('Signal %d', i)); 
    ylabel("special (NP)'");
    xlabel("k");
    hold on;
    plot( k(i).val , g_der1s(i,k(i).idx),'r*');
    hold off;
end
figure;
for i=1:4
    subplot(2,2,i);
    plot( k_array(i,:), g_der2(i,:) );
    title(sprintf('Signal %d', i));
    ylabel("(NP)''");
    xlabel("k");
    hold on;
    plot( k(i).val , g_der2(i,k(i).idx),'r*');
    hold off;
end

%% Ερώτημα 2.2

n=0;
SpikesEst = struct('num',{},'loc',{},'wave',{},'d',{},'eval_idx',{},...
    'incorrect',{});

for i=1:4
    T = k(i).val * s(i);
    [~,SpikesEst(i).loc]=findpeaks(Data_Eval(i).data(:),...
            'MinPeakHeight',T);
    SpikesEst(i).num = length(SpikesEst(i).loc);
    SpikesEst(i).wave = zeros(SpikesEst(i).num,64);
    for j=1:SpikesEst(i).num
        SpikesEst(i).wave(j,:) = Data_Eval(i).data(...
            SpikesEst(i).loc(j)-31:SpikesEst(i).loc(j)+32);
    end
end

figure;
for i=1:4
    subplot(2,2,i);
    hold on;
    for j=1:SpikesEst(i).num
        plot(SpikesEst(i).wave(j,:));
    end
    hold off;
end

%% Ερώτημα 2.3
diff = -21; % η προβλέψεις μας, εκτιμάται πως έχουν διαφορά 21 στοιχεία
            % από τους χρόνουν όπου δίνονται.

for i=1:4
    SpikesEst(i).d = zeros(1,SpikesEst(i).num);
    SpikesEst(i).eval_idx = zeros(1,SpikesEst(i).num);
    SpikesEst(i).incorrect=0;
    for j = 1:SpikesEst(i).num
        test = find((Data_Eval(i).spikeTimes>=SpikesEst(i).loc(j)+diff-31)& ...
            (Data_Eval(i).spikeTimes<=SpikesEst(i).loc(j)+diff+32),1);
        if (test)
            SpikesEst(i).eval_idx(j)=test;
            SpikesEst(i).d(j)=Data_Eval(i).spikeTimes(test)-diff-SpikesEst(i).loc(j);
        else
            SpikesEst(i).d(j)=33;
            SpikesEst(i).incorrect=SpikesEst(i).incorrect+1;
        end
    end
end


figure;
for i=1:4
    subplot(2,2,i);
    plot (sort(SpikesEst(i).d));
    title(sprintf('Signal %d, errors %d', i, SpikesEst(i).incorrect));
end

% το γράφημα δείχνει πόση διαφορά είχε η πρόβλεψη μας από το πραγματικό
% η ευθεία στο ύψος 33 είναι τα στοιχεία όπου βρέθηκαν εσφαλμένα.


%% Ερρώτημα 2.4

SpikesClass = struct('data',{},'group',{});

for i=1:4
    n=0;
    SpikesClass(i).data = zeros(2,SpikesEst(i).num-SpikesEst(i).incorrect);
    for j=1:SpikesEst(i).num
        if SpikesEst(i).d(j)<33
            n=n+1;
            SpikesClass(i).data(1,n) = rms(SpikesEst(i).wave(j,:));
            SpikesClass(i).data(2,n) = max(gradient(SpikesEst(i).wave(j,:)));
            SpikesClass(i).group(n)=Data_Eval(i).spikeClass ...
                (SpikesEst(i).eval_idx(j));
        end
    end
end

figure;
for i=1:4
    subplot(2,2,i);
    scatter (SpikesClass(i).data(1,:),SpikesClass(i).data(2,:),20,...
        SpikesClass(i).group);
    title(sprintf('Signal %d, rms and max', i));
end

% παρατηρείται πως για τα features όπου διαλέξαμε, οι κατηγορίες μπορούν
% να διαχωριστούν.

%% Ερρώτημα 2.5a
addpath('hzlasha/Code/');
eval_sum = 0;
for i=1:4
    eval =MyClassify(SpikesClass(i).data',SpikesClass(i).group');
    fprintf("Classification Accuracy:%.2f%% for signal %d\n",eval,i);
    eval_sum = eval_sum + eval;
end
fprintf("========  Total accuracy = %.2f%%  ========\n",eval_sum/4);

%% Ερρώτημα 2.5b
for i=1:4
    n=0;
    SpikesClass(i).data_extra = zeros(2,SpikesEst(i).num-SpikesEst(i).incorrect);
    for j=1:SpikesEst(i).num
        if SpikesEst(i).d(j)<33
            n=n+1;
             SpikesClass(i).data_extra(1,n) = max(SpikesEst(i).wave(j,:));
             SpikesClass(i).data_extra(2,n) = min(gradient(...
                 gradient(SpikesEst(i).wave(j,:))));
        end
    end
end

eval_sum = 0;
for i=1:4
    eval =MyClassify([SpikesClass(i).data',SpikesClass(i).data_extra'],...
        SpikesClass(i).group');
    fprintf("Classification Accuracy:%.2f%% for signal %d\n",eval,i);
    eval_sum = eval_sum + eval;
end
fprintf("========  Total accuracy = %.2f%%  ========\n",eval_sum/4);

% υπάρχει βελτίωση ~12% με την προσθήκη του μεγήστου του spike και του
% ελλαχίστου της 2ης παραγώγου.

% πράγματα που δεν προσφέραν βελτίωση ήταν:
% το zero crossings
% το min του spike
% το max της 2ης παραγώγου
% το min τηνς 1ης παραγώγου
% το ολοκλήρωμα του spike
