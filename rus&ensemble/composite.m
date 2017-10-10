function [ ] = composite(savefilename,varargin)
%composite(filename, list of filenames
%This function will composite serveral tables and generate one file
%acording the name of filename
  nVarargs = length(varargin);
  table = readtable(varargin{1});
  id = table.ID;
  target = normall(table.TARGET);
  for k = 2:nVarargs
    table = readtable(varargin{k}); 
    target = target + normall(table.TARGET);
  end
  target = target/nVarargs;
  target(target<0.0001)=0; %This is to avoid scientic 
  newdata = array2table([id target],'VariableNames',{'ID','TARGET'});
  writetable(newdata,savefilename); 
end

