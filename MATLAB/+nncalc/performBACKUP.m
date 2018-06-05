function [perf] = perform(net,t,y,ew,param)

% Copyright 2012 The MathWorks, Inc.

%y=num2cell(nthExtrapolate(net.numInputDelays,cell2mat(t),net,false));%hijack lines
%t=t(net.numInputDelays+net.numInputDelays:end-1);
"ran-"


if ~iscell(t), t={t}; end
if ~iscell(y), y={y}; end%y is the output of the network
if ~iscell(ew), ew={ew}; end

% Performance Function
info = feval(net.performFcn,'info');
if nargin < 5
  param = net.performParam;
end

% Error
e=gsubtract(y,t);

% Normalized Error
switch param.normalization
  case 'none', % no change required
  case 'standard', e = nnperf.norm_err(net,e);
  case 'percent', e = nnperf.perc_err(net,e);
end

% Standard Performance
perfs = cell(size(e));

for i=1:numel(perfs)
  perfs{i} = info.apply(t{i},y{i},e{i},param);%this puts the squared errors
end
perfs = gmultiply(perfs,ew);%this line weights them
perf = 0;
perfN = 0;
for i=1:numel(perfs)
  perfi = perfs{i};
  nanInd = find(isnan(perfi));
  perfi(nanInd) = 0;
  perf = perf + sum(perfi(:));
  perfN = perfN + numel(perfi) - numel(nanInd);
end
if info.normalize
  perf = perf / perfN;
end

%Regularization
reg = param.regularization;
if (reg ~= 0)
  wb = getwb(net);
  perfwb = info.apply(zeros(size(wb)),wb,-wb,param);
  if info.normalize, perfwb = perfwb / numel(wb); end
  perf = perf * (1-reg) + sum(perfwb) * reg;
end
