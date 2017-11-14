# Patents-and-Lexical-diversity
Does a better vocabulary influence the chances of a patent being granted? 
In order to assess the richness of vocabulary differences 9 sets of data were downloaded from the EPO database, accessed via the patent search engine Global Patent Index (EPO Patent information services for experts)
Each set of data contains 50 patents filed by European applicants from a non English speaking country to the USPTO
The patents had been published between 2005 and 2008, taking into account that the average patent processing time in USPTO is of four years by the day in which the information on the USPTO filed patents was obtained the vast majority of them will have reached an issued (granted) or non issued decission.
The search string for Germany was:
((PRC AND APPC) = DE) AND (PUC = US) AND PUD>20050101 AND PUD<20080101
Where PRC means priority country, APPC means applicant country, PUC publication country and PUD publication date

The number of 50 applications per country was dictated by the necessity of using a similar number for each country, where there are countries like Germany that in the period considered published above 30 0000 applications there are others like Hungary that filed 53. 
The patent application abstracts (between 100 and 150 words as average) were analized by the textstat_lexdiv function (quanteda package) and the following indexes were obtained for each patent document: Type-Token Ratio (TTR), Herand C, Giraud's Root and Dugast's Uber Index

The population of patents was separated in two groups Yes and No (granted patent)
H0 (null hypothesys) the median lexical diversity values is the same in granted and non granted patents
HA (alternative hypothesys) the medians are signifiantly different
A confidence level of 95%, alpha = 0,05 was used to reject or not the null hypothesys.
In order to apply t.test to the lexical diversity index populations obtained it was first assessed their normality by the Shapiro  test.
Two of the lexical diversity indexes, TTR and Uber Index didn't present normal populations reason why they were not taken into account.
Normality test Results

shapiro.test(Granted$HerdanC) 	   #  p-value = 0.1579 

shapiro.test(NonGranted$HerdanC)   #  p-value = 0.07579

shapiro.test(Granted$TTR)	         #  p-value = 0.02253  /bellow the 0.05 significance level

shapiro.test(NonGranted$TTR)	     #  p-value = 0.05392  /close to the 0.05 significance level

shapiro.test(Granted$GuiraudR)	   #  p-value = 0.4138

shapiro.test(NonGranted$GuiraudR)  #  p-value = 0.5529

shapiro.test(Granted$UberIndex)    #  p-value < 2.2e-16  /way bellow the 0.05 significance level

shapiro.test(NonGranted$UberIndex) #  p-value < 2.2e-16  /way bellow the 0.05 significance level

T tests on the Herand C and Guiraud Root index populations

t.test(HerdanC vs Granted)  # p-value = 0.1082, no difference can be proven between granted and non granted patents in lexical diversity

t.test(GuiraudR vs Granted) # p-value = 0.4659, no difference can be proven between granted and non granted patents in lexical diversity

