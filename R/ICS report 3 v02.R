# Clear memory
rm(list = ls())

library(readr)
library(ggplot2)
library(olsrr)
library(broom)
library(ggpubr)

bodymeasurements <- read_csv("bodymeasurements.csv", TRUE)

## Descriptive Analysis -----

summary(bodymeasurements)
bodymeasurements <- as.data.frame(bodymeasurements)
bodymeasurements

sum(is.na(bodymeasurements))
#0 missing values

drops <- c("ID")
bodymeasurements <-
  bodymeasurements[,!(names(bodymeasurements) %in% drops)]

# Descriptive analysis using scatter plot does not give much information for analysis.
weightPlt <- ggplot(bodymeasurements,
       aes(x = Weight , y = Height)) +
  geom_point() +
  xlab("Weight(Kgs)") +
  ylab("Height(cm)")

kneePlt <- ggplot(bodymeasurements,
       aes(x = Knee , y = Height)) +
  geom_point() +
  xlab("Knee(cm)") +
  ylab("Height(cm)")

wristPlt <- ggplot(bodymeasurements,
       aes(x = Wrist , y = Height)) +
  geom_point() +
  xlab("Wrist(cm)") +
  ylab("Height(cm)")

thighPlt <- ggplot(bodymeasurements,
       aes(x = Thigh , y = Height)) +
  geom_point() +
  xlab("Thigh(cm)") +
  ylab("Height(cm)")

bicepsPlt <- ggplot(bodymeasurements,
       aes(x = Biceps , y = Height)) +
  geom_point() +
  xlab("Biceps(cm)") +
  ylab("Height(cm)")

bellyPlt <- ggplot(bodymeasurements,
       aes(x = Belly , y = Height)) +
  geom_point() +
  xlab("Belly(cm)") +
  ylab("Height(cm)")

anklePlt <- ggplot(bodymeasurements,
       aes(x = Ankle , y = Height)) +
  geom_point() +
  xlab("Ankle(cm)") +
  ylab("Height(cm)")

chestPlt <- ggplot(bodymeasurements,
       aes(x = Chest , y = Height)) +
  geom_point() +
  xlab("Chest(cm)") +
  ylab("Height(cm)")

calfPlt <- ggplot(bodymeasurements,
       aes(x = Calf , y = Height)) +
  geom_point() +
  xlab("Calf(cm)") +
  ylab("Height(cm)")

agePlt <- ggplot(bodymeasurements,
       aes(x = Age , y = Height)) +
  geom_point() +
  xlab("Age(Years)") +
  ylab("Height(cm)")

figure <- ggarrange(weightPlt, kneePlt, wristPlt, thighPlt, bicepsPlt, bellyPlt, anklePlt, chestPlt, calfPlt, agePlt,
                    ncol = 5, nrow = 2)
figure

# Box plot for male and female vs height shows average height of males is greater than females
boxplot(Height ~ Sex, data = bodymeasurements, col = rainbow(ncol(trees)))
legend("topright", c("Female", "Male"), border="black", fill = c("Red", "Green"))

## Tasks 1: Data preparation ####################################################

# Make categorical variables as factors
bodymeasurements$Sex <- as.factor(bodymeasurements$Sex)

fit_model <-
  lm(Height ~ Chest + Age + Sex + Belly + Thigh + Knee + Calf + Ankle + Biceps +
       Wrist + Weight ,
     data = bodymeasurements)

summary(fit_model)


## Tasks 2: Model Section ####################################################################################################################
fullmodel <- lm(Height ~ ., data = bodymeasurements)
ols_step_best_subset(fullmodel)

#model6 best for BIC
#model8 best for AIC

#for comparison purpose only
modelFull <-
  lm(Height ~ ., data = bodymeasurements) #model with all variables
summary(modelFull)

bestBICModel <-
  lm(Height ~  Sex + Belly + Thigh + Calf + Biceps + Weight, data = bodymeasurements)

bestAICModel <-
  lm(Height ~  Chest + Sex + Belly + Thigh + Calf + Biceps + Wrist +
       Weight,
     data = bodymeasurements)

bestAICModel

# Verifying the models created from the subset selections
AIC(modelFull, bestBICModel, bestAICModel)
BIC(modelFull, bestBICModel, bestAICModel)


## Tasks 3: Estimate the "best" linear model w.r.t. the BIC #####################################################################################

bestBICModel_res = augment(bestBICModel)

# Assumptions to check for the BIC Model

# Residual plot
ggplot(bestBICModel_res, aes(x = .fitted, y = .resid)) + geom_point() + geom_hline(yintercept = 0) +
  xlab('Fitted values') + ylab('Residuals') + theme(
    axis.text = element_text(size = 16),
    axis.title = element_text(size = 16),
    plot.title = element_text(hjust = 0.5)
  ) + ggtitle('Residuals vs Fitted') #+  labs(subtitle = "Estimating through best BIC model")

# Q-Q plot
ggplot(data = bestBICModel_res, aes(sample = .std.resid)) + stat_qq() + stat_qq_line(col = 'red') +
  ylab('Standardized residuals') + xlab('Theoretical Quantiles') + ggtitle('Normal Q-Q') +
  theme(
    axis.text = element_text(size = 16),
    axis.title = element_text(size = 16),
    plot.title = element_text(hjust = 0.5)
  ) #+ labs(subtitle = "Estimating through best BIC model")

# estimating 95% confidence interval for estimated regression coefficients
round(confint(bestBICModel, level = 0.95), 2)

#goodness of fit: R2
R2 <- summary(bestBICModel)[["r.squared"]]
R2
