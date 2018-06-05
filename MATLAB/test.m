reps=10;
perfs=cell(reps,20);
rvals=perfs;
trainsize=0.8;
for r=1:reps
for n=1:20
    extrapolateDepth=n;
    x=subsum(data,n);
    x=x./n;
    net=narnet(1:3,[6 6]);
    net.trainfcn='trainscg';
    net.trainParam.showWindow=false;
    net=train(net,num2cell(x(1:floor(size(x,2)*trainsize))),num2cell(x(1:floor(trainsize*size(x,2)))),nnSimple);
    perfs{r,n}=perform(net,num2cell(x(floor(trainsize*size(x,2))+1:end)),net(num2cell(x(floor(trainsize*size(x,2)+1):end)),num2cell(x(floor(trainsize*size(x,2))-(3-1):floor(trainsize*size(x,2))))));
    (r-1)*20+n+"/"+reps*20
    %plotresponse(num2cell(x(trainsize+1:end)),net(num2cell(x(trainsize+1:end)),num2cell(x(trainsize-(3-1):trainsize))))
end
end
avgperfs=cell(1,20);
maxperfs=avgperfs;
minperfs=avgperfs;
for n=1:20
    avgperfs{n}=sum(cell2mat(perfs(:,n)))/reps;
    maxperfs{n}=max(cell2mat(perfs(:,n)));
    minperfs{n}=min(cell2mat(perfs(:,n)));
end
p=cell2mat(perfs);
mi=cell2mat(minperfs);
ma=cell2mat(maxperfs);