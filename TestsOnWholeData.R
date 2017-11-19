attach(LexicalDiv)
#
# The Uber Index test gives out a few non numerical results in form of a text "Inf" that has to be deleted in orther to perform the tests.
#
UberInd <- LexicalDiv[LexicalDiv$UberIndex!="Inf", ]
#
# t.tests on the Granted vs non granted populations
# H0 the median of vocabulary diversity is the same in granted and non granted patents, with a 95% significance
# HA the medians are different
#
t.test(HerdanC~Granted)  # p-value = 0.1082, no difference can be proven between granted and non granted patents in lexical diversity
t.test(TTR~Granted)      # p-value = 0.1052, no difference exists
t.test(GuiraudR~Granted) # p-value = 0.4659, no difference can be proven between granted and non granted patents in lexical diversity
# The Uber Index test doesn't compute all the abstracts, in some cases the result is an "Inf" value that the t.test cannot compute. Since they are a small
# fraction of the results eliminating the affected rows shouldn't affect the result
#
UberInd <- LexicalDiv[LexicalDiv$UberIndex!="Inf", ]
t.test(UberInd$UberIndex~UberInd$Granted) # p-value = 0.047 the populations are different, altough the p-value is very close to the value 0,05
#
#
#Normality test  Shapiro-Wilk
#First the Granted non granted population will be separated, then the test of normalities will be applied to the vocabulary diversity results
#
Granted <- LexicalDiv[LexicalDiv$Granted==1, ]
NonGranted <- LexicalDiv[LexicalDiv$Granted==0, ]
par(mfrow=c(1,2))
boxplot(as.numeric(Granted$GuiraudR),ylim=c(0,10), xlab="Granted Patents", ylab="Guiraud Root")
boxplot(as.numeric(NonGranted$GuiraudR),ylim=c(0,10), xlab="NonGranted Patents", ylab="Guiraud Root")

hist(Granted$TTR, xlim = c(0,1))
hist(NonGranted$TTR, xlim = c(0,1))

#
shapiro.test(Granted$HerdanC) 	   #  p-value = 0.1579
shapiro.test(NonGranted$HerdanC)   #  p-value = 0.07579
shapiro.test(Granted$TTR)	   	   #  p-value = 0.02253
shapiro.test(NonGranted$TTR)	   #  p-value = 0.05392
shapiro.test(Granted$GuiraudR)	   #  p-value = 0.4138
shapiro.test(NonGranted$GuiraudR)  #  p-value = 0.5529
#
#Further check the normality of the TTR distribution by a Q-Q plot
qqnorm(Granted$TTR)
qqnorm(NonGranted$TTR)
#
# for UberIndex it is necessary to eliminate non computable values
UbGranted <- UberInd[UberInd$Granted==1, ]
UbNonGranted <- UberInd[UberInd$Granted==0, ]
#
shapiro.test(UbGranted$UberIndex)   #  p-value < 2.2e-16
shapiro.test(UbNonGranted$UberIndex)#  p-value < 2.2e-16
wilcox.test(UbGranted$UberIndex, UbNonGranted$UberIndex) #p-value = 0.2413, the diference in data population distributions is not significant at a 95% significance level

#
#Normal Q-Q plot, applied on the indexes populations gives a visual confirmation on the normality on non normality of the populations
qqnorm(Granted$TTR)

# Check if the granted and non-granted samples of the patent documents show any difference in the average numbero of inventors
# Let's see first the viusal characteristics
hist(NInventors, breaks = 17, xlim = c(0,17), xlab="Granted Patents", ylab="Number of Inventors")
par(mfrow=c(1,2))
hist(Granted$NInventors,ylim=c(0,120), xlab="Granted Patents", ylab="Number of Inventors")
hist(NonGranted$NInventors,ylim=c(0,120), xlab="NonGranted Patents", ylab="Number of Inventors")
# There appears to be differences in the distribution of the number of inventors that appear in both samples 
shapiro.test(Granted$NInventors)    #  p-value < 2.2e-16
shapiro.test(NonGranted$NInventors) # p-value = 4.572e-15
wilcox.test(Granted$NInventors, NonGranted$NInventors)  # p-value = 0.5396