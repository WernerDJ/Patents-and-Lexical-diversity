

#The tests will be now applied to compare the patents with 20% lower vocabulary diversity indexes with the ones with 20% higher indexes
#The data will be re ordered for each index.
#The new sample will have 176 patent documents. (The 88 lower ranking patents + the 88 higher)
#In this case, a Chi square test would be indicated
pie(summary(resultlist$Granted), labels = (summary(resultlist$Granted)), col = topo.colors(length(summary(resultlist$Granted))), 	main="Granted vs Non Granted patents")
legend("topright", names(summary(resultlist$Granted)), cex = 0.8, fill = topo.colors(length(summary(resultlist$Granted))))
#..................................................
#..............**Granted**Non Granted**
#.........*********************************
#.........*Low**    W   **     X    ** W+X
#.........*********************************
#.........*High*    Y   **     Z    ** Y+Z
#.........*********************************
#.........     *  W + Y **   X + Z  **
#.................................................
#H0 No association between the variables Lexical Index (low, high) and Granted patent
#HA there is association between both variables
#
#NA values eliminated
#Tests
#
# Herdan C Index
#
	HC <- LexicalDiv[order(HerdanC),] 
	HC <- HC[is.finite(HC$HerdanC), ]
	HC[1:88,11] <- "low"
	HC[(nrow(HC)-87):(nrow(HC)),11] <- "high"
	HC <- HC[complete.cases(HC), ]
chisq.test(HC$Granted, HC$V11, correct=FALSE) #X-squared = 3.3347, df = 1, p-value = 0.06783
t.test(HC$HerdanC~HC$Granted)       # p-value =0.08382 (with a confidence level of 90% H0 would be rejected in both tests)
boxplot(HC$HerdanC~HC$Granted, xlab="Granted", ylab="Herand C")
# Calculate the means of Non granted and Granted Herdan C Indexes
aggregate(HC$HerdanC, list(HC$Granted), mean)
# Non granted mean 	= 0.8995965
# Granted mean 		= 0.8806790
#
# Type-Token Ratio Index
#
	TTRS <- LexicalDiv[order(TTR),] 
	TTRS <- TTRS[is.finite(TTRS$TTR), ]
	TTRS[1:88,11] <- "low"
	TTRS[(nrow(TTRS)-87):(nrow(TTRS)),11] <- "high"
	TTRS <- TTRS[complete.cases(TTRS), ]
chisq.test(TTRS$Granted, TTRS$V11, correct=FALSE) #X-squared = 3.3846, df = 1, p-value = 0.0658
wilcox.test(TTRS$TTR~TTRS$Granted)  #p-value = 0.07242
t.test(TTRS$TTR~TTRS$Granted)		#p-value = 0.05667 (with a confidence level of 90% H0 would be rejected in the three tests)
boxplot(TTRS$TTR~TTRS$Granted, xlab="Granted", ylab="Type-Token Ratio")
# Calculate the means of Non granted and Granted Type-Token Ratio Indexes
aggregate(TTRS$TTR, list(TTRS$Granted), mean)
# Non granted mean 	= 0.6899532
# Granted mean 		= 0.6278951
#
# Giraud's Root Index
#
	GR <- LexicalDiv[order(GuiraudR),] 
	GR <- GR[is.finite(GR$GuiraudR), ]
	GR[1:88,11] <- "low"
	GR[(nrow(GR)-87):(nrow(GR)),11] <- "high"
	GR <- GR[complete.cases(GR), ]
	View(GR)
chisq.test(GR$Granted, GR$V11, correct=FALSE) #X-squared = 0.023088, df = 1, p-value = 0.8792
t.test(GR$GuiraudR~GR$Granted)		#p-value = 0.7856
boxplot(GR$GuiraudR~GR$Granted, xlab="Granted", ylab="Giraud's Root")
# Calculate the means of Non granted and Granted Guiraud R Indexes
aggregate(GR$GuiraudR, list(GR$Granted), mean)
# Non granted mean 	= 5.049695
# Granted mean 		= 4.990261
#
# Dugast's Uber Index
#
	UI <- LexicalDiv[order(UberIndex),] 
	UI <- UI[is.finite(UI$UberIndex), ]
	UI[1:88,11] <- "low"
	UI[(nrow(UI)-87):(nrow(UI)),11] <- "high"
	UI <- UI[complete.cases(UI), ]
	View(UI)
chisq.test(UI$Granted, UI$V11, correct=FALSE) #X-squared = 2.3025, df = 1, p-value = 0.1292
wilcox.test(UI$UberIndex~UI$Granted) #p-value = 0.2622
boxplot(UI$UberIndex~UI$Granted, xlab="Granted", ylab="Uber Index")
# Calculate the means of Non granted and Granted Dugast's Uber Indexes
aggregate(UI$UberIndex, list(UI$Granted), mean)
# Non granted mean 	= 30.09606
# Granted mean 		= 22.32343