%this runs extrapolateWithNet(...) multiple times, to develop multiple
%samples of short extrapolations. "actual" is the dataset to be predicted,
%which it will use to form the initial delays xi for
%extrapolateWithNet(...). length is the number of points predicted by each
%extrapolation, reps is the number of extrapolations performed.
function [out,ref,r] = repeatExtrapolate(length,reps,actual,net,willPlot)
    out=[];
    for n=1:reps
        xi=actual(1+length*(n-1):(1+length*(n-1))+net.numInputDelays-1);
        out=horzcat(out,extrapolateWithNet(length,num2cell(xi),net));
    end
    ref=[];
    for n=1:reps
        if mod(n,2)==0
            ref=horzcat(ref,-1000000:-1000000+(length-1));
        else
            ref=horzcat(ref,1000000:1000000+(length-1));
        end
    end
    
    if(willPlot)
        plot(actual(net.numInputDelays+1:length*reps+net.numInputDelays+1))
        hold on
        plot(out)
        hold on
        plot(ref)
        axis([0 size(out,2) min(actual) max(actual)])
    end
    r=corrcoef(out,actual(1+net.numInputDelays:size(out,2)+net.numInputDelays));
end