load training.mat
we = training(:,1:4); we = we';
wy = training(:,6:end); wy = wy';
%net = newff(we,wy,[4],{'logsig', 'purelin'});
net = newff(minmax(we),[8 2],{'tansig', 'logsig'},'traingd');
%net.inputweights{1,1}.initFcn = 'rands';
%net.biases{1}.initFcn = 'rands';
net = init(net); % inicjujemy wagi losowo
net.trainParam.epochs = 100000;

