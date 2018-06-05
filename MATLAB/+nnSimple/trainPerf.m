function [trainPerf,trainN] = trainPerf(net,data,hints)

% Copyright 2012 The MathWorks, Inc.
"ran nnsimple.trainperf";
%assignin('base','outstruct',net)
%[trainPerf,trainN] =nnSimple.perfs(net,data,{data.train.mask},hints);%this is the only
%original line
%trainPerf is the sum of the squared errors
%trainN is the number of training points
trainN=size(data.T{1},2);
%actualNet=struct2net(net);%converts the input struct into an actual network object, allowing the next line to work
%above is obsolete with the use of networkFunction, a struct is faster. 
%the following extrapolaiton is a single, continuous one. this needs to be
%modified to be an nth extrapolation.
%extra=extrapolateWithNet(size(data.T{1},2)-net.numInputDelays,num2cell(data.T{1}(1:net.numInputDelays)),actualNet);
length=evalin('base','extrapolateDepth');
extra=nthExtrapolate(length,data.T{1},net,false);
trainPerf=sum((extra-data.T{1}(net.numInputDelays+length:end-1)).^2);
"done";
