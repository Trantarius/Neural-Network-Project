%extrapolates data past the final known timestep by feeding outputs back
%into the network
%tests a network object named "net"
%the first delay states given to it are "xi", it will produce delay states
%beyond the first ones
function [out]=extrapolateWithNet(reps,xi,net)
    out=zeros(1,reps);
    for r=1:reps
        %pred=net(1,xi);
        pred=networkFunction(net,xi);
        xi=horzcat(xi(2:end),pred);
        out(r)=pred;
    end
end