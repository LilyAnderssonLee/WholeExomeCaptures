install.packages("randomForest")
library(randomForest)

#prepare trainning data set: PM and individuals with certain location
#prepare testing data set

###decide how many pcs will be used to predict genentic clusters
rf<-randomForest(genetic_cluster~.,data = trainning_dataset,mtry=4,ntre=20001,importance=T) 

rf  ###check the error rate which also means the accuracy of the prediction

plot(rf)  ###check the convergence of ntrees

result<-data.frame(testing_dataset$genetic_cluster,
                   predict(rf,testing_dataset_pcs),type="response")



