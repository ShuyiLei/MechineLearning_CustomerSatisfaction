library(xgboost)
library(Matrix)

set.seed(1234)

train <- read.csv("./data/newtrain.csv")
test  <- read.csv("./data/newtest.csv")
test.id <-read.csv("./data/testID.csv")
tc <- test

##### Extracting TARGET
train.y <- train$TARGET
train$TARGET <- NULL

tc <- test #to generate auc
train$TARGET <- train.y


train <- sparse.model.matrix(TARGET ~ ., data = train)

dtrain <- xgb.DMatrix(data=train, label=train.y)
watchlist <- list(train=dtrain)

param <- list(  objective           = "binary:logistic", 
                booster             = "gbtree",
                eval_metric         = "auc",
                eta                 = 0.0202048,
                max_depth           = 5,
                subsample           = 0.6815,
                colsample_bytree    = 0.701
)

clf <- xgb.train(   params              = param, 
                    data                = dtrain, 
                    nrounds             = 560, 
                    verbose             = 1,
                    watchlist           = watchlist,
                    maximize            = FALSE
)


#######actual variables

feature.names

test$TARGET <- -1

test <- sparse.model.matrix(TARGET ~ ., data = test)

preds <- predict(clf, test)
pred <-predict(clf,train)
AUC<-function(actual,predicted)
{
  library(pROC)
  auc<-auc(as.numeric(actual),as.numeric(predicted))
  auc 
}
AUC(train.y,pred) ##AUC

nv = tc['num_var33']+tc['saldo_medio_var33_ult3']+tc['saldo_medio_var44_hace2']+tc['saldo_medio_var44_hace3']+
tc['saldo_medio_var33_ult1']+tc['saldo_medio_var44_ult1']

#preds[nv > 0] = 0
#preds[tc['var15'] < 23] = 0
#preds[tc['saldo_medio_var5_hace2'] > 160000] = 0
#preds[tc['saldo_var33'] > 0] = 0
#preds[tc['var38'] > 3988596] = 0
#preds[tc['var21'] > 7500] = 0
#preds[tc['num_var30'] > 9] = 0
#preds[tc['num_var13_0'] > 6] = 0
#preds[tc['num_var33_0'] > 0] = 0
#preds[tc['imp_ent_var16_ult1'] > 51003] = 0
#preds[tc['imp_op_var39_comer_ult3'] > 13184] = 0
#preds[tc['saldo_medio_var5_ult3'] > 108251] = 0
#preds[(tc['var15']+tc['num_var45_hace3']+tc['num_var45_ult3']+tc['var36']) <= 24] = 0
#preds[tc['saldo_var5'] > 137615] = 0

preds[preds<0.001]=0


submission <- data.frame(ID=test.id, TARGET=preds)
cat("saving the submission file\n")
write.csv(submission, "xgb.csv", row.names = F)
