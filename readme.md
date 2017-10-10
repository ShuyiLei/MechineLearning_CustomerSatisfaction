pre.m is the preprocessed script. All methods used pre.m before building a model. It calls countz.m to generate a new feature.

In xgboost folder, there is the R script for XGBoost. It is a clean version with feature engineering commented out. 
Run pre.m first to get preprocessed data.

In rus&ensemble folder, there are several scripts. 
RUS.m is to generate the result of RUSBoost method. It also calls composite() to generate the result of ensemble methods. 
composite.m is used in ensemble method, it take target filename and multiple CSVs as parameters, combine them using the strategy in the experiment part. 
It calls normall.m to ¡°normalizing¡± single CSV by sorting and ranking.