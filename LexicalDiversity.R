#Text minig the patent abstracts
#
# First load the package quanteda
#
library(quanteda)
#
# load the data from the dierectory where it was saved (remember to change the \ in the path string by / if you copy paste the path)
#
resultlist <- read.csv("C:/..../resultlist.csv", sep=";")
#
# Change the column names that have uncofortable names in the downloaded GPI csv file
#
names(resultlist)[1]<- "Patent"
names(resultlist)[2]<- "Inventors"
names(resultlist)[3]<- "ApplicantCountry"
names(resultlist)[4]<- "Abstract"
names(resultlist)[5]<- "CPCs"
names(resultlist)[6]<- "Granted"
#
# Create a new data frame where the Inventors names will be substituted by a the number of inventors per patent, and Granted will be 1 or 0 instead of YES or NO
# and the lexical variety indexes will be stored
# The lexical variety indexes are Type-Token Ratio (TTR), Herand C, Giraud's Root and Dugast's Uber Index
#
n <- nrow(resultlist)
x <- data.frame("Granted" = rep(0, n), "NInventors" = rep(0, n), "TTR"=rep(0, n), "HerdanC" = rep(0, n), "GuiraudR" = rep(0, n), "UberIndex" = rep(0, n))
#
LexicalDiv <- cbind(resultlist, x)
LexicalDiv <- LexicalDiv[,-2]
LexicalDiv <- LexicalDiv[,-5]
names(LexicalDiv)[5]<- "Granted"
#
# Obtain the data on lexical diversity
#
for (fila in 1:n) {
	if (resultlist$Granted[fila] == "YES") 
		{
		LexicalDiv$Granted[fila] <- 1
		}
	LexicalDiv$NInventors[fila]<- length(strsplit(as.character(resultlist[[2]][fila]), '\n')[[1]])
	mydfm <- as.vector(LexicalDiv$Abstract[fila])
	myCorpus <- corpus(mydfm)
	myDfm <- dfm(myCorpus)
	myStemMat <- dfm(myCorpus, remove = stopwords("english"), stem = TRUE, remove_punct = TRUE)
	statis <-textstat_lexdiv(myStemMat, measure = c("all", "TTR", "C", "R", "CTTR", "U", "S","Maas"), log.base = 10, drop = TRUE)
	LexicalDiv$TTR[fila] <- as.numeric(statis[1])
	LexicalDiv$HerdanC[fila] <- as.numeric(statis[2])
	LexicalDiv$GuiraudR[fila] <- as.numeric(statis[3])
	LexicalDiv$UberIndex[fila] <- as.numeric(statis[5])
}
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
#
shapiro.test(Granted$HerdanC) 	   #  p-value = 0.1579
shapiro.test(NonGranted$HerdanC)   #  p-value = 0.07579
shapiro.test(Granted$TTR)	   	   #  p-value = 0.02253
shapiro.test(NonGranted$TTR)	   #  p-value = 0.05392
shapiro.test(Granted$GuiraudR)	   #  p-value = 0.4138
shapiro.test(NonGranted$GuiraudR)  #  p-value = 0.5529
#
# for UberIndex it is necessary to eliminate non computable values
UbGranted <- UberInd[UberInd$Granted==1, ]
UbNonGranted <- UberInd[UberInd$Granted==0, ]
#
shapiro.test(UbGranted$UberIndex)   #  p-value < 2.2e-16
shapiro.test(UbNonGranted$UberIndex)#  p-value < 2.2e-16
#
#Normal Q-Q plot, applied on the indexes populations gives a visual confirmation on the normality on non normality of the populations
qqnorm(Granted$TTR)

