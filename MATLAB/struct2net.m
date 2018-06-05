%this will be used in trainPerf.m to convert the network struct into an
%actual network. this should allow it to be used in extrapolateWithNet.m to
%create the extrapolated prediction
%thus far, all testing has been done with a version of samplenet that has
%been trained on the same data that the eventual network will be trained
%on
function [out]=struct2net(in)
    out=evalin('base','samplenet');%samplenet must exist in the workspace, 
    %and have been created with the same line as the original network. it
    %should be trained to create usable sample parameters, though the
    %results of this training are arbitrary.
    
    out.name='output network';
    out.efficiency=in.efficiency;
    out.userdata=in.userdata;
    out.numInputs=in.numInputs;
    out.numLayers=in.numLayers;
    %out.numOutputs=in.numOutputs;%doesn't work, though it is unneccessary
    %if using the samplenet approach
    %out.numInputDelays=in.numInputDelays;%ditto
    %out.numLayerDelays=in.numLayerDelays;%ditto
    %out.numFeedbackDelays=in.numFeedbackDelays;%ditto
    %out.numWeightElements=in.numWeightElements;%ditto
    out.sampleTime=in.sampleTime;
    out.biasConnect=in.biasConnect;
    out.inputConnect=in.inputConnect;
    out.layerConnect=in.layerConnect;
    out.outputConnect=in.outputConnect;
    %out.inputs{1}=in.inputs{1};%expansion net necessary, 
    %out.layers=in.layers;%ditto
    %out.biases=in.biases;%ditto
    %out.outputs=in.outputs;%ditto
    %out.inputWeights=in.inputWeights;%ditto
    %out.layerWeights=in.layerWeights;%ditto
    out.adaptFcn=in.adaptFcn;
    out.adaptParam=in.adaptParam;
    out.divideFcn=in.divideFcn;
    out.divideParam=in.divideParam;
    out.divideMode=in.divideMode;
    out.initFcn=in.initFcn;
    out.performFcn=in.performFcn;
    out.performParam=in.performParam;
    out.plotFcns=in.plotFcns;
    out.plotParams=in.plotParams;
    out.derivFcn=in.derivFcn;
    out.trainFcn=in.trainFcn;
    out.trainParam=in.trainParam;
    out.IW=in.IW;
    out.LW=in.LW;
    out.b=in.b;
    %out.revert=in.revert;%apparently does not exist in newly created
    %networks
    %out.gradientFcn=in.gradientFcn;%obsolete
    %out.gradientParam=in.gradientParam;%obsolete
end