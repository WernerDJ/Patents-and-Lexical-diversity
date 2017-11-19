#Text minig the patent abstracts
#
# First load the package quanteda
#
library(quanteda)
#
# load the data from the dierectory where it was saved (remember to change the \ in the path string by / if you copy paste the path)
# Cluster sampling was used to avoid over representation from more prolifict patenting countries affecting the lexical diversity measures
# 50 aleatory patents from 9 European non English speaking Cuntries
#
resultlist <- read.csv("C:/Users/Chupacabras/Dropbox/datamining/EPO_Language/resultlist.csv", sep=";")
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
	LexicalDiv$TTR[fila] <- as.double(statis[1])
	LexicalDiv$HerdanC[fila] <- as.double(statis[2])
	LexicalDiv$GuiraudR[fila] <- as.double(statis[3])
	LexicalDiv$UberIndex[fila] <- as.double(statis[5])
}
# The decimal separator "." might give problems in computers with an american decimal system in which "," is the standard
# If that is the case, just delete (, dec = ".") from the following line
write.table(LexicalDiv,file = "c:/Users/Chupacabras/Dropbox/datamining/EPO_Language/LexicalDiv.csv",row.names=FALSE, dec = ".")
