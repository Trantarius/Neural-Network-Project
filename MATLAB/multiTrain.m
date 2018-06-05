reps=1;
delays=7;
neuronArray=[6 6];
samplenet=narnet(1:delays,neuronArray);
samplenet.trainfcn='trainscg';
samplenet=train(samplenet,x,x);
regnets=cell(1,reps);
extrapolateDepth=1;
for n=1:reps
    net=narnet(1:delays,neuronArray);
    net=trainscg(net,x(1:600),x(1:600),nnSimple);
    regnets{n}=net;
end
regperfs=zeros(1,reps);
for n=1:reps
    figure(1);
    [~,regperfs(n)]=nthExtrapolate(7,cell2mat(x(600:end)),regnets{n},true);
end

extranets=cell(1,reps);
extrapolateDepth=5;
for n=1:reps
    net=narnet(1:delays,neuronArray);
    net.trainParam.mu_inc=2;
    net.trainParam.mu_max=10^100;
    net=trainscg(net,x(1:600),x(1:600),nnSimple);
    extranets{n}=net;
end
extraperfs=zeros(1,reps);
for n=1:reps
    figure(2);
    [~,extraperfs(n),RVAL]=nthExtrapolate(7,cell2mat(x(600:end)),extranets{n},true);
end
clear('reps');
clear('delays');
clear('samplenet');
clear('extrapolateDepth');
clear('net');
clear('n');