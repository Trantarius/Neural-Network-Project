regperfs=zeros(1,5);
for n=1:5
    regperfs(n)=perform(nets{n},x,nets{n}(x));
end