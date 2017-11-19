# Patents-and-Lexical-diversity
Does a better vocabulary influence the chances of a patent being granted? 
In order to assess the richness of vocabulary differences 9 sets of data were downloaded from the EPO database, accessed via the patent search engine Global Patent Index (EPO Patent information services for experts)
Each original set of data contained 50 patents filed by European applicants from a non English speaking country to the USPTO
The patents had been published between 2005 and 2008, taking into account that the average patent processing time in USPTO is of four years by the day in which the information on the USPTO filed patents was obtained the vast majority of them will have reached an issued (granted) or non issued decission.
The search string for Germany was:
((PRC AND APPC) = DE) AND (PUC = US) AND PUD>20050101 AND PUD<20080101
Where PRC means priority country, APPC means applicant country, PUC publication country and PUD publication date

The 9 sets of data were joined in one file resultlist.csv

The number of 50 applications per country was dictated by the necessity of using a similar number for each country, where there are countries like Germany that in the period considered published above 30 0000 applications there are others like Hungary that filed 53. 

The patent application abstracts (between 100 and 150 words as average) were analized by the textstat_lexdiv function (quanteda package) and the following indexes were obtained for each patent document: Type-Token Ratio (TTR), Herand C, Giraud's Root and Dugast's Uber Index

The population of patents was separated in two groups Yes and No (granted patent)

H0 (null hypothesys) the median lexical diversity values is the same in granted and non granted patents

HA (alternative hypothesys) the medians are signifiantly different

A confidence level of 95%, alpha = 0,05 was used to reject or not the null hypothesys.

In order to apply t.test to the lexical diversity index populations obtained it was first assessed their normality by the Shapiro  test.

The results of the tests are written as R comments (after #) in the R files attached to this github branch

