%this will extrapolate multiple times, and each output will be the

%prediction of the nth timestep after actual data ceases to be applied
function [out,perf,R,comparable]=nthExtrapolate(length,actual,net,willPlot)
    out=zeros(1,size(actual,2)-net.numInputDelays-length);
    parfor n=1:size(actual,2)-net.numInputDelays-length
        a=extrapolateWithNet(length,num2cell(actual(n:n+net.numInputDelays-1)),net);
        out(n)=a(end);
    end
    if willPlot
        %plot(actual(net.numInputDelays+length:end-1))
        %hold on
        %plot(out)
        plotresponse(num2cell(actual(net.numInputDelays+length:end-1)),num2cell(out));
        perf=sum((actual(net.numInputDelays+length:end-1)-out).^2);
        R=corrcoef(actual(net.numInputDelays+length:end-1),out);
        comparable=actual(net.numInputDelays+length:end-1);
    end
end