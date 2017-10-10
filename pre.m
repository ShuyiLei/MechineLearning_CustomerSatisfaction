%% Read from file
train = readtable('data/train.csv');
test = readtable('data/test.csv');

%% Remove ID from table
testID = test.ID;
train.ID =[];
test.ID = [];

%% Temporily remove TARGET from table
trainTARGET = train.TARGET;
train.TARGET = [];

%% Count Zero
%count0 = @(x) numel(x)-nnz(x);
temp1 = rowfun(@countz,train);
temp2 = rowfun(@countz,test);
train.numof0 = table2array(temp1);
test.numof0 = table2array(temp2);

%% Remove constant variable 
trainM = table2array(train);
testM = table2array(test);
traintitle = train.Properties.VariableNames;
[trainM1,PS] = removeconstantrows(trainM.');
testM1 = removeconstantrows('apply',testM.',PS);
traintitle1 = traintitle(PS.keep);

%% Remowe dump variable 
[trainM2,ia,ic] = unique(trainM1,'rows');
testM2 = testM1(ia,:);
traintitle2 = traintitle1(ia);

%% Restore to table
newtrain= [array2table(trainM2.','VariableNames',traintitle2) ,array2table(trainTARGET,'VariableNames',{'TARGET'})];
newtest = array2table(testM2.','VariableNames',traintitle2) ;
testID = array2table(testID,'VariableNames',{'ID'}); 

%% Log
newtrain.var38 = log(newtrain.var38);
newtest.var38 = log(newtest.var38);
%% Save to file
writetable(newtrain,'data/newtrain.csv');
writetable(newtest,'data/newtest.csv');
writetable(testID,'data/testID.csv');
