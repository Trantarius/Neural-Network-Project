%extrapolates data past the final known timestep by feeding outputs back
%into the network
%tests a network object named "net"
%the first delay states given to it are "xi", it will produce delay states
%beyond the first ones
function [out]=extrapolateWithNet(reps,xi,net)
    for r=1:reps
        [pred, xi]=sim(net,1,xi);
        xi(end)=num2cell(pred);
        if r==1
            out=pred;
        else
            out=horzcat(out,pred);
        end
    end
end