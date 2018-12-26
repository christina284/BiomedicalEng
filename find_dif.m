for i = 1 : 4
    not_zero(i,:) = spike_Class(i,:)~=0;
    len(i) = (sum(not_zero(i,:)));
end