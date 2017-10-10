%% Read from file
train = readtable('data/newtrain.csv');
test = readtable('data/newtest.csv');
testID = readtable('data/testID.csv');

%% Train
[trainedClassifier1, validationAccuracy1]  = RusBoostClassifier1(train);

%% Get Predict
[cl,score] = trainedClassifier.predictFcn(test);

%%
newscore=score(:,2)./(score(:,1)+score(:,2));
newscore(newscore(:)<=0.0001)=0;
result= [testID array2table(newscore,'VariableNames',{'TARGET'})];
writetable(result,'rus300.csv');

%% final 
composite('ensxgbclr300.csv','rus300.csv','xgbcl.csv');
