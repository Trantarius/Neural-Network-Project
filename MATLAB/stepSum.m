function [out] = stepSum(data,period)
%This function creates periodic sums and generates consecutive,
%non-intersecting sums. each sum corresponds to a period of specified
%length. the length of the results will be:
%floor(original length / period)
%Data must be a matrix with a new timestep in each column.
%Incomplete periods will be truncated from the end.
data=data';
out=sum(data(1:period,1:end));
for n=2:floor(size(data,1)/period)
    out=vertcat(out,sum(data((n-1)*period+1:n*period,1:end)));
end
out=out';
end

