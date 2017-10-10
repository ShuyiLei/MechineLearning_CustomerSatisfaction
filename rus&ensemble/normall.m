function [output] = normall(input)
[temp,~,ic] = unique(input);
[~,I] = sort(temp);
[~,temp1] = sort(I);
output = temp1(ic);
output = output/length(temp1);
end

