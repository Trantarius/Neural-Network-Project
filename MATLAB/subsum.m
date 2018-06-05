function [out] = subsum(dailyData,period)
%This will make each data point the sum of the previous n data points (n is
%the period). this is a moving average. the timestep does
%not change, the resulting length of the data will be:
%original length - period
%Data must be a matrix with a new timestep in each column
out=sum(dailyData(1:end,1:period)')';
for n=period+1:size(dailyData,2)
    out=horzcat(out,sum(dailyData(1:end,n-period+1:n)')');
end
end

