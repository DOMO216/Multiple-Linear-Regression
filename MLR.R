# Importing Data
dataset1 = read.csv("Documents/Machine Learning A-Z (Codes and Datasets)/Part 2 - Regression/Section 5 - Multiple Linear Regression/R/50_Startups.csv")

# Encoding Categorical data
dataset1$State = factor(dataset1$State,
                        levels = c('New York','California','Florida'),
                        labels = c(0,1,2))

# Splitting data into Training and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset1$Profit,SplitRatio=0.8)
training_set = subset(dataset1,split==TRUE)
test_set = subset(dataset1,split==FALSE)

# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State)

# shorter method
regressor = lm(formula = Profit ~ .,
               data = training_set)

# Predicting the Test set results 
y_pred = predict(regressor, newdata = test_set)


# Building the optimal model using Backward Elimination
# Step 1: Select a significance level(5%)

# Step 2:
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend + State,
               data = dataset1)

summary(regressor)

# Step 3:Consider the predictor with the highest p-value 
# The state has the highest p-value which makes it 
# statistically insignificant

# Step 4:Remove the predictor(dummy variable)
# removing the state variable from the equation

# Step 5:fit the model without the dummy variable
regressor = lm(formula = Profit ~ R.D.Spend + Administration + Marketing.Spend,
               data = dataset1)

summary(regressor)

# back to step 3: Administration has the highest p-value and 
# it is statistically insignificant

# step 4: removing the Administration Variable

# Step 5:
regressor = lm(formula = Profit ~ R.D.Spend + Marketing.Spend,
               data = dataset1)

summary(regressor)

# back to step 3: Marketing spend has the highest p-value and 
# it is statistically insignificant
# Or we can keep it because its between 5% and 10% which makes it
# slightly significant

# step 4: removing the Marketing Spend Variable

# Step 5:
regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset1)

summary(regressor)

