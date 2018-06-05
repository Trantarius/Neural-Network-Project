layers=3;
lstart=1;
neurons=7;
nstart=1;
delays=7;
dstart=1;
trainSize=750;%the first this many data points will be used for training, the rest for testing. 
%validation data is taken out of the training portion
c=0;
reps=10;
nets=cell(layers,neurons,delays,reps);
err=nets;
coefs=nets;
for r=1:reps
for i=lstart:layers+lstart-1
    for n=nstart:neurons+nstart-1
        for d=dstart:delays+dstart-1
            net=narnet(1:d,zeros(1,i)+n);
            
            net.trainfcn='trainlm';
            net.trainParam.showWindow=false;
            net.trainParam.epochs=1000;
            net.divideParam.trainRatio=0.8;
            net.divideParam.valRatio=0.2;
            net.divideParam.testRatio=0;
            
            net=train(net,x(1:trainSize),x(1:trainSize));
            nets{i-lstart+1,n-nstart+1,d-dstart+1,r}=net;
            
            err{i-lstart+1,n-nstart+1,d-dstart+1,r}=perform(net,x(trainSize+1:end),sim(net,x(trainSize+1:end)));
            coefs{i-lstart+1,n-nstart+1,d-dstart+1,r}=corrcoef(cell2mat(x(trainSize+1:end)),cell2mat(sim(net,x(trainSize+1:end))));
            coefs{i-lstart+1,n-nstart+1,d-dstart+1,r}=coefs{i-lstart+1,n-nstart+1,d-dstart+1,r}(2);

            
            c=c+1;
            c+"/"+layers*neurons*delays*reps
            plotresponse(x(trainSize+1:end),sim(net,x(trainSize+1:end),x(trainSize-d+1:trainSize)))
        end
    end
end
end
avgerr=cell(layers,neurons,delays);
avgcoefs=avgerr;
for i=1:layers
    for n=1:neurons
        for d=1:delays
            avgerr{i,n,d}=sum(cell2mat(err(i,n,d)))/reps;
            avgcoefs{i,n,d}=sum(cell2mat(coefs(i,n,d)))/reps;
        end
    end
end
a=zeros(1,layers*neurons*delays);
b=a;
c=a;
e=a;
g=0;
for i=1:layers
    for n=1:neurons
        for d=1:delays
            g=g+1;
            a(g)=i;
            b(g)=n;
            c(g)=d;
            e(g)=avgerr{i,n,d};
        end
    end
end
clear('i','n','d','g','r');
clear('layers','neurons','nstart','delays','net','lstart','dstart','trainSize');
clear('err','coefs');