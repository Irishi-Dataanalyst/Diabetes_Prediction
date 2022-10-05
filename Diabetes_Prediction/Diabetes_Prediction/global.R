library(dplyr)
library(caTools)
library(randomForest)
library(corrplot)
library(superml)
library(caret)

#Read the data
read.csv("./kaggle_diabetes.csv", stringsAsFactors = T)->df


# Rename the large variable
df %>% 
  rename(DPF=DiabetesPedigreeFunction)->df

# Replacing the 0 values from 
#['Glucose','BloodPressure','SkinThickness','Insulin','BMI'] by NaN



df$Glucose[df$Glucose==0]<-NaN
df$BloodPressure[df$BloodPressure==0]<-NaN 
df$SkinThickness[df$SkinThickness==0]<-NaN
df$Insulin[df$Insulin==0]<-NaN
df$BMI[df$BMI==0]<-NaN

# Replacing NaN value by mean, median depending upon distribution


df$Glucose[is.na(df$Glucose)]<-mean(df$Glucose,na.rm = T)
df$BloodPressure[is.na(df$BloodPressure)]<-mean(df$BloodPressure, na.rm = T)
df$SkinThickness[is.na(df$SkinThickness)]<-median(df$SkinThickness, na.rm = T)
df$Insulin[is.na(df$Insulin)]<-median(df$Insulin,na.rm = T)
df$BMI[is.na(df$BMI)]<-median(df$BMI,na.rm = T)

#changing target to factor

df$Outcome<-factor(df$Outcome,levels = c(0,1),labels = c("No, Chances are less","Yes, Chances are there"))


#splitting
sample.split(df,SplitRatio = .8)->split_tag
train<-subset(df, split_tag==T)
test<-subset(df, split_tag==F)



write.csv(train, "training.csv")
write.csv(test, "testing.csv")

train1 <- read.csv("training.csv", header = TRUE, stringsAsFactors = T)
train1<-train1[,-1]
#creating model

model<-randomForest(formula= Outcome~., data=train1,ntree=500, mtry=8, importance = TRUE)

p<-predict(model, test)
confusionMatrix(p,test$Outcome)



# Save model to RDS file
saveRDS(model, "model.rds")

