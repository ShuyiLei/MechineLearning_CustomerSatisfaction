function [ output ] = countz( varargin)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
 output =0;
  nVarargs = length(varargin);
   for k = 1:nVarargs
       if varargin{k} == 0
           output = output +1;
       end
    end

end

