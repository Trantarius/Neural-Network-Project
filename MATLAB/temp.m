%will determine best x-translation to make the data match up.
for r=1:10
    multiTrain
    [extra,~,~,actual]=nthExtrapolate(7,cell2mat(x),extranets{1},true);

    newextra=zeros(1,size(extra,2)-40);
    perfs=zeros(1,41);
    for n=-20:20
        for i=1:size(extra,2)-40
            newextra(i)=extra(i+20+n);
        end
        perfs(n+21)=sum((newextra-actual(21:end-20)).^2);
    end
end